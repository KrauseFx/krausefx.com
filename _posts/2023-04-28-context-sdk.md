---
layout: post
title: 'Context SDK - Introducing the most intelligent way to know how and when to monetize your user'
categories: []
tags:
- ios
- context
- sdk
- swift
- upsell
- in-app
status: publish
type: post
published: true
meta: {}
---

Today, whether your app is opened when your user is taking the bus to work, in bed about to go to sleep, or when out for drinks with friends, your product experience is the same. However, apps of the future will perfectly fit into the context of their users' environment.

As app usage has exploded over the past decade, personalization and user context are becoming increasingly important to grow and retain your userbase. Context SDK enables you to create intelligent products that adapt to users' preferences and needs, all while preserving the user's privacy and battery life using only on-device processing.

Context SDK leverages machine learning to make optimized suggestions when to upsell an in-app purchase, what type of ad and dynamic copy to display, or predict what a user is about to do in your app, and dynamically change the product flows to best fit their current situation.

<div id="context-grid">
    <div class="context-grid-row">
        <div class="context-grid-column">
            <img src="https://krausefx.com/assets/posts/context-sdk/pexels-ketut-subiyanto-4559756.jpg" width="200" />
            <p>Commute on the train</p>
        </div>
        <div class="context-grid-column">
            <img src="https://krausefx.com/assets/posts/context-sdk/pexels-mikotoraw-photographer-3367850.jpg" width="200" />
            <p>Alone and bored at night</p>
        </div>
        <div class="context-grid-column">
            <img src="https://krausefx.com/assets/posts/context-sdk/pexels-ketut-subiyanto-5055180.jpg" width="200" />
            <p>In a loud bar with friends</p>
        </div>
    </div>
</div>

Your users have different needs based on the context of what they are doing and where they are. Shouldn't your app be more personalized to better serve them?

----

Context SDK takes hundreds of signals and builds a highly accurate and complex model, to correlate what a user is doing and the impact it has on in-app conversion events.

<div align="center"><img src="https://krausefx.com/assets/posts/context-sdk/graphs-density_map.png" style="max-width: 100%; width: 550px;"></div>

For example, the above graph shows for how people between 3pm and midnight with a battery level below 60% have significantly lower conversion rates (1.9%) than the rest (2.4%). The X axis represents the time of the day, where 0 is midnight, 0.5 is noon, and 1 is midnight again. The outer bar plot shows the bucket size of the data used.

<div align="center"><img src="https://krausefx.com/assets/posts/context-sdk/graphs-signals.png" style="max-width: calc(100% + 30px); margin-left: -15px;"></div>

Above you can see how various signals affects in-app upsell conversion rates. For example:

- Users are 94% less likely to convert when they're running
- Users are 16% less likely to convert when they have audio playing
- Users are 10% more likely to convert when they're sitting on a couch

<img src="https://krausefx.com/assets/posts/context-sdk/devices-graph.png" />

There is also a big difference in conversion rates depending on the iPhone model, but more importantly, which iOS version the user has installed. People who update their OS are more willing to spend money in your app.


### Context SDK performance

Meta has [published data](https://medium.com/@AnalyticsAtMeta/notifications-why-less-is-more-how-facebook-has-been-increasing-both-user-satisfaction-and-app-9463f7325e7d) on how "less is more" when it comes to notifications and user prompts: Even though in the short-term, just showing something on every possible occasion will increase your chances of the user engaging, in the long-run, you are better off showing fewer prompts, only when the user is most likely to convert.


With Context SDK, you can significantly reduce the number of prompts you show to your users, and a result increase your conversion rates.

<div align="center"><img src="https://krausefx.com/assets/posts/context-sdk/graphs-conversion.png" style="max-width: 100%; width: 420px;" /></div>

This graph visualizes the conversion rate per prompt of 2 buckets:

- 2.45%: The red bar has all events where Context SDK suggested skipping the prompt
- 3.46%: The green bar has all events where Context SDK suggested showing the prompt

The relative difference of the conversion rate between those buckets is **+41%**.

### Context SDK privacy
All processing happens on-device, the SDK doesn't require any additional app permissions, and it will never send any network requests. For more details, check out our [privacy policy](https://contextsdk.com/privacy).

### Tech Details

Context SDK leverages the latest Apple CoreML technology, and uses minimal CPU and battery power. 100% of the code is written in native Swift code, while some of the numerical calculations are done using Objective-C Arrays for even better performance.

Context SDK is super easy to integrate, e.g. to check if now is a good time to upsell:

<img src="https://krausefx.com/assets/posts/context-sdk/code-sample-1.png" style="max-width: 80%;" />

You can also get more information on the current user's activity:

<img src="https://krausefx.com/assets/posts/context-sdk/code-sample-2.png" style="max-width: 90%;" />

--- 

**Context matters!** Large tech companies are already using those techniques to optimise their apps, and now is your chance to benefit from it as well. **[Sign up](https://contextsdk.com)** to get started.

<style type="text/css">
  #context-grid>div {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
  }
  
  #context-grid>div>div {
      flex: 0 0 30%;
      padding: 5px;
  }
  
  #context-grid>div>div>img {
      height: 130px;
      border-radius: 12px;
      box-shadow: 0 0 25px 0px #7aa5c1;
      object-fit: cover;
  }
  
  @media only screen and (min-width: 520px) {
      #context-grid>div>div>img {
          width: calc(100% - 10px);
      }
  }
  
  #context-grid>div>div>p {
      text-align: center;
      margin-top: 10px;
      font-size: 14px;
      color: #666;
  }
</style>
