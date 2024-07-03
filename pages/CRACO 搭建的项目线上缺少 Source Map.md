---
title: CRACO 线上缺少 sourcemap 过程排查
date: 2024/04/05
Author: yuanyifan@xiaomi.com
tags:
  - craco
  - source_map
  - react
  - development
  - frontend
---

## 问题描述

![Untitled](CRACO%20%E6%90%AD%E5%BB%BA%E7%9A%84%E9%A1%B9%E7%9B%AE%E7%BA%BF%E4%B8%8A%E6%B2%A1%E6%9C%89%20Source%20Map%EF%BC%8C%E5%92%8B%E5%9B%9E%E4%BA%8B%E5%98%9E%202188e5f61fbf470e9ad576ca6024f5d6/Untitled.png)

Kibana 是前端这边常用的错误监控可视化工具，基于 APM。

不过最近发现项目本身的报错的信息都是基于压缩后的代码，不方便研发同学定位。现在目的就是为了让 source map 在生产环境能帮助排查问题，提高效率。

## 问题分析

### 流程以及因素分析

整体 source map 载入的逻辑流程：

1. CRACO 打包过程生成 source map 文件信息
2. 上传 source map 文件信息到服务器
3. 页面访问过程中自动载入 source map 文件信息

对他们做分别的影响因素的盘点：

1. CRACO 打包过程生成 source map 文件信息
   1. CRACO 配置
2. 上传 source map 文件信息到服务器
   1. 如何应用 Sourcemap 到 ES apm 中[https://www.elastic.co/guide/en/apm/guide/7.17/sourcemap-api.html](https://www.elastic.co/guide/en/apm/guide/7.17/sourcemap-api.html)
   2. 打包编译，网络环境
3. 页面访问过程中自动载入 source map 文件信息
   1. 浏览器载入失败，网络环境

## 解决过程

### CRACO 配置

CRACO 基于 create react app，对于 cra，默认 webpack 配置可以通过 `npm run eject` 弹出查看。

整体执行栈，实际核心逻辑在 `build.js`

```javascript
/**
 * 此时 GENERATE_SOURCEMAP 为 undefined
 * env.js
 */
const shouldUseSourcemap = process.GENERATE_SOURCEMAP !== "false";
```

默认对于 `GENERATE_SOURCEMAP` 设置是 `undefined` 所以结合如下的逻辑判断

```javascript
{
    sourceMap: isEnvProduction ? shouldUseSourceMap : isEnvDevelopment,
}
```

所有环境都默认产生 sourcemap，其中在生产环境又由环境变量 `GENERATE_SOURCEMAP` 来参与决定

| GENERATE_SOURCEMAP=false NODE_ENV=production npm run build  | 不产生 sourcemap |
| ----------------------------------------------------------- | ---------------- |
| GENERATE_SOURCEMAP=false NODE_ENV=development npm run build | 产生 sourcemap   |
| GENERATE_SOURCEMAP=true NODE_ENV=production npm run build   | 产生 sourcemap   |

### 缺失上传逻辑

让 elastic APM 支持 sourcemap，参考一下预期逻辑

[Source map upload API | APM User Guide [7.17] | Elastic](https://www.elastic.co/guide/en/apm/guide/7.17/sourcemap-api.html#sourcemap-request-fields)

在审核后台是缺失的，从 cicd 流也能看出没有上传行为（在会产生 sourcemap 背景的情况下）

```javascript
/**
* 产生 sourcemap 并完成上传
*/
const fs = require('fs');
const packageInfo = require('../package.json');
​
const defaultConfig = {
  target: {
    hostname: 'apm.inf.miui.com',
    port: 3000,
  },
  service_version: packageInfo.version,
  service_label: 'apm-mi-dev',
  service_name: 'appstore-admin-web-fe',
  env: ['production'],
  base: './build/static/js',
};
​
function getEndPoint(hostname, port) {
  if (!hostname) {
    return undefined;
  }
  return `https://${hostname}:${port ?? 80}/assets/v1/sourcemaps`;
}
​
function isString(val) {
  return val != null && typeof val === 'string';
}
​
function getFilePath(filename) {
  if (!isString(filename)) return undefined;
​
  return `${defaultConfig.base}/${filename}`;
}
​
function getRequestParams(filename) {
  function getBundleFilePath(filename) {
    if (!isString(filename)) return undefined;
​
    const { service_label: cdnPath } = defaultConfig;
    return `/${cdnPath}/static/js/${filename.replace('.map', '')}`;
  }
​
  if (!filename) return null;
​
  const filepath = getFilePath(filename);
​
  return {
    sourcemap: fs.createReadStream(filepath),
    service_version: defaultConfig.service_version,
    bundle_filepath: getBundleFilePath(filename),
    service_name: defaultConfig.service_name,
  };
}
​
async function uploadFile(filename) {
  function removeFile(filepath) {
    fs.unlink(filepath, (err) => {
      if (err) {
        console.error(`Sourcemap: ${filepath} 删除失败`, err);
        return err;
      }
      console.log(`Sourcemap: ${filepath} 已被删除`);
      return true;
    });
  }
  const filepath = getFilePath(filename);
  const params = getRequestParams(filename);
  const endPoint = getEndPoint(defaultConfig.hostname, defaultConfig.port);
​
  console.info('Upload params', params);
​
  return fetch(endPoint, {
    method: 'POST',
    body: params,
  })
    .then((res) => {
      console.info('Source map upload successfully');
​
      removeFile(filepath);
    })
    .catch((err) => {
      console.error('Error while uploading sourcemaps!', err);
    });
}
​
function isTargetEnv(env) {
  if (isString(env) && Array.isArray(defaultConfig.env)) {
    return defaultConfig.env.includes(env);
  }
  return false;
}
​
function uploadSourceMap() {
  const canUpload = isTargetEnv(process.env.NODE_ENV);
  if (canUpload) {
    console.log(`当前环境是 ${process.env.NODE_ENV}，准许上传 ${canUpload}`);
    fs.readdir(defaultConfig.base, (err, files) => {
      if (err) {
        console.error('error', err);
      } else {
        console.log(files);
        // eslint-disable-next-line no-bitwise
        files.filter((str) => !!~str.indexOf('.map')).forEach((fileName) => {
          uploadFile(fileName);
        });
      }
    });
  } else {
    console.log('非目标环境版本，不上传 sourcemap');
  }
}
​
uploadSourceMap();
```

### 问题记录

1. `fs.unlink` 是移除文件，其中的 `symbolic link` 是代表什么含义呢
   https://zh.wikipedia.org/wiki/%E7%AC%A6%E5%8F%B7%E9%93%BE%E6%8E%A5
