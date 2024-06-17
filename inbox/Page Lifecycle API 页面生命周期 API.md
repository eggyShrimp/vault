---
Source: https://developer.chrome.com/docs/web-platform/page-lifecycle-api
Author: Philip Walton
---
> ## Excerpt
> 
> The Page Lifecycle API brings app lifecycle features common on mobile operating systems to the web. Browsers are now able to safely freeze and discard background pages to conserve resources, and developers can safely handle these interventions without affecting the user experience.

---

Browser Support

- 68
    
- 79
    
- x
    
- x
    

Modern browsers today will sometimes suspend pages or discard them entirely when system resources are constrained. In the future, browsers want to do this proactively, so they consume less power and memory. The [Page Lifecycle API](https://wicg.github.io/page-lifecycle/spec.html) provides lifecycle hooks so your pages can safely handle these browser interventions without affecting the user experience. Take a look at the API to see whether you should be implementing these features in your application.

## Background

Application lifecycle is a key way that modern operating systems manage resources. On Android, iOS, and recent Windows versions, apps can be started and stopped at any time by the OS. This allows these platforms to streamline and reallocate resources where they best benefit the user.

On the web, there has historically been no such lifecycle, and apps can be kept alive indefinitely. With large numbers of web pages running, critical system resources such as memory, CPU, battery, and network can be oversubscribed, leading to a bad end-user experience.

While the web platform has long had events that related to lifecycle states — like [`load`](https://developer.mozilla.org/docs/Web/Events/load), [`unload`](https://developer.mozilla.org/docs/Web/Events/unload), and [`visibilitychange`](https://developer.mozilla.org/docs/Web/Events/visibilitychange) — these events only allow developers to respond to user-initiated lifecycle state changes. For the web to work reliably on low-powered devices (and be more resource conscious in general on all platforms) browsers need a way to proactively reclaim and re-allocate system resources.

In fact, browsers today already do [take active measures to conserve resources](https://developer.mozilla.org/docs/Web/API/Page_Visibility_API#Policies_in_place_to_aid_background_page_performance) for pages in background tabs, and many browsers (especially Chrome) would like to do a lot more of this — to lessen their overall resource footprint.

The problem is developers have no way to prepare for these types of system-initiated interventions or even know that they're happening. This means browsers need to be conservative or risk breaking web pages.

The [Page Lifecycle API](https://wicg.github.io/page-lifecycle/spec.html) attempts to solve this problem by:

- Introducing and standardizing the concept of lifecycle states on the web.
    
- Defining new, system-initiated states that allow browsers to limit the resources that can be consumed by hidden or inactive tabs.
    
- Creating new APIs and events that allow web developers to respond to transitions to and from these new system-initiated states.
    

This solution provides the predictability web developers need to build applications resilient to system interventions, and it allows browsers to more aggressively optimize system resources, ultimately benefiting all web users.

The rest of this post will introduce the new Page Lifecycle features and explore how they relate to all the existing web platform states and events. It will also give recommendations and best-practices for the types of work developers should (and should not) be doing in each state.

## Overview of Page Lifecycle states and events

All Page Lifecycle states are discrete and mutually exclusive, meaning a page can only be in one state at a time. And most changes to a page's lifecycle state are generally observable via DOM events (see [developer recommendations for each state](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#developer_recommendations_for_each_state) for the exceptions).

Perhaps the easiest way to explain the Page Lifecycle states — as well as the events that signal transitions between them — is with a diagram:

![[Page Lifecycle API 页面生命周期 API/page-lifecycle-api-state-a8e7c36ceae18.svg]]

Page Lifecycle API state and event flow.

### States

The following table explains each state in detail. It also lists the possible states that can come before and after as well as the events developers can use to observe changes.

|State|Description|
|---|---|
|**Active**||
|A page is in the _active_ state if it is visible and has input focus.||

**Possible previous states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) _(via the [`focus`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-focus) event)_ [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(via the [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) event, then the [`pageshow`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pageshow) event)_

**Possible next states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) _(via the [`blur`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-blur) event)_

| | **Passive** |

A page is in the _passive_ state if it is visible and does not have input focus.

**Possible previous states:** [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active) _(via the [`blur`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-blur) event)_ [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden) _(via the [`visibilitychange`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-visibilitychange) event)_ [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(via the [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) event, then the [`pageshow`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pageshow) event)_

**Possible next states:** [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active) _(via the [`focus`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-focus) event)_ [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden) _(via the [`visibilitychange`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-visibilitychange) event)_

| | **Hidden** |

A page is in the _hidden_ state if it is not visible (and has not been frozen, discarded, or terminated).

**Possible previous states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) _(via the [`visibilitychange`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-visibilitychange) event)_ [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(via the [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) event, then the [`pageshow`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pageshow) event)_

**Possible next states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) _(via the [`visibilitychange`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-visibilitychange) event)_ [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(via the [`freeze`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-freeze) event)_ [discarded](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-discarded) _(no events fired)_ [terminated](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-terminated) _(no events fired)_

| | **Frozen** |

In the _frozen_ state the browser suspends execution of [freezable](https://wicg.github.io/page-lifecycle/spec.html#html-task-source-dfn) [tasks](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-task) in the page's [task queues](https://html.spec.whatwg.org/multipage/webappapis.html#task-queue) until the page is unfrozen. This means things like JavaScript timers and fetch callbacks don't run. Already-running tasks can finish (most importantly the [`freeze`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-freeze) callback), but they may be limited in what they can do and how long they can run.

Browsers freeze pages as a way to preserve CPU/battery/data usage; they also do it as a way to enable faster [back/forward navigations](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#back-forward-cache) — avoiding the need for a full page reload.

**Possible previous states:** [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden) _(via the [`freeze`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-freeze) event)_

**Possible next states:** [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active) _(via the [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) event, then the [`pageshow`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pageshow) event)_ [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) _(via the [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) event, then the [`pageshow`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pageshow) event)_ [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden) _(via the [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) event)_ [discarded](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-discarded) _(no events fired)_

| | **Terminated** |

A page is in the _terminated_ state once it has started being unloaded and cleared from memory by the browser. No [new tasks](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-task) can start in this state, and in-progress tasks may be killed if they run too long.

**Possible previous states:** [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden) _(via the [`pagehide`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pagehide) event)_

**Possible next states:** NONE

| | **Discarded** |

A page is in the _discarded_ state when it is unloaded by the browser in order to conserve resources. No tasks, event callbacks, or JavaScript of any kind can run in this state, as discards typically occur under resource constraints, where starting new processes is impossible.

In the _discarded_ state the tab itself (including the tab title and favicon) is usually visible to the user even though the page is gone.

**Possible previous states:** [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(no events fired)_ [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(no events fired)_

**Possible next states:** NONE

|

### Events

Browsers dispatch a lot of events, but only a small portion of them signal a possible change in Page Lifecycle state. The following table outlines all events that pertain to lifecycle and lists what states they may transition to and from.

|Name|Details|
|---|---|
|[`focus`](https://developer.mozilla.org/docs/Web/Events/focus)||
|A DOM element has received focus.||

_**Note:** a `focus` event does not necessarily signal a state change. It only signals a state change if the page did not previously have input focus._

**Possible previous states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive)

**Possible current states:** [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active)

| | [`blur`](https://developer.mozilla.org/docs/Web/Events/blur) |

A DOM element has lost focus.

_**Note:** a `blur` event does not necessarily signal a state change. It only signals a state change if the page no longer has input focus (i.e. the page did not just switch focus from one element to another)._

**Possible previous states:** [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active)

**Possible current states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive)

| | [`visibilitychange`](https://developer.mozilla.org/docs/Web/Events/visibilitychange) |

The document's [`visibilityState`](https://developer.mozilla.org/docs/Web/API/Document/visibilityState) value has changed. This can happen when a user navigates to a new page, switches tabs, closes a tab, minimizes or closes the browser, or switches apps on mobile operating systems.

**Possible previous states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

**Possible current states:** [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

| | [`freeze`](https://wicg.github.io/page-lifecycle/spec.html#sec-api) ***** |

The page has just been frozen. Any [freezable](https://wicg.github.io/page-lifecycle/spec.html#html-task-source-dfn) task in the page's task queues won't be started.

**Possible previous states:** [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

**Possible current states:** [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen)

| | [`resume`](https://wicg.github.io/page-lifecycle/spec.html#sec-api) ***** |

The browser has resumed a _frozen_ page.

**Possible previous states:** [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen)

**Possible current states:** [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active) _(if followed by the [`pageshow`](https://developer.mozilla.org/docs/Web/Events/pageshow) event)_ [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) _(if followed by the [`pageshow`](https://developer.mozilla.org/docs/Web/Events/pageshow) event)_ [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

| | [`pageshow`](https://developer.mozilla.org/docs/Web/Events/pageshow) |

A session history entry is being traversed to.

This could be either a brand new page load or a page taken from the [back/forward cache](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#back-forward-cache). If the page was taken from the back/forward cache, the event's `persisted` property is `true`, otherwise it is `false`.

**Possible previous states:** [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(a [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) event would have also fired)_

**Possible current states:** [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active) [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive) [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

| | [`pagehide`](https://developer.mozilla.org/docs/Web/Events/pagehide) |

A session history entry is being traversed from.

If the user is navigating to another page and the browser is able to add the current page to the [back/forward cache](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#back-forward-cache) to be reused later, the event's `persisted` property is `true`. When `true`, the page is entering the _frozen_ state, otherwise it is entering the _terminated_ state.

**Possible previous states:** [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

**Possible current states:** [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) _(`event.persisted` is true, [`freeze`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-freeze) event follows)_ [terminated](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-terminated) _(`event.persisted` is false, [`unload`](https://developer.mozilla.org/docs/Web/Events/unload) event follows)_

| | [`beforeunload`](https://developer.mozilla.org/docs/Web/Events/beforeunload) |

The window, the document and its resources are about to be unloaded. The document is still visible and the event is still cancelable at this point.

_**Important:** the `beforeunload` event should only be used to alert the user of unsaved changes. Once those changes are saved, the event should be removed. It should never be added unconditionally to the page, as doing so can hurt performance in some cases. See the [legacy APIs section](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#legacy_lifecycle_apis_to_avoid) for details._

**Possible previous states:** [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

**Possible current states:** [terminated](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-terminated)

| | [`unload`](https://developer.mozilla.org/docs/Web/Events/unload) |

The page is being unloaded.

_**Warning:** using the `unload` event is never recommended because it's unreliable and can hurt performance in some cases. See the [legacy APIs section](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#legacy_lifecycle_apis_to_avoid) for more details._

**Possible previous states:** [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden)

**Possible current states:** [terminated](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-terminated)

|

***** Indicates a new event defined by the Page Lifecycle API

### New features added in Chrome 68

The previous chart shows two states that are system-initiated rather than user-initiated: [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) and [discarded](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-discarded). As mentioned previously, browsers today already occasionally freeze and discard hidden tabs (at their discretion), but developers have no way of knowing when this is happening.

In Chrome 68, developers can now observe when a hidden tab is frozen and unfrozen by listening for the [`freeze`](https://wicg.github.io/page-lifecycle/spec.html#sec-api) and [`resume`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-resume) events on `document`.

<span>document</span><span>.</span><span>addEventListener</span><span>(</span><span>'freeze'</span><span>,</span><span> </span><span>(</span><span>event</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>// The page is now frozen.</span><span><br></span><span>});</span><span><br><br>document</span><span>.</span><span>addEventListener</span><span>(</span><span>'resume'</span><span>,</span><span> </span><span>(</span><span>event</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>// The page has been unfrozen.</span><span><br></span><span>});</span><span><br></span>

From Chrome 68 the `document` object now includes a [`wasDiscarded`](https://wicg.github.io/page-lifecycle/spec.html#sec-api) property on desktop Chrome ([Android support is being tracked in this issue](https://issues.chromium.org/issues/40268039)). To determine whether a page was discarded while in a hidden tab, you can inspect the value of this property at page load time (note: discarded pages must be reloaded to use again).

<span>if</span><span> </span><span>(</span><span>document</span><span>.</span><span>wasDiscarded</span><span>)</span><span> </span><span>{</span><span><br>&nbsp; </span><span>// Page was previously discarded by the browser while in a hidden tab.</span><span><br></span><span>}</span><span><br></span>

For advice on what things are important to do in the `freeze` and `resume` events, as well as how to handle and prepare for pages being discarded, see [developer recommendations for each state](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#developer_recommendations_for_each_state).

The next several sections offer an overview of how these new features fit into the existing web platform states and events.

## How to observe Page Lifecycle states in code

In the [active](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-active), [passive](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-passive), and [hidden](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-hidden) states, it's possible to run JavaScript code that determines the current Page Lifecycle state from existing web platform APIs.

<span>const</span><span> getState </span><span>=</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>if</span><span> </span><span>(</span><span>document</span><span>.</span><span>visibilityState </span><span>===</span><span> </span><span>'hidden'</span><span>)</span><span> </span><span>{</span><span><br>&nbsp; &nbsp; </span><span>return</span><span> </span><span>'hidden'</span><span>;</span><span><br>&nbsp; </span><span>}</span><span><br>&nbsp; </span><span>if</span><span> </span><span>(</span><span>document</span><span>.</span><span>hasFocus</span><span>())</span><span> </span><span>{</span><span><br>&nbsp; &nbsp; </span><span>return</span><span> </span><span>'active'</span><span>;</span><span><br>&nbsp; </span><span>}</span><span><br>&nbsp; </span><span>return</span><span> </span><span>'passive'</span><span>;</span><span><br></span><span>};</span><span><br></span>

The [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) and [terminated](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-terminated) states, on the other hand, can only be detected in their respective event listener ([`freeze`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-freeze) and [`pagehide`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pagehide)) as the state is changing.

### How to observe state changes

Building on the `getState()` function defined previously, you can observe all Page Lifecycle state changes with the following code.

<span>// Stores the initial state using the `getState()` function (defined above).</span><span><br>let state </span><span>=</span><span> getState</span><span>();</span><span><br><br></span><span>// Accepts a next state and, if there's been a state change, logs the</span><span><br></span><span>// change to the console. It also updates the `state` value defined above.</span><span><br></span><span>const</span><span> logStateChange </span><span>=</span><span> </span><span>(</span><span>nextState</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>const</span><span> prevState </span><span>=</span><span> state</span><span>;</span><span><br>&nbsp; </span><span>if</span><span> </span><span>(</span><span>nextState </span><span>!==</span><span> prevState</span><span>)</span><span> </span><span>{</span><span><br>&nbsp; &nbsp; console</span><span>.</span><span>log</span><span>(`</span><span>State</span><span> change</span><span>:</span><span> $</span><span>{</span><span>prevState</span><span>}</span><span> </span><span>&gt;&gt;&gt;</span><span> $</span><span>{</span><span>nextState</span><span>}`);</span><span><br>&nbsp; &nbsp; state </span><span>=</span><span> nextState</span><span>;</span><span><br>&nbsp; </span><span>}</span><span><br></span><span>};</span><span><br><br></span><span>// Options used for all event listeners.</span><span><br></span><span>const</span><span> opts </span><span>=</span><span> </span><span>{</span><span>capture</span><span>:</span><span> </span><span>true</span><span>};</span><span><br><br></span><span>// These lifecycle events can all use the same listener to observe state</span><span><br></span><span>// changes (they call the `getState()` function to determine the next state).</span><span><br></span><span>[</span><span>'pageshow'</span><span>,</span><span> </span><span>'focus'</span><span>,</span><span> </span><span>'blur'</span><span>,</span><span> </span><span>'visibilitychange'</span><span>,</span><span> </span><span>'resume'</span><span>].</span><span>forEach</span><span>((</span><span>type</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; window</span><span>.</span><span>addEventListener</span><span>(</span><span>type</span><span>,</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> logStateChange</span><span>(</span><span>getState</span><span>(),</span><span> opts</span><span>));</span><span><br></span><span>});</span><span><br><br></span><span>// The next two listeners, on the other hand, can determine the next</span><span><br></span><span>// state from the event itself.</span><span><br>window</span><span>.</span><span>addEventListener</span><span>(</span><span>'freeze'</span><span>,</span><span> </span><span>()</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>// In the freeze event, the next state is always frozen.</span><span><br>&nbsp; logStateChange</span><span>(</span><span>'frozen'</span><span>);</span><span><br></span><span>},</span><span> opts</span><span>);</span><span><br><br>window</span><span>.</span><span>addEventListener</span><span>(</span><span>'pagehide'</span><span>,</span><span> </span><span>(</span><span>event</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>// If the event's persisted property is `true` the page is about</span><span><br>&nbsp; </span><span>// to enter the back/forward cache, which is also in the frozen state.</span><span><br>&nbsp; </span><span>// If the event's persisted property is not `true` the page is</span><span><br>&nbsp; </span><span>// about to be unloaded.</span><span><br>&nbsp; logStateChange</span><span>(</span><span>event</span><span>.</span><span>persisted </span><span>?</span><span> </span><span>'frozen'</span><span> </span><span>:</span><span> </span><span>'terminated'</span><span>);</span><span><br></span><span>},</span><span> opts</span><span>);</span><span><br></span>

This code does three things:

- Sets the initial state using the `getState()` function.
    
- Defines a function that accepts a next state and, if there's a change, logs the state changes to the console.
    
- Adds [capturing](https://developer.mozilla.org/docs/Web/API/EventTarget/addEventListener#capture) event listeners for all necessary lifecycle events, which in turn call `logStateChange()`, passing in the next state.
    

One thing to note about the code is that all the event listeners are added to `window` and they all pass [`{capture: true}`](https://developer.mozilla.org/docs/Web/API/EventTarget/addEventListener#Syntax). There are a few reasons for this:

- Not all Page Lifecycle events have the same target. `pagehide`, and `pageshow` are fired on `window`; `visibilitychange`, `freeze`, and `resume` are fired on `document`, and `focus` and `blur` are fired on their respective DOM elements.
    
- Most of these events don't bubble, which means it's impossible to add non-capturing event listeners to a common ancestor element and observe all of them.
    
- The capture phase executes before the target or bubble phases, so adding listeners there helps ensure they run before other code can cancel them.
    

## Developer recommendations for each state

As developers, it's important to both understand Page Lifecycle states _and_ know how to observe them in code because the type of work you should (and should not) be doing depends largely on what state your page is in.

For example, it clearly doesn't make sense to display a transient notification to the user if the page is in the hidden state. While this example is pretty obvious, there are other recommendations that aren't so obvious that are worth enumerating.

|State|Developer recommendations|
|---|---|
|**`Active`**||
|The _active_ state is the most critical time for the user and thus the most important time for your page to be [responsive to user input](https://developers.google.com/web/updates/2018/05/first-input-delay).||

Any non-UI work that may block the main thread should be deprioritized to [idle periods](https://developers.google.com/web/updates/2015/08/using-requestidlecallback) or [offloaded to a web worker](https://developers.google.com/web/fundamentals/performance/rendering/optimize-javascript-execution#reduce_complexity_or_use_web_workers).

| | **`Passive`** |

In the _passive_ state the user is not interacting with the page, but they can still see it. This means UI updates and animations should still be smooth, but the timing of when these updates occur is less critical.

When the page changes from _active_ to _passive_, it's a good time to persist unsaved application state.

| | **`Hidden`** |

When the page changes from _passive_ to _hidden_, it's possible the user won't interact with it again until it's reloaded.

The transition to _hidden_ is also often the last state change that's reliably observable by developers (this is especially true on mobile, as users can close tabs or the browser app itself, and the `beforeunload`, `pagehide`, and `unload` events are not fired in those cases).

This means you should treat the _hidden_ state as the likely end to the user's session. In other words, persist any unsaved application state and send any unsent analytics data.

You should also stop making UI updates (since they won't be seen by the user), and you should stop any tasks that a user wouldn't want running in the background.

| | **`Frozen`** |

In the _frozen_ state, [freezable tasks](https://html.spec.whatwg.org/multipage/webappapis.html#queue-a-task) in the [task queues](https://html.spec.whatwg.org/multipage/webappapis.html#task-queue) are suspended until the page is unfrozen — which may never happen (e.g. if the page is discarded).

This means when the page changes from _hidden_ to _frozen_ it's essential that you stop any timers or tear down any connections that, if frozen, could affect other open tabs in the same origin, or affect the browser's ability to put the page in the [back/forward cache](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#back-forward-cache).

In particular, it's important that you:

- Close all open [IndexedDB](https://developer.mozilla.org/docs/Web/API/IndexedDB_API) connections.
    
- Close open [BroadcastChannel](https://developer.mozilla.org/docs/Web/API/Broadcast_Channel_API) connections.
    
- Close active [WebRTC](https://developer.mozilla.org/docs/Web/API/WebRTC_API) connections.
    
- Stop any network polling or close any open [Web Socket](https://developer.mozilla.org/docs/Web/API/WebSockets_API) connections.
    
- Release any held [Web Locks](https://github.com/inexorabletash/web-locks).
    

You should also persist any dynamic view state (e.g. scroll position in an infinite list view) to [`sessionStorage`](https://developer.mozilla.org/docs/Web/API/Window/sessionStorage) (or [IndexedDB via `commit()`](https://developer.mozilla.org/docs/Web/API/IDBTransaction/commit)) that you'd want restored if the page were discarded and reloaded later.

If the page transitions from _frozen_ back to _hidden_, you can reopen any closed connections or restart any polling you stopped when the page was initially frozen.

| | **`Terminated`** |

You generally don't need to take any action when a page transitions to the _terminated_ state.

Since pages being unloaded as a result of user action always go through the _hidden_ state before entering the _terminated_ state, the _hidden_ state is where session-ending logic (e.g. persisting application state and reporting to analytics) should be performed.

Also (as mentioned in the [recommendations for the _hidden_ state](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#advice-hidden)), it's very important for developers to realize that the transition to the _terminated_ state cannot be reliably detected in many cases (especially on mobile), so developers who depend on termination events (e.g. `beforeunload`, `pagehide`, and `unload`) are likely losing data.

| | **`Discarded`** |

The _discarded_ state is not observable by developers at the time a page is being discarded. This is because pages are typically discarded under resource constraints, and unfreezing a page just to allow script to run in response to a discard event is simply not possible in most cases.

As a result, you should prepare for the possibility of a discard in the change from _hidden_ to _frozen_, and then you can react to the restoration of a discarded page at page load time by checking `document.wasDiscarded`.

|

Once again, since reliability and ordering of lifecycle events is not consistently implemented in all browsers, the easiest way to follow the advice in the table is to use [PageLifecycle.js](https://github.com/GoogleChromeLabs/page-lifecycle).

## Legacy lifecycle APIs to avoid

The following events should be avoided where at all possible.

### The unload event

Many developers treat the `unload` event as a guaranteed callback and use it as an end-of-session signal to save state and send analytics data, but doing this is **extremely unreliable**, especially on mobile! The `unload` event does not fire in many typical unload situations, including closing a tab from the tab switcher on mobile or closing the browser app from the app switcher.

For this reason, it's always better to rely on the [`visibilitychange`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-visibilitychange) event to determine when a session ends, and consider the hidden state the [last reliable time to save app and user data](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#advice-hidden).

Furthermore, the mere presence of a registered `unload` event handler (via either `onunload` or `addEventListener()`) can prevent browsers from being able to put pages in the [back/forward cache](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#back-forward-cache) for faster back and forward loads.

In all modern browsers, it's recommended to always use the [`pagehide`](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#event-pagehide) event to detect possible page unloads (a.k.a the [terminated](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-terminated) state) rather than the `unload` event. If you need to support Internet Explorer versions 10 and lower, you should feature detect the `pagehide` event and only use `unload` if the browser doesn't support `pagehide`:

<span>const</span><span> terminationEvent </span><span>=</span><span> </span><span>'onpagehide'</span><span> in self </span><span>?</span><span> </span><span>'pagehide'</span><span> </span><span>:</span><span> </span><span>'unload'</span><span>;</span><span><br><br>window</span><span>.</span><span>addEventListener</span><span>(</span><span>terminationEvent</span><span>,</span><span> </span><span>(</span><span>event</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>// Note: if the browser is able to cache the page, `event.persisted`</span><span><br>&nbsp; </span><span>// is `true`, and the state is frozen rather than terminated.</span><span><br></span><span>});</span><span><br></span>

### The beforeunload event

The `beforeunload` event has a similar problem to the `unload` event, in that, historically, the presence of a `beforeunload` event could prevent pages from being eligible for [back/forward cache](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#back-forward-cache). Modern browsers don't have this restriction. Though some browsers, as a precaution, won't fire the `beforeunload` event when attempting to put a page into the back/forward cache, which means the event is not reliable as an end-of-session signal. Additionally, some browsers (including [Chrome](https://issues.chromium.org/issues/40513391)) require a user-interaction on the page before allowing the `beforeunload` event to fire, further affecting its reliability.

One difference between `beforeunload` and `unload` is that there are legitimate uses of `beforeunload`. For example, when you want to warn the user that they have unsaved changes they'll lose if they continue unloading the page.

Since there are valid reasons to use `beforeunload`, it's recommended that you _only_ add `beforeunload` listeners when a user has unsaved changes and then remove them immediately after they are saved.

In other words, don't do this (since it adds a `beforeunload` listener unconditionally):

<span>addEventListener</span><span>(</span><span>'beforeunload'</span><span>,</span><span> </span><span>(</span><span>event</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; </span><span>// A function that returns `true` if the page has unsaved changes.</span><span><br>&nbsp; </span><span>if</span><span> </span><span>(</span><span>pageHasUnsavedChanges</span><span>())</span><span> </span><span>{</span><span><br>&nbsp; &nbsp; event</span><span>.</span><span>preventDefault</span><span>();</span><span><br><br>&nbsp; &nbsp; </span><span>// Legacy support for older browsers.</span><span><br>&nbsp; &nbsp; </span><span>return</span><span> </span><span>(</span><span>event</span><span>.</span><span>returnValue </span><span>=</span><span> </span><span>true</span><span>);</span><span><br>&nbsp; </span><span>}</span><span><br></span><span>});</span><span><br></span>

Instead do this (since it only adds the `beforeunload` listener when it's needed, and removes it when it's not):

<span>const</span><span> beforeUnloadListener </span><span>=</span><span> </span><span>(</span><span>event</span><span>)</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; event</span><span>.</span><span>preventDefault</span><span>();</span><span><br>&nbsp; <br>&nbsp; </span><span>// Legacy support for older browsers.</span><span><br>&nbsp; </span><span>return</span><span> </span><span>(</span><span>event</span><span>.</span><span>returnValue </span><span>=</span><span> </span><span>true</span><span>);</span><span><br></span><span>};</span><span><br><br></span><span>// A function that invokes a callback when the page has unsaved changes.</span><span><br>onPageHasUnsavedChanges</span><span>(()</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; addEventListener</span><span>(</span><span>'beforeunload'</span><span>,</span><span> beforeUnloadListener</span><span>);</span><span><br></span><span>});</span><span><br><br></span><span>// A function that invokes a callback when the page's unsaved changes are resolved.</span><span><br>onAllChangesSaved</span><span>(()</span><span> </span><span>=&gt;</span><span> </span><span>{</span><span><br>&nbsp; removeEventListener</span><span>(</span><span>'beforeunload'</span><span>,</span><span> beforeUnloadListener</span><span>);</span><span><br></span><span>});</span><span><br></span>

## FAQs

**Why isn't there a "loading" state?**

The Page Lifecycle API defines states to be discrete and mutually exclusive. Since a page can be loaded in either the active, passive, or hidden state, and since it can change states—or even be terminated—before it finishes loading, a separate loading state does not make sense within this paradigm.

**My page does important work when it's hidden, how can I stop it from being frozen or discarded?**

There are lots of legitimate reasons web pages shouldn't be frozen while running in the hidden state. The most obvious example is an app that plays music.

There are also situations where it would be risky for Chrome to discard a page, like if it contains a form with unsubmitted user input, or if it has a `beforeunload` handler that warns when the page is unloading.

For the moment, Chrome is going to be conservative when discarding pages and only do so when it's confident it won't affect users. For example, pages that have been observed to do any of the following while in the hidden state won't be discarded unless under extreme resource constraints:

- Playing audio
    
- Using WebRTC
    
- Updating the table title or favicon
    
- Showing alerts
    
- Sending push notifications
    

For the current list features used to determine whether a tab can be safely frozen or discarded, see: [Heuristics for Freezing & Discarding](https://docs.google.com/document/d/1QJpuBTdllLVflMJSov0tlFX3e3yfSfd_-al2IBavbQM/edit?usp=sharing) in Chrome.

**What is the back/forward cache?**

The [back/forward cache](https://web.dev/articles/bfcache) is a term used to describe a navigation optimization some browsers implement that makes using the back and forward buttons faster.

When a user navigates away from a page, these browsers freeze a version of that page so that it can be quickly resumed in case the user navigates back using the back or forward buttons. Remember that adding an `unload` event handler [prevents this optimization from being possible](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#legacy_lifecycle_apis_to_avoid).

For all intents and purposes, this freezing is functionally the same as the freezing browsers perform to conserve CPU/battery; for that reason it's considered part of the [frozen](https://developer.chrome.com/docs/web-platform/page-lifecycle-api#state-frozen) lifecycle state.

**If I can't run asynchronous APIs in the frozen or terminated states, how can I save data to IndexedDB?**

In frozen and terminated states, [freezable tasks](https://wicg.github.io/page-lifecycle/spec.html#html-task-source-dfn) in a page's [task queues](https://html.spec.whatwg.org/multipage/webappapis.html#task-queue) are suspended, which means asynchronous and callback-based APIs such as IndexedDB cannot be reliably used.

In the future, we will [add a `commit()` method to `IDBTransaction`](https://github.com/w3c/IndexedDB/pull/242) objects, which will give developers a way to perform what are effectively write-only transactions that don't require callbacks. In other words, if the developer is just writing data to IndexedDB and not performing a complex transaction consisting of reads and writes, the `commit()` method will be able to finish before task queues are suspended (assuming the IndexedDB database is already open).

For code that needs to work today, however, developers have two options:

- **Use Session Storage:** [Session Storage](https://developer.mozilla.org/docs/Web/API/Window/sessionStorage) is synchronous and is persisted across page discards.
    
- **Use IndexedDB from your service worker:** a service worker can store data in IndexedDB after the page has been terminated or discarded. In the `freeze` or `pagehide` event listener you can send data to your service worker via [`postMessage()`](https://googlechrome.github.io/samples/service-worker/post-message/), and the service worker can handle saving the data.
    

## Testing your app in the frozen and discarded states

To test how your app behaves in the frozen and discarded states, you can visit `chrome://discards` to actually freeze or discard any of your open tabs.

![[Page Lifecycle API 页面生命周期 API/chrome-discards-ui-4c0620d6f8619.png]]

Chrome Discards UI

This allows you to ensure your page correctly handles the `freeze` and `resume` events as well as the `document.wasDiscarded` flag when pages are reloaded after a discard.

## Summary

Developers who want to respect the system resources of their user's devices should build their apps with Page Lifecycle states in mind. It's critical that web pages are not consuming excessive system resources in situations that the user wouldn't expect

The more developers start implementing the new Page Lifecycle APIs, the safer it will be for browsers to freeze and discard pages that aren't being used. This means browsers will consume less memory, CPU, battery, and network resources, which is a win for users.