---
layout: post
title: "iOS apps should be inside a network sandbox"
categories: []
tags:
- privacy
- security
status: publish
type: post
published: true
meta: {}
---

## Background

With my recent publications, most importantly "[Trusting SDKs](https://krausefx.com/blog/trusting-sdks)" it became clear that hijacked or malicious iOS apps cause major security and privacy risks for users, and allow attackers to reach a high number of users through a single point of failure.

Most of the times, the consequences of those attacks are about data:

*   Usernames and passwords
*   Location data
*   Facial data
*   Advertising data
*   Address book entries
*   Payment information (e.g. credit cards)
*   Other personal information

Notice how sandboxes in software are designed to keep data inside that box (in the form of a filesystem), but for some reason they stop when it comes to network requests.

If an attacker manages to hijack an iOS app, the first thing they would do is sent the collected data to some server in their control. 

## Idea

Initially just [tweeting my shower thoughts](https://twitter.com/KrauseFx/status/962116690233339904) and reaching 300 likes & 50 RTs, this idea grew more and more:

{% twitter https://twitter.com/KrauseFx/status/962116690233339904 %}


### App Transport Security

At [WWDC 2016 Apple announced ATS](https://techcrunch.com/2016/06/14/apple-will-require-https-connections-for-ios-apps-by-the-end-of-2016/), an iOS 9 feature to enforce the use of HTTPs across all iOS apps. It was said to be made mandatory by end of 2016, however the deadline was moved to an undefined date. The idea makes perfect sense: All the infrastructure and tools around HTTPs encryption people already have with their web browsers to verify the security on websites, don't work on the iOS platform. If you use your banking or dating app, how can you as a user be sure the company didn't mess things up? [It's not like it happened before](https://techcrunch.com/2018/04/02/grindr-sends-hiv-status-to-third-parties-and-some-personal-data-unencrypted/).


### Web vs iOS

On the web, [browsers started marking HTTP websites as "Not Secure"](https://developers.google.com/web/updates/2016/10/avoid-not-secure-warn), [HSTS is built into browsers to force HTTPs for certain hosts](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security), [people use HTTPSEverywhere to enforce HTTPs connection across more hosts](https://chrome.google.com/webstore/detail/https-everywhere/gcbommkclmclpchllfjekcdonpmejbdp?hl=en) and [people use uBlock to block certain tracking and ad widgets that slow down websites](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm?hl=en).

On iOS, you install and use an app, and hope that the app developer uses proper encryption, securely stores your personal information, and doesn't use any sketchy SDKs that you wouldn't trust yourself. If you don't agree with something (e.g. an Analytics SDK), there is nothing you can do about it.


## Proposal


### Step 1:

Finish the ATS plans. It's been 2 years now, enough time for app developers to update their apps. Allow developers to file for an exception, and mark them accordingly on the App Store page with a badge of shame (similar to how [Chrome marks all non HTTPs websites](https://developers.google.com/web/updates/2016/10/avoid-not-secure-warn) nowadays)


### Step 2:

<img src="/assets/posts/sandboxing.png" width="250" align="right" style="margin: 15px" />

Introduce the concept of network sandboxes. Each app should define a list of hostnames they are allowed to access. 

Imagine a ride-sharing app having access to



*   my-ride-sharing-app.com
*   stripe.com
*   google-analytics.com
*   maps.google.com

This list serves multiple purposes:



*   The app can only access those hosts. Meaning if an SDK is malicious or your app got hijacked in some way, they can't access the scary internet and leak the user's data.
*   The app review team will see a list as they approve the app. At the same time, they can see a diff of the hosts between app releases
*   The user should have a way to see that list as part of the App Store page

As always, exceptions should be possible, third party browsers should exist, and some apps might have to support so many hosts that they can't follow those rules. And that's okay, those apps will be marked as "Can access any host" as a little warning in the App Store.

While the above doesn't solve all the problems, it is a good first step into the right direction. We'll run into problems, and we'll solve them. It's a necessary change for the mobile ecosystem, catching up with where we're already at with web browsers nowadays.
