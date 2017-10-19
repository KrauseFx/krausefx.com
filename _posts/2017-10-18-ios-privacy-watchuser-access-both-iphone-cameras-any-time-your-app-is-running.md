---
layout: post
title: 'iOS Privacy: watch.user - Access both iPhone cameras any time your app is running'
categories: []
tags:
- ios
- privacy
- phishing
- camera
- video
status: publish
type: post
published: true
meta: {}
---

- Does your app already have access to the user's camera?
- Do you want to take pictures of the user and their surrounding whenever they use your app? 
- Do you want to use face recognition, upload the video material of both the front and the back camera to your server and understand how the user feels? 

Then this project is for you 👌

## Disclaimer

This project is a proof of concept and should not be used in production. The goal is to highlight a privacy loophole that can be abused by iOS apps.

## What does `watch.user` demonstrate?

iOS users often granted camera access to an app a while ago (e.g. a messaging app or any news-feed-based app). Those apps can easily track the users face, take pictures, or live stream their front and back camera, without the user's consent.

- Get full access to the front and back camera of an iPhone/iPad any time your app is running (app must be open)
- Use the front and the back camera to know what your user is doing right now and where the user is located based on image data
- Upload random frames of the video stream to your web service, and run a proper face recognition software, which enables you to
  - Find existing photos of the person on the internet
  - Learn how the user looks like and create a 3d model of the user's face (literally)
- With the recent innovation around faster internet connections, faster processors and more efficient video codecs, a user probably won't notice if you live stream their camera onto the internet (e.g. while they sit on the toilet)
- Estimate the mood of the user based on what you show in your app (e.g. news feed of your app)
- Detect if the user is on their phone alone, or watching together with a second person
- Recording stunning video material from bathrooms around the world, using both the front and the back camera, while the user scrolls through your feed
- Using the built-in iOS 11 Vision framework, every developer can very easily parse facial features in real-time like the eyes, mouth, and the face frame

## Proposal

The MacBook has an elegant solution, where a small LED turns on whenever an app accesses the camera.

- Offer a way to grant temporary access to the camera (e.g. to take and share one picture with a friend on a messaging app)
- Show an icon in the status bar that the camera is active, and force the status bar to be visible whenever an app accesses the camera
- Add an LED to the iPhone's camera (both sides) that can't be worked around by sandboxed apps

TODO: insert Radar here

## About the demo

I didn't submit the demo to the App Store, however you can very easily clone the repo and run it on your own device.

- You first have to take a picture that gets "posted" on a "social network"
  - At this point you already granted full access to both of your cameras every time the app is running
- You browse through a regular news feed that shows you pictures
- After a while you suddenly see pictures of yourself, taken a few seconds ago while you scrolled through the feed
- You realize you've been recorded the whole time, and with it, the app ran a face recognition algorithm to detect facial features.

Chances are, you say:

> Oh, obviously, I never grant camera permission

However, the point is, that if you use a messaging service, like Messenger, WhatsApp, Telegram or anything else, chances are high you already granted permission to access both your image library ([detect.location](https://github.com/KrauseFx/detect.location)), and your camera.

### How can I protect myself?

There is not a lot you can, except to revoke camera access for all apps, always use your built-in camera, and use the image picker of each app to select the photo (which will cause you running into a problem I described with [detect.location](https://github.com/krausefx/detect.location)). To avoid this also, the only good way is to use Copy & Paste to paste the screenshot into your messaging application. If an app has no copy & paste support, you'll have to either expose your image library, or your camera. 

For example, [Soroush](https://twitter.com/khanlou) always removes camera access after using apps like Instagram.

Even better is to protect yourself using hardware, there is a lot of accessories available for both smartphones and laptops that solve the problem by covering the camera ([example](https://www.amazon.com/Original-Webcam-Cover-directly-Manufacturer/dp/B01LWS2X8I)).

## FAQs

### How does the demo app get access to the camera?

Once you take and post one picture or video via a social network app, you often grant full access to the camera, any time the camera is running. Meaning, whenever you start the app, the app can use the camera again.

## Similar projects I worked on 

* [what's the user doing](https://github.com/KrauseFx/whats-the-user-doing): Raising awareness of what you can do with a smartphones gyro sensors in web browsers
* [detect.location](https://github.com/krausefx/detect.location): An easy way to access the user's iOS location data without actually having access
* [steal.password](https://github.com/krausefx/steal.password): Easily get the user's Apple ID password, just by asking

<h3 style="text-align: center; font-size: 40px;">
  <a href="https://github.com/KrauseFx/watch.user" target="_blank" style="text-decoration: underline;">
    Open on GitHub
  </a>
</h3>
