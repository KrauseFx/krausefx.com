---
layout: post
title: spaceship - now also supporting iTunes Connect
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

[![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_55b766a7e4b01425a08f495a_1438082728361__img.png_)](https://spaceship.airforce)
  
It's been about 6 weeks since the initial version of 
[spaceship](https://spaceship.airforce) was released. As you may know, spaceship is the tool that's powering almost all of the other 
[fastlane tools](https://fastlane.tools) to interact with Apple's web-services.

Just 10 days ago I silently rolled out the initial version of 
spaceship for iTunes Connect to use it in the new tools you all have been using already: 
[pilot](https://github.com/fastlane/pilot) and 
[boarding](https://github.com/fastlane/boarding).

I finished implementing all remaining API endpoints and writing the documentation to finally release this:

### Introducing the first version of spaceship for iTunes Connect


Finally you can interact with all important API endpoints the iTunes Connect service has to offer without using the iTunes Connect front-end. All API calls are *really* fast as 
spaceshipcommunicates with the WebObject based back-end directly.

Here are some examples taken from the 
[official documentation](https://github.com/fastlane/spaceship/blob/master/docs/iTunesConnect.md#developer-portal-api):

For more examples check out the 
[official documentation on GitHub](https://github.com/fastlane/spaceship/blob/master/docs/iTunesConnect.md#developer-portal-api).

### What can you do with spaceship for iTunes Connect?

* Manage your applications, update their metadata and even submit apps for review
* Manage your app's builds and get information like the testing status, number of installs, expiry date and even submit builds for TestFlight beta review
* Manage all your beta testers (check out [pilot](https://github.com/fastlane/pilot) and [boarding](https://github.com/fastlane/boarding) as an example project using it)

### What could you build with spaceship for iTunes Connect?


* Automatically sync iTunes Connect users with your company internal user system
* Automatic daily backups of all iTunes Connect and Apple Dev Portal data
* Automatically send customers emails once a new version of their app got approved
* Build a lightweight dashboard for your clients to see a grid of their apps with the current download numbers, reviews and app review status
* Add App Review Notifications (e.g. Waiting for Review) to your company dashboard or push them directly to Slack
  
![A gif showing deliver downloading all existing screenshots from iTunes Connect using spaceship](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_55b76e96e4b072ed2bc9cee7_1438084791574__img.gif_) A gif showing deliver downloading all existing screenshots from iTunes Connect using spaceship
