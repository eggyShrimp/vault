---
tags:
  - frontend
  - development
---
- [[#问题一 带有 alpha 通道的颜色值渲染和设计稿结果不一致|问题一 带有 alpha 通道的颜色值渲染和设计稿结果不一致]]
	- [[#问题一 带有 alpha 通道的颜色值渲染和设计稿结果不一致#分析|分析]]
- [[#问题二 字体颜色设置和实际渲染结果存在差异|问题二 字体颜色设置和实际渲染结果存在差异]]
	- [[#问题二 字体颜色设置和实际渲染结果存在差异#分析|分析]]
- [[#🤔 see also|🤔 see also]]

## 问题一 带有 alpha 通道的颜色值渲染和设计稿结果不一致

今天实现设计稿时，发现都在一个 `#fff`  背景色上的矩形块，设计稿设置为  `#3482FF 10%`，在实现中确实也是这么写入的。但是实际输出效果却有细微差异

1. 设计稿设置的值为 `#3482FF 10%` 
2. 实现也是通过 `rgba(52, 130, 255, 0.1)` 完成实现

![[Pasted image 20240617205525.png]]

### 分析

实际便是混合计算过程的细微差异，对于带有 alpha 通道的色值来说，实际计算步骤：

1. 前景色取 alpha 部分
2. 再取 (1 - alpha) 比例的背景色
3. 汇总得到最终色值

对于上面例子来说，问题刚好发生在 3 步骤

1. 前景色计算：`#3482FF` --> `rgb(52, 130, 255)`
2. 背景色计算： `#fff` --> `rgb(255, 255, 255)`
3. 色值混合计算 `alpha = 0.1`：
	1. R channel: `52 * alpha + 255 * (1 - alpha) = 234.7`
	2. G channel: `130 * alpha + 255 * (1 - alpha) = 242.5`
	3. B channel: `255 * alpha + 255 * (1 - alpha) = 255`

figma 对此取值逻辑是 floor，而实际浏览器实现则是 ceil。这就有细微的差别。

## 问题二 字体颜色设置和实际渲染结果存在差异

设计稿字体设置色值为 `#3482FF`，实际渲染的结果会显现灰一些，色差明显。

### 分析

问题实际是浏览器渲染字体的问题，边缘因为系统有 *抗锯齿算法* 平滑周围像素色值的存在，导致实际渲染会观感不同。

![[Screenshot 2024-06-17 171234.png]] *浏览器渲染字体的细节*

![[64a43522-9582-4686-93bd-db23d9c98b93.jpeg]]
*figma 渲染字体的细节*
## 🤔 see also

1. [优化 WebFont 的加载和呈现  |  Articles  |  web.dev](https://web.dev/articles/optimize-webfont-loading)
2. [Font in browser seem bolder than in the figma? / 浏览器渲染字体会比设计稿更粗一些？ - Ask the community - Figma Community Forum](https://forum.figma.com/t/font-in-browser-seem-bolder-than-in-the-figma/24656/5)
3. [OpenType Design-Variation Axis Tag Registry (OpenType 1.9.1) - Typography | Microsoft Learn](https://learn.microsoft.com/en-us/typography/opentype/spec/dvaraxisreg)

- [x] 完成”设计稿和 CSS 样式实际渲染存在出入“这篇文档 ⏫ 📅 2024-06-18 ✅ 2024-06-18