---
layout: post
title: Letting computers do the hard work
categories: []
tags:
- testflight
- automation
- spaceship
- boarding
status: publish
type: post
published: true
meta: {}
---

<img src="/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_55ab8f76e4b066c866a4ce12_1437306746701__img.jpg_" width="200" align="right" style="margin-left: 10px">
  
As iOS developers we're still used to doing many manual tasks. It's an issue that exists because everything is still new. Just ask your back-end developer about the last time they manually deployed a new version directly to the production server. The answer should be: 
Oh, I was still in high school back then. Why? Because there are many mechanisms before the actual release to avoid broken releases that don't pass the tests.

Using 
[fastlane](https://fastlane.tools) you can already automate a large part of your daily development tasks, but one thing was missing:

>Have you ever been to an airport, where you had to ask the manager of the airport if you can board now? Once the manager agrees, you'll be carried from your check-in to your gate into your plane.


Because that's what you are doing right now as an app developer when you want to invite a beta tester to your TestFlight app. And you even repeat that for every single beta tester you invite.

Right now, you have to go through 9 steps (on the right) just to invite 
one beta tester to your TestFlight program.

Have you ever asked a blog publisher if they add you to their newsletter? No, that's not how that works!

I just launched 
[boarding](https://github.com/fastlane/boarding), a tool that allows you to launch your own 
TestFlight Invite page in under 3 minutes.

More information about this project can be found on 
[GitHub](https://github.com/fastlane/boarding).

### About Automation


If you're reading this post, chances are high you are an iOS/Mac developer. You get paid for developing iOS applications which is probably what you're best in.

**Are you responsible for...?**

* Creating and uploading screenshots
* Updating app metadata like the description
* Manually building and uploading a beta build when your boss tells you to
* Inviting new beta testers to your beta testing service

You probably said yes to some of those points. In my experience most developers do those things manually. Why?

>We haven't got time to automate this stuff, because we're too busy dealing with the problems caused by our lack of automation. - @bitfield

While some developer may enjoy doing passive activities, you usually want to get your job done. That means working on the iOS/Mac app itself working on awesome new features.

That's why we have to follow our friends from the back-end team and start automating tedious processes. Instead of us, computer should do those tasks.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_55afa160e4b073a2ed2814be_1437573474156__img.png)

As you can see, the users interested in beta testing your application accesses your Heroku application directly to enter their email address. The Heroku app will then use [spaceship](https://spaceship.airforce) to communicate with iTunes Connect directly without any interaction from a real person. Spaceship automatically registers the new testers, adds them to the application and sends out the TestFlight email. 

You as an developer are in no way involved in this process. Once you merge into your beta branch, fastlane will go ahead and build, sign and upload your app, resulting in automatic emails to all your testers. (this depends on how you use fastlane)

If you tried the Heroku button, you'll see there are no additional manual steps required to get a web service running. You enter your credentials, choose your application and the web service is up and running. 

### What's next?


The primary use case of [boarding](https://github.com/fastlane/boarding) was not to actually solve this certain problem, but to demonstrate what's possible using [spaceship](https://spaceship.airforce). In only 24 hours I had the idea for boarding, started working on it and released it publicly.

Think about what you can build with [spaceship](https://spaceship.airforce). It's a foundational tool to communicate with Apple's web services, both the Apple Developer Portal and iTunes Connect allowing you to build all kinds of cool things!

**Some random ideas:**

* Automatically sync iTunes Connect users with your company internal user system
* Automatic daily backups of all iTunes Connect and Apple Dev Portal data
* Automatically send customers emails once a new version of their app got approved
* Build a lightweight dashboard for your clients to see a grid of their apps with the current download numbers, reviews and app review status
* Using the same change-log text for all languages? Why should you copy&paste the text manually to 10 languages?
* Added App Review information to your company dashboard or push them directly to Slack
