1. [字体渲染 : 如何渲染一个文字 – Moren's](https://blog.yangteng.me/articles/2019/typography-how-fonts-are-rendered/)
2. https://blog.typekit.com/2010/10/05/type-rendering-on-the-web/
3. [OpenType Design-Variation Axis Tag Registry (OpenType 1.9.1) - Typography | Microsoft Learn](https://learn.microsoft.com/en-us/typography/opentype/spec/dvaraxisreg)
4. [OS新字重档位研发对照开发说明](https://xiaomi.f.mioffice.cn/docx/doxk4nKETL5bab5VsRB5nxe8aIf)
5. [life of a pixel](https://docs.google.com/presentation/d/1boPxbgNrTU0ddsc144rcXayGA_WF53k96imRH8Mp34Y/edit?usp=sharing) #browser 
6. [A Closer Look At Font Rendering — Smashing Magazine](https://www.smashingmagazine.com/2012/04/a-closer-look-at-font-rendering/) #font

- [ ] 完成渲染字体文章🔼 📅 2024-06-23 

### 渲染字体流程

1. 查找对应 fonts.xml
2. 使用默认的字体查找路径规则
3. 依据找到字体应用样式
4. CSS 渲染字体流程
5. [CSS Fonts Module Level 3](https://www.w3.org/TR/css-fonts-3/#font-matching-algorithm)

### Webview 字体渲染逻辑

系统依据 system/etc/fonts.xmlfonts.xml 获取文件内字体映射信息，不会直接去访问 system/fonts 下的字体文件

```TypeScript
<family name="sans-serif">
    <font weight="100" style="normal" postScriptName="MiSansVF">
        Target_Fonts.ttf
        <axis tag="wght" stylevalue="150"/>
    </font>
</family>
```

fonts.xml 中逻辑便是这种映射信息，左边代表 sans-serif 字族的处理逻辑：

1. 命中规则 font-family: sans-serif, font-weight: 100, font-style: normal，则查找 system/fonts/Target_Fonts.ttf
2. 对找到的可变字体 Target_Fonts 的 wght 轴赋值 150

<details>
<summary>**什么叫做****可变字体****？(wght 属于可变字体的概念)**</summary>
	https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_fonts/Variable_fonts_guide
	
	- OpenType 字体规范上的演进，它允许将同一字体的多个变体统合进单独的字体文件中    
	- `wght` 是可变字体的[字重轴](https://fonts.google.com/knowledge/glossary/weight_axis)，类似于字体字重的概念
	
	-[ ] ASK: 为什么以前需要分不同字体文件
</details>

