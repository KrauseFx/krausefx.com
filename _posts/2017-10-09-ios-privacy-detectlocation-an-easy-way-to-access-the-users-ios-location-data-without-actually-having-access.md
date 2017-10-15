---
layout: post
title: 'iOS Privacy: detect.location - An easy way to access the user''s iOS location
  data without actually having access'
categories: []
tags:
- ios
- privacy
- location
- images
- library
status: publish
type: post
published: true
meta: {}
---

Does your iOS app have access to the user's image library? Do you want to know your user's movements over the last several years, including what cities they've visited, which iPhones they've owned and how they travel? Do you want all of that data in less a second? Then this project is for you!
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_59db4461cf81e005db7a2062_1507542261614_Screenshot+2017-10-09+11.40.41.png.41.png_)
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_59db44b8f09ca452b53663ab_1507542252323_Screenshot+2017-10-09+11.40.48.png.48.png_)
  
To see all the above with **your** data, download the [DetectLocations app](https://itunes.apple.com/us/app/detectlocations/id1288532777?ls=1&mt=8) from the App Store.

## What can you do with detect.location?

* Get a history of the cities, countries, and other places a user has visited, as long as they took a picture there
* Find the user's place of work, by figuring out where they are from 9 to 5
* Get a complete list of the user's cameras and photography devices (which iPhones, Android phones, cameras) and how long they used each device
* Use facial recognization to find out who the user hangs out with and who their partner is. Is the user single?
* Understand the user's background:
* Did the user attend college? If so, which one?
* Did the user recently move from the suburbs to the city?
* Does the user spend a lot of time with their family?

## What's detect.location?


* The native image picker built into iOS allows app developers to access the **full** image library, with all its metadata
* With the raw PHAsset object, which represents a picture or video, you also get access to the image's metadata. This includes the location and even the speed at which the user was traveling when the picture was taken.
* In particular, an app can get the following data:
* The exact location of each asset
* The physical speed in which the picture/video was taken (how fast did the camera move)
* The camera model
* The exact date + time
* Other exif image metadata
* With this information, you can render a route of the user's travels, into the past for as long as they've had a GPS-enabled camera (like an iPhone, other smartphone, or modern point-and-shoot)
* You can access all of this metadata without analyzing the 
contents of the image at all


For more information about the proposal on how this could be fixed, how the code works and more, check out the GitHub link below.

<h3 style="text-align: center; font-size: 40px;">
  <a href="https://github.com/krausefx/detect.location" target="_blank" style="text-decoration: underline;">
    Open on GitHub
  </a>
</h3>
