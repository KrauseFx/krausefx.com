---
layout: post
title: 'Introducing fastlane ''match'': A new approach to code signing'
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

[![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5664b78ae4b02b0e953d8de1_1449701730450__img.png_)](https://github.com/fastlane/match)
  


A little over a month ago, 
[fastlane officially joined the Fabric team](https://krausefx.com/blog/fastlane-is-now-part-of-fabric) to help even more developers address pain points within mobile development. Since then, I’ve released several new tools to fastlane, including 
[WatchBuild](https://github.com/fastlane/watchbuild). But one of the biggest pain points I’ve had for years (together with the developer community and my Fabric colleagues), is the headache of code signing when working with teams. This has been an issue since day one of iOS mobile development.

Today, 
**together with the Fabric team, **
**I’m thrilled to introduce match**
 — a new tool that helps automate the code signing process.

When deploying an app to the App Store, a beta testing service or even installing it on your own device, most development teams have separate code signing identities for every member. This results in dozens of profiles including a lot of duplicates.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5668b46fe0327ca58fdb88e6_1449702513395__img.png_)
  


To solve this, you can share one code signing identity with your team to simplify your setup, but here’s the catch: 
**there’s no simple way to keep the profiles and keys between the various machines in sync**
. You would have to manually export those keys using Xcode and transfer them between the machines every time you change something in your app. It’s especially frustrating when all you want is to run the app on your phone to test!

This is why we rethought a whole new declarative approach to solve this, with match.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5668b3b07086d7721f1d39be_1449702323091_match_init.gif_)
  


Once you create your own private Git repo, your certificates and profiles are stored there so you can have one code signing identity for the whole team. 
**When you run fastlane, match automatically fetches the latest certificates from the remote Git repo and installs them on your local machine. **
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5668b2244bf1187dc345398e_1449701931350__img.gif_)
  


If a profile is missing, fastlane will automatically generate one for you and upload it to your Git repo. 

To use match, all you have to do is specify:

* the type of the profile (App Store, Ad Hoc or Development)


* your app’s bundle identifier

Once you provide a separate, private git repo, match will store the iOS certificates provisioning profiles. Additionally, the files are encrypted using 
openssl.

While app development requires care throughout the deployment process, the goal for match was to make it easier to deal with the complexities of code signing when working with a team. With match, fastlane automatically pre-fills environment variables to enable proper code signing with multiple targets.  

To learn more about the concept open
[ codesigning.guide](https://codesigning.guide).

To get access to the source code and more technical information, visit the 
[GitHub](https://github.com/fastlane/match) repo.

### [Open on GitHub](https://github.com/fastlane/match)
