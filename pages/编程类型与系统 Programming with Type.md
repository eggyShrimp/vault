---
tags:
  - dev
  - typescript
  - book
  - type_system
title: 编程类型与系统 Programming with Type
published: "true"
status: in-progress
---
### 怎么实现避免基本类型偏执？

可以利用 `unique symbol` 结合类型来区分，如果只是简单的利用 `type Lbfs = number` 和 `type Ns = number` 还是会被认定为兼容；

```jsx
declare const LbfsType: unique symbol;
class Lbfs {
	readonly value: number;
	[LfbsType]: void;
}

declare const NsType: unique symbol;
class Ns {
	readonly value: number;
	[NsType]: void;
}
```

### 装饰器模式有什么用呢，用于什么场景？

[https://refactoringguru.cn/design-patterns/decorator](https://refactoringguru.cn/design-patterns/decorator)

**装饰模式**是一种结构型设计模式， 允许你通过将对象放入包含行为的特殊封装对象中来为原对象绑定新的行为。

- see also
    1. 什么叫结构性设计模式？
        
    2. 设计模式看起来很多场景都是针对面向对象完成的，面向对象的相关概念在哪里？
        
    3. 在 react 中，高阶函数算是一种装饰器模式的实现吗？
        
        [在React中，高阶函数算是一种装饰器模式的实践吗](https://www.notion.so/React-9b8a2bfa996749cda939b2370e3ff6fa?pvs=21)
        

### 在面向对象编程中，继承和组合以及聚合的概念分别是什么？他们的区别又是什么？

在面向对象编程（OOP）中，继承、组合和聚合是实现代码重用和模块化的重要概念。这些概念有助于设计灵活且易于维护的软件结构。

**继承**

继承是OOP中的一种基本机制，它允许一个类（子类或派生类）继承另一个类（父类或基类）的属性和方法。继承的主要目的是实现代码的重用和扩展现有的类。

- **优点**：通过继承，子类可以重用父类的代码，减少代码重复，同时可以通过扩展或覆盖父类的方法来实现新的功能。
- **缺点**：过度使用继承可能导致类的层次结构过于复杂，增加代码的耦合度，使得维护和理解变得更加困难。

```jsx
class A {}
class B extends A {}
```

**组合**

组合是另一种实现代码重用的方法，它通过将一个类的对象包含在另一个类的对象中来实现。这种方式强调的是“部分-整体”的关系，即一个类是由其他类的对象组合而成的。

[组合设计模式](https://refactoringguru.cn/design-patterns/composite)

- **优点**：组合提供了更大的灵活性，因为它允许在运行时动态地改变对象的内部结构。此外，它避免了类的层次结构变得过于复杂。
- **缺点**：与继承相比，组合可能需要更多的内存，因为它涉及到多个对象的创建和管理。

**聚合**

聚合是一种特殊的关系，表示“整体-部分”的关系，但部分可以脱离整体而独立存在。在聚合关系中，整体和部分之间的耦合度较低，部分对象可以属于多个整体对象。

- **优点**：聚合提供了一种灵活的方式来表示对象之间的关系，同时保持了对象的独立性。
- **缺点**：由于聚合关系的耦合度较低，可能不适用于需要紧密协作的场景。

**区别**

1. **关系强度**：继承是一种强关系，子类依赖于父类的定义；而组合和聚合是较弱的关系，它们表示对象之间的“部分-整体”关系，但部分对象可以独立于整体对象存在。
2. **代码重用**：继承通过子类继承父类的代码来实现重用；组合通过一个类包含其他类的对象来实现；聚合则通过将对象组合在一起来实现。
3. **修改影响**：在继承中，对父类的修改可能会影响所有子类；而在组合和聚合中，对一个对象的修改通常不会直接影响其他对象。
4. **灵活性**：组合和聚合提供了更高的灵活性，因为它们允许在运行时动态地改变对象之间的关系；继承则相对固定，一旦定义了继承关系，就较难改变。

在实际编程中，选择使用继承、组合还是聚合取决于具体的应用场景和设计需求。通常建议优先考虑使用组合和聚合，因为它们提供了更好的灵活性和可维护性，而继承则应谨慎使用，以避免创建过于复杂的类层次结构。

- see also
    1. 组合，装饰器以及聚合模式的实现？
        
        [聚合，组合，装饰器模式的实现](https://www.notion.so/95f5163f076f449ab28dc0cff3d0a9da?pvs=21)
        

### 如何在序列化场景保存和恢复类型信息

利用类型推断

```tsx
class Model implements Serialize<T> {
	serialize(data: T): string {
		return JSON.stringify(data) as string;
	}
	
	deserialize(data: string): T | undefined {
		//...some type deducing
		const isTargetType = judge(data);
		try {
			return isTargetType ? JSON.parse(data) as T : undefined
		} catch(e) {
			return undefined;
		}
	}
}
```

### 针对异步问题，有哪些主流解决方式呢？

1. 线程
2. 事件循环

**关于这两者的对比**

事件循环优势在于不需要同步，所有代码在一个线程上运行。缺点在于 IO 场景下会让他们排队的效果较好，但是CPU密集操作仍然会造成阻塞。

- see also
    1. 关于浏览器和node环境下的事件循环特性的理解
        
        [事件循环 Event loop](https://www.notion.so/Event-loop-271ce39b0a9140599541b58c21b8e87e?pvs=21)
        

### 关于子类型定义分为哪几种呢，他们的优劣势分别是什么？

1. 名义子类型
2. 结构子类型

typescript 使用的是结构子类型