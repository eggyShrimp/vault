---
tags:
  - react
  - stack_overflow
  - development
Source: https://stackoverflow.com/questions/58656026/what-is-the-difference-between-react-fc-and-jsx-element
---
- [[#React.FC:|React.FC:]]
- [[#JSX.element + props interface|JSX.element + props interface]]

## React.FC:

- has an implicit `children` prop, which means even if your component does not allow children, typescript would not complain if you are using `React.FC` and the parent passes a children. This does not impact anything at the runtime, but it is better to be more explicit about the children prop. This might be going away in the next version of `React.FC`, even now you can use `React.VFC`
- does not work well with defaultProps
- does not allow generics
- can't be used to annotate a function declaration, only function expressions
- makes "component as a namespace" pattern difficult to type

## JSX.element + props interface

- does not have an implicit children prop, so you need to declare it explicitly, which is good, and some people prefer implicit return type anyway. This does not have default support for other/static properties like `propTypes`, `displayName` etc, so they would need to be added explicitly if required.
- does not care about default props, this is just regular function typing for arguments and return types
- can be used with generics
- can be used to annotate a function declaration as well as expressions