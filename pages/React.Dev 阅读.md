---
Created: 2025-03-02T14:35:23 (UTC +08:00)
tags:
  - react
  - dev
  - book
---
### JSX 在 React 应用是如何被解析的？

这里我贴一下 medium 的文章。如果 medium 的文字有阅读限制，可以下一下 Bypass PayWall

[How JSX convert into JS?. What is JSX? | by Md Sajjad Hosen Noyon | Medium](https://www.notion.so/How-JSX-convert-into-JS-What-is-JSX-by-Md-Sajjad-Hosen-Noyon-Medium-d1910890817c475b93897798571f43a7?pvs=21)

### 渲染函数的区别， `<Title />` 和 `getTitle()` 在实现上有什么区分？

1. 被渲染出JSX实例的时机不一样，前者只有被需要的时候才会被渲染，后者则是直接被调用。我这里举一个case：
    
    ```tsx
    function foo() { return needRender ? <Title /> : null; }
    
    function bar() { return needRender ? getTitle() : null; }
    ```
    
2. 对待 hooks 等组件状态信息的位置不一样，前者直接存放在组件内部
    

[javascript - React: what's the difference between a function returning JSX and function component? - Stack Overflow](https://www.notion.so/javascript-React-what-s-the-difference-between-a-function-returning-JSX-and-function-component--ffde5d3326fb4532b6f46a444ed09f95?pvs=21)

用 [babel compiler](https://babeljs.io/repl#?browsers=defaults%2C%20not%20ie%2011%2C%20not%20ie_mob%2011&build=&builtIns=false&corejs=3.21&spec=false&loose=false&code_lz=GYVwdgxgLglg9mABMOdEAoCGAnA5gRgBpEdcAmASkQG8AoASGwFMoRskAeGMABxCkQB6AHy0AvrVqhIsBIgBiqdD2xweAZyp1GLNp258BI8ZOnR4SAII8e6LQ2at2GDqMTuP76ijjoiiSglPTw5FNGN3DhEKcSA&debug=false&forceAllTransforms=false&modules=false&shippedProposals=false&circleciRepo=&evaluate=false&fileSize=false&timeTravel=false&sourceType=module&lineWrap=true&presets=env%2Creact%2Cstage-2%2Ctypescript&prettier=true&targets=&version=7.24.4&externalPlugins=&assumptions=%7B%7D) 也能看出两种区别

```tsx
// before compiling
function foo (arg1, arg2) {
	return <input />
}

function Foo(props) {
	return <input />
}

function App() {
	return (<>
        {foo(1, 2)}
        <Foo />
  </>)
}

//after compiling
import {
  jsx as _jsx,
  Fragment as _Fragment,
  jsxs as _jsxs
} from "react/jsx-runtime";
function foo(arg1, arg2) {
  return /*#__PURE__*/ _jsx("input", {});
}
function Foo(props) {
  return /*#__PURE__*/ _jsx("input", {});
}
function App() {
  return /*#__PURE__*/ _jsxs(_Fragment, {
    children: [foo(1, 2), /*#__PURE__*/ _jsx(Foo, {})]
  });
}

```