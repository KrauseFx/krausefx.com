---
layout: post
title: Automatic screenshots for iOS apps
categories:
- Blog
tags:
- automate
- device
- iOS
- iPad
- iPhone
- languages
- screenshot
- screenshots
- uiautomation
status: publish
type: post
published: true
meta: {}
---

[![Instruments](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_54529a2ae4b025a90f45cd18_1414699602733_Instruments.png_)](http://static.squarespace.com/static/545299aae4b0e9514fe30c95/54529a29e4b025a90f45cc50/54529a3ae4b025a90f45d092/1414699578413/?format=original)
  


**Discontinued: Check out 
[snapshot](http://www.felixkrause.at/blog/snapshot-automatically-create-screenshots-of-your-iphone-app) instead.**

I guess all iOS app developers know this problem: You have to take (usually 5) screenshots of the app for all devices (iPhone 4, iPhone 5, iPad) in all supported languages for every update and every app. When I was working for 
[6Wunderkinder](https://felix-krause-f13a.squarespace.com/blog/6-wunderkinder)  we pushed an update with 30 new languages for iPhone, iPad and the Mac. That means we had to take and upload 30 (languages) * (2 (iPhone) + 1 (iPad) + 1 (Mac)) = 
**120**
 screenshots.  

Recently I've been working on a script that automates taking screenshots and saving them properly. It is based on 
**UIAutomation**
. It navigates through your app and takes all needed screenshots automatically. That means you have to write Javascript code for UIAutomation to control your app and take the screenshots.

The scripts can change the language of the iOS simulator and set the system language. All you have to do is define all needed languages and devices types in the 
run file.

After some developers asked about the scripts I open sourced it on GitHub: 
[https://github.com/toursprung/iOS-Screenshot-Automator](https://github.com/toursprung/iOS-Screenshot-Automator)
  
      
[![Automatic taking screenshots iOS](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_54529a2ae4b025a90f45cd1b_1414699603206_ScreenshotToolImage.png_)](http://static.squarespace.com/static/545299aae4b0e9514fe30c95/54529a29e4b025a90f45cc50/54529a2ae4b025a90f45cd1b/1359138373000/ScreenshotToolImage.png?format=original)
