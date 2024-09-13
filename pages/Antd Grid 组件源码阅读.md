---
title: Antd Grid 组件源码阅读
Author: yuanyifan@xiaomi.com
tags:
  - react
  - ant-design
  - development
  - frontend
  - responsive-design
---
- [`Props` 设计](#props-%E8%AE%BE%E8%AE%A1)
- [核心逻辑](#%E6%A0%B8%E5%BF%83%E9%80%BB%E8%BE%91)
- [响应式原理](#%E5%93%8D%E5%BA%94%E5%BC%8F%E5%8E%9F%E7%90%86)
	- [整体执行步骤](#%E6%95%B4%E4%BD%93%E6%89%A7%E8%A1%8C%E6%AD%A5%E9%AA%A4)
	- [`subscribe` 订阅逻辑](#subscribe-%E8%AE%A2%E9%98%85%E9%80%BB%E8%BE%91)
	- [`window.matchMedia` 事件监听器](#windowmatchmedia-%E4%BA%8B%E4%BB%B6%E7%9B%91%E5%90%AC%E5%99%A8)


## `Props` 设计

通过 `props` 看一下这个组件能用来做啥，有啥能力

[栅格 Grid - Ant Design](https://ant.design/components/grid-cn#row)

```tsx
interface RowProps {
	prefixCls: customizePrefixCls,
  justify,
  align,
  className,
  style,
  children,
  gutter,
  wrap,
  ...others
}
```

## 核心逻辑

核心代码结构是

```tsx
<RowContext value={{ gutter, wrap }}>
  <Row>
    <Col />
  </Row>
</RowContext>
```

1. 响应式实现
2. 样式计算

## 响应式原理

具体实现在 `components\\_util\\responsiveObserver.ts` 中，被包裹在 `useMemo` 中被返回的对象里

> 被记忆化是为了保证以 state 形式存在组件函数中，防止每次渲染都被重新声明一次丢掉注册信息

### 整体执行步骤

1. 注册 `subscribe`
2. 触发监听器，通过 `matchMedia` 实现
3. 在 `dispatch` 中执行回调逻辑

### `subscribe` 订阅逻辑

```tsx
subscribe(func: SubscribeFunc): number {
  if (!subscribers.size) this.register();
  subUid += 1;
  **subscribers.set(subUid, func);**
  func(screens);
  return subUid;
}

register() {
  Object.keys(responsiveMap).forEach((screen: Breakpoint) => {
    const matchMediaQuery = responsiveMap[screen];
    const listener = ({ matches }: { matches: boolean }) => {
      this.dispatch({
        ...screens,
        [screen]: matches,
      });
    };
    **const mql = window.matchMedia(matchMediaQuery);**
    mql.addListener(listener);
    this.matchHandlers[matchMediaQuery] = {
      mql,
      listener,
    };

    listener(mql);
  });
}
```

### `window.matchMedia` 事件监听器

[Window.matchMedia() - Web API 接口参考 | MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Window/matchMedia)

利用的是 `window.matchMedia` 特性和 🔭[发布订阅者模式](https://refactoringguru.cn/design-patterns/observer)，可以针对屏幕尺寸变化调用对应的事件函数逻辑
