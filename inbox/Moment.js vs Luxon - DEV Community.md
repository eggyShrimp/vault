---
Created: 2024-05-12T21:47:08 (UTC +08:00)
tags:
  - javascript
  - software
  - coding
  - development
  - engineering
Source: https://dev.to/zenulabidin/moment-js-vs-luxon-1pn8
Author: Ali Sherief
---
> ## Excerpt
> Where we last left off, I was comparing MomentJS to the native Intl object and came to the conclusion...

---
Where we last left off, I was comparing MomentJS to the native Intl object and came to the conclusion that Intl was more cumbersome to use than MomentJS, but has a smaller footprint, so is suitable for production deployments. Let's see if Luxon can bring that footprint down.

## [Luxon DateTime](https://dev.to/zenulabidin/moment-js-vs-luxon-1pn8#luxon-datetime)

[Luxon](https://moment.github.io/luxon/index.html) is a wrapper around the Intl object that lets you construct date and time strings using a functional programming paradigm. So, things like this are possible:  

```
DateTime.local().setZone('America/New_York').minus({ weeks: 1 }).endOf('day').toISO();
// "2020-10-01T23:59:59.999-04:00"
```

As you can see, it took the current date, October 8, 2020, subtracted a week from it, and fast-fowarded the time to the time just before midnight. Then it's converted into a string using `toISO()`, all previous functions in the chain returned a Luxon object for operating on.

The (roughly) equivalent MomentJS code is this:  

```
moment.tz("America/New_York").subtract(1, 'week').endOf('day').format()
// "2020-10-01T23:59:59-04:00"
```

There we go, an (almost) perfect match. Luxon displays the milliseconds with a string format call, unlike Moment. Luxon is already starting to look viable.

For developers: A Luxon date-time function returns an object of the following structure. This is the return value of the function immediately before `toISO()`, after being passed through all the previous functions:  

```
{
  "ts": 1601611199999,
  "_zone": {
    "zoneName": "America/New_York",
    "valid": true
  },
  "loc": {
    "locale": "en-US",
    "numberingSystem": null,
    "outputCalendar": null,
    "intl": "en-US",
    "weekdaysCache": {
      "format": {},
      "standalone": {}
    },
    "monthsCache": {
      "format": {},
      "standalone": {}
    },
    "meridiemCache": null,
    "eraCache": {},
    "specifiedLocale": null,
    "fastNumbersCached": null
  },
  "invalid": null,
  "weekData": null,
  "c": {
    "year": 2020,
    "month": 10,
    "day": 1,
    "hour": 23,
    "minute": 59,
    "second": 59,
    "millisecond": 999
  },
  "o": -240,
  "isLuxonDateTime": true
}
```

To me, it looks like Luxon relies on `"isLuxonDateTime"` to determine whether the Luxon object passed to it is valid, and not, for example a number or list or MomentJS object. None of these should be modified manually, there's no good reason to do that and you're just reinventing the wheel that's already been made many times by Moment, Intl and Luxon.

## [Luxon Duration](https://dev.to/zenulabidin/moment-js-vs-luxon-1pn8#luxon-duration)

Luxon also supports an object called Duration that represents durations of time. They can be added to DateTime's to get another DateTime, and two DateTimes can be subtracted from each other to get a Duration object. It is very easy to construct a Duration:  

```
var dur = Duration.fromObject({hours: 2, minutes: 7});
dur.toISO()
// "PT2H7M"
```

That's it. The parameters are given inside an object. There is even an object (Interval) that measures the distance between two Duration objects and lets you datamine it for properties.

---

And we're done

The last remaining MomentJS alternative, [Day.js](https://day.js.org/en), is a carbon copy of Moment with a smaller footprint, so I won't cover that one as their APIs are nearly identical.

Thanks for reading. If you saw any errors in the posts in this series, please let me know so I can correct them.

	Please leave your appreciation by commenting on this post!

It takes _one minute_ and is worth it for your career.

[Get started](https://dev.to/enter?state=new-user)

## Extended Reading

> 这是一个系列文章，拓展阅读
> 
> [moment-js-and-its-maintenance-mode-entry-57ai](https://dev.to/zenulabidin/moment-js-and-its-maintenance-mode-entry-57ai)
> [moment-js-vs-intl-object-4f8n](https://dev.to/zenulabidin/moment-js-vs-intl-object-4f8n)
