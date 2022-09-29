---
layout: post
title: "'deliver' - the missing API for Apple's new TestFlight"
categories: []
tags: []
status: publish
type: post
published: true
meta:
  structured_content: '{"oembed":{},"overlay":true}'
---

[![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_54c91bace4b0979721668270_1422465969254__img.png)](https://github.com/krausefx/deliver#testflight)
  


The old TestFlight will shut down in February, so it's time to switch to a new Beta Testing service.

While there are some great alternatives to the new TestFlight (like 
[Crashlytics Beta](http://try.crashlytics.com/beta/) and 
[HockeyApp](http://hockeyapp.net/features/)) you might decide to use the official solution for various reasons, however unfortunately there is no public API to implement into your Continuous Integration system any more. 

Introducing **deliver testflight**, an unofficial command line tool to upload your builds to the new Apple TestFlight (now part of iTunes Connect).

All you have to do is install 
[deliver](https://github.com/KrauseFx/deliver) and add the following to your build steps:

```
deliver testflight
```

deliver will fetch all information it needs (e.g. bundle identifier, build number, App ID, IPA file) and will ask you for missing information. You can pass additional parameters too, checkout the
[project page of 
deliver.](https://github.com/KrauseFx/deliver)

If you want a more advanced setup, including a fully working Continuous Deployment solution, which takes screenshots, updates provisioning profiles and creates your push certificate for you, checkout 
[fastlane](https://fastlane.tools).

<h3 style="text-align: center; font-size: 40px;">
  <a href="https://github.com/KrauseFx/deliver" target="_blank" style="text-decoration: underline;">
    Open on GitHub
  </a>
</h3>
