---
title: web performance optimization
date: 2022-11-04 22:29:34
tags: [front-end,performance]
---

📎what is the definition of Web Performance?

>  [Web 性能 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/Performance) 

# lighthouse advices

1. Eliminate render-blocking resources

     [Eliminate render-blocking resources (web.dev)](https://web.dev/render-blocking-resources/?utm_source=lighthouse&utm_medium=devtools) `FCP`, `LCP`

2. Does not use passive listeners to improve scrolling performance

     [使用被动监听器优化滚动体验 (web.dev)](https://web.dev/uses-passive-event-listeners/?utm_source=lighthouse&utm_medium=devtools) 

3. Avoid an excessive DOM size

    A large DOM will increase memory usage, cause longer [style calculations](https://developers.google.com/web/fundamentals/performance/rendering/reduce-the-scope-and-complexity-of-style-calculations?utm_source=lighthouse&utm_medium=devtools), and produce costly [layout reflows](https://developers.google.com/speed/articles/reflow?utm_source=lighthouse&utm_medium=devtools). [Learn more](https://web.dev/dom-size/?utm_source=lighthouse&utm_medium=devtools).`TBT` 

4. Serve static assets with an efficient cache policy

    A long cache lifetime can speed up repeat visits to your page. [Learn more](https://web.dev/uses-long-cache-ttl/?utm_source=lighthouse&utm_medium=devtools). 

5. Minimize main-thread work

    Consider reducing the time spent parsing, compiling and executing JS. You may find delivering smaller JS payloads helps with this. [Learn more](https://web.dev/mainthread-work-breakdown/?utm_source=lighthouse&utm_medium=devtools) `TBT`

6. Avoid chaining critical requests

    The Critical Request Chains below show you what resources are loaded with a high priority. Consider reducing the length of chains, reducing the download size of resources, or deferring the download of unnecessary resources to improve page load. [Learn more](https://web.dev/critical-request-chains/?utm_source=lighthouse&utm_medium=devtools). `FCP` `LCP` 

7. User Timing marks and measures

    Consider instrumenting your app with the User Timing API to measure your app's real-world performance during key user experiences. [Learn more](https://web.dev/user-timings/?utm_source=lighthouse&utm_medium=devtools). 

8. Keep request counts low and transfer sizes small

    To set budgets for the quantity and size of page resources, add a budget.json file. [Learn more](https://web.dev/use-lighthouse-for-performance-budgets/?utm_source=lighthouse&utm_medium=devtools). 

9. Largest Contentful Paint element

     This is the largest contentful element painted within the viewport. [Learn More](https://web.dev/lighthouse-largest-contentful-paint/?utm_source=lighthouse&utm_medium=devtools) `LCP` 

10. Avoid large layout shifts

     [Cumulative Layout Shift 累积布局偏移 (CLS) (web.dev)](https://web.dev/cls/) 

11. Avoid long main-thread tasks 

     Lists the longest tasks on the main thread, useful for identifying worst contributors to input delay. [Learn more](https://web.dev/long-tasks-devtools/?utm_source=lighthouse&utm_medium=devtools) `TBT` 

12. Avoid non-composited animations 

    Animations which are not composited can be janky and increase CLS. [Learn more](https://web.dev/non-composited-animations?utm_source=lighthouse&utm_medium=devtools) `CLS` 

13. Properly size images

    Serve images that are appropriately-sized to save cellular data and improve load time. [Learn more](https://web.dev/uses-responsive-images/?utm_source=lighthouse&utm_medium=devtools). 

14. Defer offscreen images

    Consider lazy-loading offscreen and hidden images after all critical resources have finished loading to lower time to interactive. [Learn more](https://web.dev/offscreen-images/?utm_source=lighthouse&utm_medium=devtools). 

15. Minify CSS/JavaScript

    Minifying CSS files can reduce network payload sizes. [Learn more](https://web.dev/unminified-css/?utm_source=lighthouse&utm_medium=devtools). `FCP` `LCP` 

16. Reduce unused CSS/JavaScript

    Reduce unused rules from stylesheets and defer CSS not used for above-the-fold content to decrease bytes consumed by network activity. [Learn more](https://web.dev/unused-css-rules/?utm_source=lighthouse&utm_medium=devtools).`FCP` `LCP` 

17. Efficiently encode images

    Optimized images load faster and consume less cellular data. [Learn more](https://web.dev/uses-optimized-images/?utm_source=lighthouse&utm_medium=devtools). 

18. Serve images in Webp (next-gen formats)

    Image formats like WebP and AVIF often provide better compression than PNG or JPEG, which means faster downloads and less data consumption. [Learn more](https://web.dev/uses-webp-images/?utm_source=lighthouse&utm_medium=devtools). 

19. Enable text compression

    Text-based resources should be served with compression (gzip, deflate or brotli) to minimize total network bytes. [Learn more](https://web.dev/uses-text-compression/?utm_source=lighthouse&utm_medium=devtools). `FCP` `LCP` 

20. Pre-connect to required origins

    Consider adding `preconnect` or `dns-prefetch` resource hints to establish early connections to important third-party origins. [Learn more](https://web.dev/uses-rel-preconnect/?utm_source=lighthouse&utm_medium=devtools).`FCP` `LCP` 

21. Initial server response time was short

    Keep the server response time for the main document short because all other requests depend on it. [Learn more](https://web.dev/time-to-first-byte/?utm_source=lighthouse&utm_medium=devtools).`FCP` `LCP` 

22. Avoid multiple page redirects

    Redirects introduce additional delays before the page can be loaded. [Learn more](https://web.dev/redirects/?utm_source=lighthouse&utm_medium=devtools).`FCP` `LCP` 

23. Use HTTP/2

    HTTP/2 offers many benefits over HTTP/1.1, including binary headers and multiplexing. [Learn more](https://web.dev/uses-http2/?utm_source=lighthouse&utm_medium=devtools). 

24. User video formats for animated content

    Large GIFs are inefficient for delivering animated content. Consider using MPEG4/WebM videos for animations and PNG/WebP for static images instead of GIF to save network bytes. [Learn more](https://web.dev/efficient-animated-content/?utm_source=lighthouse&utm_medium=devtools) `LCP` 

25. Remove duplicate modules in JavaScript bundles 

    Remove large, duplicate JavaScript modules from bundles to reduce unnecessary bytes consumed by network activity. `TBT` 

26. Avoid serving legacy JavaScript to modern browsers

    Polyfills and transforms enable legacy browsers to use new JavaScript features. However, many aren't necessary for modern browsers. For your bundled JavaScript, adopt a modern script deployment strategy using module/nomodule feature detection to reduce the amount of code shipped to modern browsers, while retaining support for legacy browsers. [Learn More](https://philipwalton.com/articles/deploying-es2015-code-in-production-today/) `TBT` 

27. Preload Largest Contentful Paint image 

    Preload the image used by the LCP element in order to improve your LCP time. [Learn more](https://web.dev/optimize-lcp/?utm_source=lighthouse&utm_medium=devtools#preload-important-resources). `LCP` 

28. Avoids enormous network payloads 

    Large network payloads cost users real money and are highly correlated with long load times. [Learn more](https://web.dev/total-byte-weight/?utm_source=lighthouse&utm_medium=devtools). `LCP` 

29. JavaScript execution time

    Consider reducing the time spent parsing, compiling, and executing JS. You may find delivering smaller JS payloads helps with this. [Learn more](https://web.dev/bootup-time/?utm_source=lighthouse&utm_medium=devtools). `TBT` 

30. All text remains visible during webfont loads 

    Leverage the font-display CSS feature to ensure text is user-visible while webfonts are loading. [Learn more](https://web.dev/font-display/?utm_source=lighthouse&utm_medium=devtools).`FCP` `LCP` 

31. Minimize third-party usage 

    Third-party code can significantly impact load performance. Limit the number of redundant third-party providers and try to load third-party code after your page has primarily finished loading. [Learn more](https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/loading-third-party-javascript/?utm_source=lighthouse&utm_medium=devtools). `TBT` 

32. Lazy load third-party resources with facades 

    Some third-party embeds can be lazy loaded. Consider replacing them with a facade until they are required. [Learn more](https://web.dev/third-party-facades/?utm_source=lighthouse&utm_medium=devtools). `TBT` 

33. Largest Contentful Paint image was not lazily loaded 

    Above-the-fold images that are lazily loaded render later in the page lifecycle, which can delay the largest contentful paint. [Learn more](https://web.dev/lcp-lazy-loading/?utm_source=lighthouse&utm_medium=devtools). 

34. Avoids `document.write()`

    For users on slow connections, external scripts dynamically injected via `document.write()` can delay page load by tens of seconds. [Learn more](https://web.dev/no-document-write/?utm_source=lighthouse&utm_medium=devtools). 

35. Image elements have explicit `width` and `height` 

    Set an explicit width and height on image elements to reduce layout shifts and improve CLS. [Learn more](https://web.dev/optimize-cls/?utm_source=lighthouse&utm_medium=devtools#images-without-dimensions) `CLS` 

36. Has a `<meta name="viewport">` tag with `width` or `initial-scale` 

    A  `<meta name="viewport">` not only optimizes your app for mobile screen sizes, but also prevents [a 300 millisecond delay to user input](https://developers.google.com/web/updates/2013/12/300ms-tap-delay-gone-away?utm_source=lighthouse&utm_medium=devtools). [Learn more](https://web.dev/viewport/?utm_source=lighthouse&utm_medium=devtools). `TBT` 

37. Avoids `unload` event listeners

    The `unload` event does not fire reliably and listening for it can prevent browser optimizations like the Back-Forward Cache. Use `pagehide` or `visibilitychange` events instead. [Learn more](https://web.dev/bfcache/?utm_source=lighthouse&utm_medium=devtools#never-use-the-unload-event) 

some ideas are inferred or epitomized based upon the book *high performance website building* (old but classical) 

# particular strategies to cope with performance

reorganize the thoughts based upon the linear description of **http connection**, **rendering pipeline**. It's more desirable to excavate the intrinsic sight to have sensible thoughts.

## loading performance

1. http protocol

2. cache (eliminate requests)

    [Web Performance Calendar » A Tale of Four Caches (perfplanet.com)](https://calendar.perfplanet.com/2016/a-tale-of-four-caches/) 

3. minify sizes of JavaScript/CSS (critical rendering path)

    @see also: webpack code splitting,  [关键渲染路径 - Web 性能 | MDN (mozilla.org)](https://developer.mozilla.org/zh-CN/docs/Web/Performance/Critical_rendering_path) 

4. Render-blocking resources

    [Eliminate render-blocking resources - Chrome Developers](https://developer.chrome.com/docs/lighthouse/performance/render-blocking-resources/) 

5. Compression

    @keywords: encoding, picture format

    [Optimizing Encoding and Transfer Size of Text-Based Assets (web.dev)](https://web.dev/optimizing-content-efficiency-optimize-encoding-and-transfer/) 

    [Replace animated GIFs with video for faster page loads (web.dev)](https://web.dev/replace-gifs-with-videos/)

6. lazy loading

    [Browser-level image lazy-loading for the web](https://web.dev/browser-level-image-lazy-loading/)

    [Preload, Prefetch And Priorities in Chrome | by Addy Osmani | reloading | Medium](https://medium.com/reloading/preload-prefetch-and-priorities-in-chrome-776165961bbf)  

    @see also: `font-display`, `<img loading>`, `<link media/preload>`, `<script async>`, `intersection observer`, `picture source media`

7. dynamic import

    [import - JavaScript | MDN (mozilla.org)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import#Dynamic_Imports)

8. Caching

    [使用 HTTP 缓存避免不必要的网络请求 (web.dev)](https://web.dev/http-cache/)

9. Code splitting

    [您需要了解的有关 JavaScript 代码拆分的所有信息|创意布洛克 (creativebloq.com)](https://www.creativebloq.com/how-to/all-you-need-to-know-about-javascript-code-splitting) 

    @keywords: dynamic code splitting, Vendor code splitting, entry-point code splitting

10. PRPL Pattern (some ideologies)

    [使用 PRPL 模式实现即时加载 (web.dev)](https://web.dev/apply-instant-loading-with-prpl/) 

## rendering performance

1. eliminate render-blocking resources (DOM/CSS tree building)

    @see also: webpack code splitting

    @see also: async CSS loading, `@import`, `preload`, `prefetch`, `alternate`, `media`, `disabled`

    @see also: `async`, `defer`, `preload`, `prefetch`, `Window.matchMedia`, `MediaQueryList.addListener`

    @see also:  [Link types: preload - HTML: HyperText Markup Language | MDN (mozilla.org)](https://developer.mozilla.org/en-US/docs/Web/HTML/Link_types/preload#scripting_and_preloads) 

2. utilizing composition procedure

    [Rendering Performance (web.dev)](https://web.dev/rendering-performance/#the_pixel_pipeline) 
    
    @see also:  Avoid non-composited animations, passive event listeners,  Avoid an excessive DOM size
    
3. the usage of `requestAnimationFrame`

## particular API to evaluate the performance

@keyword: `lighthouse`, `puppeteer`, `performance API`

[Performance - Web APIs | MDN (mozilla.org)](https://developer.mozilla.org/en-US/docs/Web/API/Performance) 

[How to practically use Performance API to measure performance - LogRocket Blog](https://blog.logrocket.com/how-to-practically-use-performance-api-to-measure-performance/) 

```javascript
let p = window.performance.getEntries();
performance.navigation.redirectCount	//redirect count
p.filter(e => e.initiatorType == 'script').length	//js resource
/**
 * ['script', 'css', 'xmlhttprequest', 'img', 'resource']
 */
```

# relevant links

[如何进行 web 性能监控？ | AlloyTeam](http://www.alloyteam.com/2020/01/14184/)

[How to create high-performance CSS animations](https://web.dev/animations-guide)

[CSS GPU Animation: Doing It Right — Smashing Magazine](https://www.smashingmagazine.com/2016/12/gpu-animation-doing-it-right/) 