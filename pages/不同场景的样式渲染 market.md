---
tags:
  - rendering
  - frontend
  - font
published: "true"
---
- [[#当前方案|当前方案]]
	- [[#当前方案#大字体处理|大字体处理]]
		- [[#大字体处理#结合客户端获取字体缩放信息|结合客户端获取字体缩放信息]]
		- [[#大字体处理#CSS函数进行字体缩小|CSS函数进行字体缩小]]
	- [[#当前方案#响应式相关逻辑处理|响应式相关逻辑处理]]
		- [[#响应式相关逻辑处理#|]]

## 当前方案

1. 通过客户端接口获取字体缩放比例，手动在根目录添加类
2. 通过css函数进行字体缩小

### 大字体处理

#### 结合客户端获取字体缩放信息

```javascript
export function setBigFontFix(): void {
  getFontScaleAsync({
    callBack: (res: any) => {
      fontScale = res?.fontScale || 1;
      document.documentElement.style.setProperty('--fontScale', '' + fontScale);
      getFontDone = true;
      if (fontScale > 1.25) {
        window.__isBigFont = true;
        document.body.classList.add('biggest-font-fix');
        // 系统设置<大号>字体时，fontScale: 1.25
      } else if (fontScale > 1) {
        window.__isBigFont = true;
        document.body.classList.add('big-font-fix');
      }
    },
  });
}
```

#### CSS函数进行字体缩小

```less
// -----没有考虑到缩小的情况,设计规范也没有，待做-----
// 用于大字体适配，font-size指当前字号，scale指对应组件最大的放大比例
.font_scale(@font-size: 16px, @biggest-scale: 1) {
  --finalScale: ~'calc( @{biggest-scale} / var(--fontScale) )';
  @scale: ~'min(1,var(--finalScale))';
  font-size: ~'calc( @{font-size} * @{scale} )';
}
```

> [!tip] 相关文档
> 
> * [📃大字体设计规范](https://www.figma.com/file/XngEUjk0e84iUPICGlQIqn/%E5%A4%A7%E5%AD%97%E4%BD%93%E8%AE%BE%E8%AE%A1%E8%A7%84%E8%8C%83%26%E7%BB%84%E4%BB%B6?node-id=47%3A439&t=Kxq4X1NMDI8Mgr0H-1)

### 响应式相关逻辑处理

- [ ] less 能不能应用于当前的设备样式处理🔼 

### 背景色彩在屏幕上的实际渲染效果

- [ ] [色彩空间（一）：色彩空间基础](https://www.zhangxiaochun.com/color-space-1/)⏫ 📅 2024-06-23 
	- [ ] web 安全颜色的概念
	- [ ] https://jamie-wong.com/post/color/
	- [ ] [Web技巧(06). 在上一期中我们提到了CSS的混合模式算法和滤镜相关的知识，正好在这周周会老板也提… | by w3cplus | Medium](https://w3cplus.medium.com/web%E6%8A%80%E5%B7%A7-06-3518daf7b118)
	- [ ] CSS针对色彩混合的处理 [Web技巧(06). 在上一期中我们提到了CSS的混合模式算法和滤镜相关的知识，正好在这周周会老板也提… | by w3cplus | Medium](https://w3cplus.medium.com/web%E6%8A%80%E5%B7%A7-06-3518daf7b118)
	- [ ] https://developer.mozilla.org/zh-CN/docs/Web/CSS/blend-mode
	- [ ] [CSS颜色混合模式 | snowdream](https://note.xiexuefeng.cc/post/css-blend-mode/)
	- [ ] 背景色计算方式