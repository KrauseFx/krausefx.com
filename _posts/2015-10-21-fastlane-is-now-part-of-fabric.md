---
layout: post
title: fastlane is now part of Fabric
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5626c94ce4b0a834a4586fe4_1445382477643__img.png)
  


**Update 2017:** [fastlane got acquired by Google](https://krausefx.com/blog/fastlane-is-joining-google)

I started [fastlane](https://fastlane.tools) as a side project about a year ago. In just a short time, fastlane became the most popular iOS automation toolset, used by thousands of developers around the world. I never imagined that so many people would use it or how much time it would require to maintain it. It became a full time job!

That’s why today, I'm happy to announce that fastlane is now part of 
[Fabric](https://fabric.io), where I will get to focus on fastlane full time and work on building the best developer tools available.

## What the future holds


[fastlane](https://fastlane.tools) will stay an open source project, and I will continue to work on new features.The Fabric team is committed helping fastlane grow for both existing fastlane users and new ones.

And for the last two months, while I've been working from Twitter HQ in San Francisco, I was able to prepare a few big things:
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5626a0f0e4b03afa9e4d5c9d_1445372150075__img.png)
  


### 1.0 Releases for all tools


In the last few weeks, I’ve been focusing a lot on quality. All fastlane tools now use [spaceship](https://github.com/fastlane/spaceship) to communicate with Apple. I’m very excited that all fastlane tools are now available as 1.0 releases, and I’m really looking forward to the things we’re building next.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5626a100e4b05fed1255d17b_1445372162952__img.jpg)
  


### fastlane for Android (Beta)


fastlane is the most popular Continuous Delivery solution for iOS apps. But I always wanted to make fastlane a tool that both iOS and Android developer could benefit from.

As of today, you can use fastlane for both your iOS and Android projects.[Get started with fastlane for Android](https://github.com/KrauseFx/fastlane/blob/master/docs/Android.md)!
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5626a10ce4b0361a456a04bb_1445372174246__img.png)
  


### snapshot now uses UI Tests


Earlier this year Apple announced Xcode 7 with support for UI Tests. This technology allows 
[snapshot](https://github.com/krausefx/snapshot) to be even better: Instead of using UI Automation Javascript code, you can now write the screenshot code in Swift or Objective C allowing you to use the powerful debugging features built into Xcode. 
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5626a114e4b084f9eefdb281_1445372182626__img.png)
  

 
### New tool: [scan](https://github.com/fastlane/scan)


A lot of developers use fastlane to run tests on their project. Up until now, fastlane used third party test runners to run and monitor tests. As of today, there is a new tool called 
[scan](https://github.com/fastlane/scan),making it super simple to run the tests of your iOS and Mac application.

If you're an existing fastlane user, you can be excited about the next few weeks and what I have in the pipeline. If you're new to fastlane, now is the best time to get started

**Update 2017:** [fastlane got acquired by Google](https://krausefx.com/blog/fastlane-is-joining-google)
