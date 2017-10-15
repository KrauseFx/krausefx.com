---
layout: post
title: "'fastlane' - Connect all iOS deployment tools into one streamlined workflow"
categories: []
tags: []
status: publish
type: post
published: true
meta:
  _thumbnail_id: '103'
---

[![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_54b720a8e4b076c29fb0ab9d_1421287593915_fastlane+Logo.pngfastlane+Logo_)](http://fastlane.tools)
  
Recently I've been working on some really cool iOS related open source tools. All those run independently from each other. This changes with **fastlane.**

There is a really cool website about the project: [http://fastlane.tools](http://fastlane.tools)

With fastlane you define how your app needs to get released to the App Store (or beta testing service).

**Features:**

* Connect all tools, part of the fastlane toolchain to work seamlessly together
* Define different deployment lanes for App Store deployment, beta builds or testing
* Deploy from any computer
* [Jenkins Integration](https://github.com/krausefx/fastlane#jenkins-integration): Show the output directly in the Jenkins test results
* Write your [own actions](https://github.com/krausefx/fastlane#extensions) (extensions) to extend the functionality of fastlane
* Store data like the Bundle Identifier or your Apple ID once and use it across all tools
* Never remember any difficult commands, just fastlane
* Easy setup, which helps you getting up and running very fast
* Shared context, which is used to let the different deployment steps communicate with each other
* Store **everything** in git. Never lookup the used build commands in the Jenkins configs
* Saves you **hours** of preparing app submission, uploading screenshots and deploying the app for each update
* Very flexible configuration using a fully customizable Fastfile
* Once up and running, you have a fully working **Continuous Deployment** process. Just trigger fastlane and you're good to go.

<h3 style="text-align: center; font-size: 40px;">
  <a href="https://fastlane.tools" target="_blank" style="text-decoration: underline;">
    Open fastlane.tools
  </a>
</h3>
