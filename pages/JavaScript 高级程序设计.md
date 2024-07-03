---
tags:
  - book
  - frontend
  - development
  - coding
---
- [ ] JavaScript 高级程序设计 #book #javascript 🔼 📅 2024-07-14

- [JavaScript 是一种解释性语言，相比编译语言有什么好处？](#javascript-%E6%98%AF%E4%B8%80%E7%A7%8D%E8%A7%A3%E9%87%8A%E6%80%A7%E8%AF%AD%E8%A8%80%E7%9B%B8%E6%AF%94%E7%BC%96%E8%AF%91%E8%AF%AD%E8%A8%80%E6%9C%89%E4%BB%80%E4%B9%88%E5%A5%BD%E5%A4%84)
- [脚本加载中， DOMContentLoaded 事件和 load 事件的区别，和 defer 以及 async 的关系？](#%E8%84%9A%E6%9C%AC%E5%8A%A0%E8%BD%BD%E4%B8%AD-domcontentloaded-%E4%BA%8B%E4%BB%B6%E5%92%8C-load-%E4%BA%8B%E4%BB%B6%E7%9A%84%E5%8C%BA%E5%88%AB%E5%92%8C-defer-%E4%BB%A5%E5%8F%8A-async-%E7%9A%84%E5%85%B3%E7%B3%BB)
- [variable hoisting 变量提升背后的实现，为什么要有变量提升？](#variable-hoisting-%E5%8F%98%E9%87%8F%E6%8F%90%E5%8D%87%E8%83%8C%E5%90%8E%E7%9A%84%E5%AE%9E%E7%8E%B0%E4%B8%BA%E4%BB%80%E4%B9%88%E8%A6%81%E6%9C%89%E5%8F%98%E9%87%8F%E6%8F%90%E5%8D%87)
- [什么叫“函数是一等公民”？](#%E4%BB%80%E4%B9%88%E5%8F%AB%E5%87%BD%E6%95%B0%E6%98%AF%E4%B8%80%E7%AD%89%E5%85%AC%E6%B0%91)
- [`let` `const` `var` 的区别有什么？](#let-const-var-%E7%9A%84%E5%8C%BA%E5%88%AB%E6%9C%89%E4%BB%80%E4%B9%88)
- [Javascript的基础数据类型有哪些？](#javascript%E7%9A%84%E5%9F%BA%E7%A1%80%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B%E6%9C%89%E5%93%AA%E4%BA%9B)
- [undefined 的设计和 null 的设计有什么区分？](#undefined-%E7%9A%84%E8%AE%BE%E8%AE%A1%E5%92%8C-null-%E7%9A%84%E8%AE%BE%E8%AE%A1%E6%9C%89%E4%BB%80%E4%B9%88%E5%8C%BA%E5%88%86)
- [为什么 typeof null === 'object' 呢？](#%E4%B8%BA%E4%BB%80%E4%B9%88-typeof-null--object-%E5%91%A2)
- [difference between Number.isNaN and isNaN](#difference-between%C2%A0numberisnan%C2%A0and%C2%A0isnan)
- [为什么会出现 0.1 + 0.2 > 0.3 的情况，怎么解决？](#%E4%B8%BA%E4%BB%80%E4%B9%88%E4%BC%9A%E5%87%BA%E7%8E%B0-01--02--03-%E7%9A%84%E6%83%85%E5%86%B5%E6%80%8E%E4%B9%88%E8%A7%A3%E5%86%B3)
- [利用 + 来完成数值转换背后的规则是什么？](#%E5%88%A9%E7%94%A8--%E6%9D%A5%E5%AE%8C%E6%88%90%E6%95%B0%E5%80%BC%E8%BD%AC%E6%8D%A2%E8%83%8C%E5%90%8E%E7%9A%84%E8%A7%84%E5%88%99%E6%98%AF%E4%BB%80%E4%B9%88)
- [利用 Object.keys 和 for...in... 去遍历对象属性有什么区别？](#%E5%88%A9%E7%94%A8-objectkeys-%E5%92%8C-forin-%E5%8E%BB%E9%81%8D%E5%8E%86%E5%AF%B9%E8%B1%A1%E5%B1%9E%E6%80%A7%E6%9C%89%E4%BB%80%E4%B9%88%E5%8C%BA%E5%88%AB)
- [面向原型编程概念和函数式编程之间的关联性？](#%E9%9D%A2%E5%90%91%E5%8E%9F%E5%9E%8B%E7%BC%96%E7%A8%8B%E6%A6%82%E5%BF%B5%E5%92%8C%E5%87%BD%E6%95%B0%E5%BC%8F%E7%BC%96%E7%A8%8B%E4%B9%8B%E9%97%B4%E7%9A%84%E5%85%B3%E8%81%94%E6%80%A7)

### JavaScript 是一种解释性语言，相比编译语言有什么好处？

一般而言，用编译语言写成的程序，在执行期的执行速度，通常比用解释型语言写的程序快。因为程序在编译期，已经被预先编译成机器代码，可以直接执行，不用像解释型语言一样，还要多一道直译程序。

但是要先进行编译，之后才能执行程序，这也造成了编译语言的缺点。一般而言，编译语言的程序开发速度，以及调试时间，都是比较长的。因为它不像解释型语言可以写完一行，或一小段程序之后，马上执行，马上调试。解释型语言通常让程序开发的整体时间变少，在开发过程中，程序师也可以更弹性、快速的测试自己的想法。

🤔 *see also*

1. *Just In Time* JIT 编译 [wikipedia](https://zh.wikipedia.org/wiki/%E5%8D%B3%E6%99%82%E7%B7%A8%E8%AD%AF)

	感觉 JIT 模糊了编译语言和解释语言的边界。因为编译语言是先编译然后提供可执行产物给开发者，解释语言利用解释器提高开发的灵活性。JIT表面是杂糅了两者之间的优势。

	为了改善编译语言的效率而发展出的[即时编译](https://zh.wikipedia.org/wiki/%E5%8D%B3%E6%99%82%E7%B7%A8%E8%AD%AF)技术，已经缩小了这两种语言间的差距。这种技术混合了编译语言与解释型语言的优点，它像编译语言一样，先把程序源代码编译成[字节码](https://zh.wikipedia.org/wiki/%E5%AD%97%E8%8A%82%E7%A0%81)。到执行期时，再将字节码直译，之后执行。[Java](https://zh.wikipedia.org/wiki/Java)与[LLVM](https://zh.wikipedia.org/wiki/LLVM)是这种技术的代表产物。

	我问了一下KIMI，他有比较详细的答案：[[解释语言，编译语言和JIT的解释以及他们的区别#JIT看起来和解释语言很相似啊，都是运行时被编译成机器语言，所以我看不出来区别。您能纠正一下我的想法和勘误一下吗]]

### 脚本加载中， DOMContentLoaded 事件和 load 事件的区别，和 defer 以及 async 的关系？

https://developer.mozilla.org/zh-CN/docs/Web/API/Document/DOMContentLoaded_event

还可以联系一下其他知识点：

🤔 *see also*

1. [[Page Lifecycle API 页面生命周期 API]]
2. [浏览器渲染流程 Inside look at modern web browser - Chrome Developers](https://developer.chrome.com/blog/inside-browser-part1)
3. [javascript.info](http://javascript.info/) 关于脚本加载的信息
	* https://zh.javascript.info/script-async-defer

### variable hoisting 变量提升背后的实现，为什么要有变量提升？

1. 这个在规范中有，hoisting 作用在函数和 var 这两个场景。
2. 至于为啥？看下js作者的回答：
	![[assets/JavaScript 高级程序设计/Untitled.png]]
3. 这里也有得益于hoist的一些具体case
	1. https://stackoverflow.com/questions/52879220/is-there-a-purpose-to-hoisting-variables
	2. https://stackoverflow.com/questions/15005098/why-does-javascript-hoist-variables
		1. 这里提到 JavaScript 有 two passes 的特性，JIT编译相关，我记得之前web assembly 串讲在描述为什么引入 web assembly的时候提到过编译阶段
		2. 这里我没储备，先不提see also

### 什么叫“函数是一等公民”？

我之前在typescript类型系统那里看到关于策略模式的实现有这条注释，简单阐述，函数可以被用来传递，这是之前只能通过对象才能完成的事情

这里有一份稍微详细那么一点点的介绍 https://habens.github.io/blog/first-class-citizens/

🤔 *see also*

1. [[编程类型与系统 Programming with Type#“函数是一等公民” 是什么意思？]]

### `let` `const` `var` 的区别有什么？

两点。1. 可变性 2. 与词法环境的关系；

1. 可变性。自然就是 const 和可变的 let 以及 var 的区分。
2. 词法环境的关系。var是函数/全局作用域，而其他两个是块级作用域。关于具体怎么实现的底层，可以看看规范还有 JavaScript 忍者秘籍 5.5 理解 JavaScript 的变量类型
3. 引申一下，在书里紧接就提及了正确编码如何选择变量类型

🤔 *see also*

1. [深入 JavaScript 系列：执行上下文](https://github.com/logan70/Blog/issues/2)
2. 问下呢，为什么javascript会出现var的hoisting设计？有啥考虑吗，let/const为啥没有
	[[JavaScript 高级程序设计#variable hoisting 变量提升背后的实现，为什么要有变量提升？]]

### Javascript的基础数据类型有哪些？

`undefined` `null` `number` `string` `boolean` `symbol`

🤔 *see also*

1. `typeof` 能返回哪些类型
	返回类型有 undefined boolean string number object function symbol
2. `typeof NaN` 返回是什么
	number
3. `instanceOf` 能用于判断什么类型
	1. [https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/instanceof](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/instanceof)
	2. `instanceof`** **运算符**用于检测构造函数的 `prototype` 属性是否出现在某个实例对象的原型链上
4. 判断类型的方法还有哪些？
    `Object.prototype.toString` 判断类型嘛，也就是找原型信息

### undefined 的设计和 null 的设计有什么区分？

[what-is-the-difference-between-null-and-undefined-in-javascript](https://stackoverflow.com/questions/5076944/what-is-the-difference-between-null-and-undefined-in-javascript)

1. `undefined` means a variable has been declared but has not yet been assigned a value
2. `null` is an assignment value. It can be assigned to a variable as a representation of no value

![[diff_between_undefined&null.png]]

### 为什么 typeof null === 'object' 呢？

参考一下 [what-is-the-difference-between-null-and-undefined-in-javascript#:~:text=Quote from the,a primitive value."](https://stackoverflow.com/questions/5076944/what-is-the-difference-between-null-and-undefined-in-javascript#:~:text=Quote%20from%20the,a%20primitive%20value.%22)

> Quote from the book Professional JS For Web Developers (Wrox): "You may wonder why the typeof operator returns 'object' for a value that is null. This was actually an error in the original JavaScript implementation that was then copied in ECMAScript. Today, it is rationalized that null is considered a placeholder for an object, even though, technically, it is a primitive value.”

### difference between Number.isNaN and isNaN

[confusion-between-isnan-and-number-isnan-in-javascript](https://stackoverflow.com/questions/33164725/confusion-between-isnan-and-number-isnan-in-javascript)

### 为什么会出现 0.1 + 0.2 > 0.3 的情况，怎么解决？

精度问题，背后是 IEEE 754 的标准问题 [[IEEE754 浮点数格式与Javascript number 的特性]]

🤔 *see also*

1. 怎么解决呢？
	1. `Number.EPSILON`
	2. 利用 `String` 完成精度保留计算
	3. `bigNumber` 计算

### 利用 + 来完成数值转换背后的规则是什么？

实际是利用 Number 构造函数完成，具体规则是：

![[Number_rule.png]]

🤔 *see also*

1. `parseFloat` 逻辑和上面有些区别的
	1. 该函数始终忽略字符串开头的 0，只能解析十进制（没有底数参数）
	2. 如果字符串表示整数，即使带小数位也返回整数
2. 引申到整个JS类型转换问题
	1. 基本类型转换 Type Conversion [https://javascript.info/type-conversions](https://javascript.info/type-conversions)
	2. 对象转换基本类型 Object To Primitive [https://javascript.info/object-toprimitive](https://javascript.info/object-toprimitive)

### 利用 Object.keys 和 for...in... 去遍历对象属性有什么区别？

Object.keys() 返回一个数组，其元素是字符串，对应于直接在对象上找到的可枚举的字符串键属性名。这与使用 [for...in](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for...in) 循环迭代相同，只是 for...in 循环还会枚举原型链中的属性。Object.keys() 返回的数组顺序和与 [for...in](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Statements/for...in) 循环提供的顺序相同。

🤔 *see also*

1. hasOwnProperty 和 in 判断键值在对象身上的区别？
	1. [mdn 上在 Object.prototype.hasOwnProperty 有解释](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/hasOwnProperty#:~:text=%E4%B8%8E%20in%20%E8%BF%90%E7%AE%97%E7%AC%A6%E4%B8%8D%E5%90%8C%E7%9A%84%E6%98%AF%EF%BC%8C%E8%AF%A5%E6%96%B9%E6%B3%95%E4%B8%8D%E4%BC%9A%E5%9C%A8%E5%AF%B9%E8%B1%A1%E5%8E%9F%E5%9E%8B%E9%93%BE%E4%B8%AD%E6%A3%80%E6%9F%A5%E6%8C%87%E5%AE%9A%E7%9A%84%E5%B1%9E%E6%80%A7%E3%80%82)

### 面向原型编程概念和函数式编程之间的关联性？

> **基于原型编程**（英语：prototype-based programming）或称为**原型程序设计**、**原型编程**，是[面向对象编程](https://zh.wikipedia.org/wiki/%E9%9D%A2%E5%90%91%E5%AF%B9%E8%B1%A1%E7%BC%96%E7%A8%8B "面向对象编程")的一种风格和方式。在原型编程中，行为重用（在基于类的语言通常称为[继承](https://zh.wikipedia.org/wiki/%E7%BB%A7%E6%89%BF_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6) "继承 (计算机科学)")），是通过复制已经存在的[原型](https://zh.wikipedia.org/wiki/%E5%8E%9F%E5%9E%8B_(%E5%B7%A5%E7%A8%8B) "原型 (工程)")对象的过程实现的。这个模型一般被认为是无类的、面向原型、或者是基于实例的编程。
> 
> **函数式编程**，或称**函数程序设计**、**泛函编程**（英语：Functional programming），是一种[编程范型](https://zh.wikipedia.org/wiki/%E7%BC%96%E7%A8%8B%E8%8C%83%E5%9E%8B "编程范型")，它将[电脑运算](https://zh.wikipedia.org/wiki/%E9%9B%BB%E8%85%A6%E9%81%8B%E7%AE%97 "电脑运算")视为[函数](https://zh.wikipedia.org/wiki/%E5%87%BD%E6%95%B0 "函数")运算，并且避免使用程序[状态](https://zh.wikipedia.org/w/index.php?title=%E7%8A%B6%E6%80%81_(%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6)&action=edit&redlink=1)以及[可变对象](https://zh.wikipedia.org/wiki/%E4%B8%8D%E5%8F%AF%E8%AE%8A%E7%89%A9%E4%BB%B6 "不可变对象")。

