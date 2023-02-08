---
layout: post
title: Introducing WWDC.family
categories: []
tags:
- wwdc
- family
- social
- app
- opensource
status: publish
type: post
published: true
meta: {}
---

### Initial Version: WWDC 2016

<img src="/assets/posts/wwdc.family/wwdc.family-landing-page.jpg" />

The very first version was basically a set of location sharing groups on line.here (app is now discontinued). The app quickly ran into the limitations of the line.here platform.

WWDC week in San Jose is exciting and overwhelming at the same time: so many iOS and Mac developers all in one city. You finally have the chance to meet all the people in person you interact with online usually.

By making a real-time map of all developers you'll be able to spontaneously meet nearby developers or join other groups.

### Custom App: WWDC 2017

The following year I've built a custom app, and used it to learn Firebase and React Native.

<!-- Use an HTML grid to show a total of 4 screenshots, 2 per row -->
<div style="display: grid; grid-template-columns: repeat(2, 1fr); grid-gap: 10px; max-width: 600px; margin: 0 auto;" id="wwdc-screenshots-desktop">
  <img src="/assets/posts/wwdc.family/screenshot4.jpeg" style="max-width: 300px;" />
  <img src="/assets/posts/wwdc.family/screenshot2.jpeg" style="max-width: 300px;" />
  <img src="/assets/posts/wwdc.family/screenshot3.jpeg" style="max-width: 300px;" />
  <img src="/assets/posts/wwdc.family/screenshot5.jpeg" style="max-width: 300px;" />
</div>
<!-- Also, on mobile, show them all on top of each other, in a single column -->
<div style="display: grid; grid-template-columns: 1fr; grid-gap: 10px; max-width: 600px; margin: 0 auto;" id="wwdc-screenshots-mobile">
  <img src="/assets/posts/wwdc.family/screenshot4.jpeg" style="max-width: 300px;" />
  <img src="/assets/posts/wwdc.family/screenshot2.jpeg" style="max-width: 300px;" />
  <img src="/assets/posts/wwdc.family/screenshot3.jpeg" style="max-width: 300px;" />
  <img src="/assets/posts/wwdc.family/screenshot5.jpeg" style="max-width: 300px;" />
</div>

<style type="text/css">
  /* Hide and show wwdc-screenshots-desktop and wwdc-screenshots-mobile based on screen size */
  @media (max-width: 600px) {
    #wwdc-screenshots-desktop {
      display: none !important;
    }
  }
  @media (min-width: 600px) {
    #wwdc-screenshots-mobile {
      display: none !important;
    }
  }
</style>

<br />
The app is fully open source, and you can find the source code on [GitHub](https://github.com/wwdc-family/app). Due to the name, and me not wanting to deal with the App Store Review guidelines, the app was distributed through TestFlight.

### WWDC 2018: ConfFriends

In 2018, I've decided to hand over the app to [@ay8s](https://github.com/ay8s), who re-wrote the app using native code, and renamed it to ConfFriends (to prevent any issues with Apple). With that, I've stopped working on wwdc.family.
