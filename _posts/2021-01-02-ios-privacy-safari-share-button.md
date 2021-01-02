---
layout: post
title: 'iOS Privacy: Detect when an iOS user hits the Safari share button'
categories: []
tags:
- ios
- privacy
- safari
status: publish
type: post
published: true
meta: {}
---

### Summary

Whenever you hit the "Share" button in iOS Safari, a request gets sent to fetch an iOS home screen app icon, which can be used to track the event.

### Safari

Safari is a great browser, that puts user privacy first. However it could still be better. In 2018 I published some details on how iOS Safari has leaked my bookmark for the last 8 years to all ISPs, WiFis and VPNs I was ever connected to. This was especially interesting, as I haven't used the bookmarks feature in forever, and those bookmarks pointed to OSx86 guides from when I couldn't afford a real Mac:

<a href="https://twitter.com/KrauseFx/status/1001208501111263235">
  <img src="/assets/posts/safari-tweet.png" width="350" />
</a>

### Context

Recently when working on some backend code, I noticed some extra requests that were received by my web server:

<img src="/assets/posts/apple-touch-icon-requests.png" width="500">

<div class="video" style="width: 320px; float: right;margin: 20px">
  <figure>
    <iframe width="310" height="500" src="//www.youtube.com/embed/y5ECangR4fM" frameborder="0" allowfullscreen></iframe>
  </figure>
</div>

Those requests (e.g. `apple-touch-icon-precomposed.png`) are being sent to get the app icon that are used when the user adds your website onto their home screen. All of this makes sense, however they are sent immediately when the user hits the share button, instead of later in the flow when the user actually chooses the `Add to Home Screen` option.

The proof of concept is available on GitHub at [KrauseFx/privacy-share-button](https://github.com/KrauseFx/privacy-share-button), it's a very basic Sinatra + plain HTML/JS website. The server keeps track of the `apple-touch-icon` requests per IP address, and the client simply polls to get the status of it. However there is no reason to render the status on the frontend in the first place.

### Why does it matter?

While this isn't a big privacy problem, it still is an issue that could easily be prevented by Apple. New social media apps like <a href="https://blog.hootsuite.com/tiktok-analytics/">TikTok make use of sharing behaviors</a> on their platform, growth marketers care a lot about all kinds of data, and this getting some extra context on if certain content is being shared **outside** their platform is most likely very much in their interest.

This allows the website operator to also guess with good accuracy **which content** the user hit the share button for, by looking up the most recent page they opened up.

### Similar projects I've worked on 

I published more posts on how to access the camera, the user's location data, their Mac screen and their iCloud password, check out [krausefx.com/privacy](/privacy) for more.
