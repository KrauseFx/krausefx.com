---
layout: post
title: What is the value of iOS code signing?
categories: []
tags:
- codesigning
- ios
status: publish
type: post
published: true
meta: {}
---

All those hours you spend on getting code signing to work properly on your machine, on your CI and on your co-workers Mac… your app and the App Store would be just a safe and secure without it.

## Is code signing really a problem for developers?


**Yes!**
 On the fastlane repo alone, 
[over 1,700 GitHub Issues are related to code signing](https://github.com/fastlane/fastlane/search?utf8=%E2%9C%93&q=%22provisioning+profile%22+OR+%22code+signing%22+OR+%22codesign%22+OR+%22certificate%22+OR+%22codesigning%22&type=Issues). That is over 30% of all incoming requests. On Stackoverflow you can find over 
[3,000 questions](https://stackoverflow.com/search?q=ios+code+signing) around iOS code signing, even though it’s not related to actual code.

## Why do we have to codesign iOS apps?


Code signing is one of the most crucial security components of the iOS ecosystem:

* Code signing allows Apple to control what software can be installed on iOS devices. 


* Code signing ensures your app doesn’t get modified by a third party on the way from your Mac to the end-users iPhone.


* You sign your app with your signature, it ensures that the app is from you.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_58f03fa7d482e960c0f03cd9_1492139949018__img.png_)
  


## What’s the problem with the current process?


Once someone has access to your Apple credentials, they can easily revoke all your certificate, create new ones, and update the provisioning profile to use theirs. 

* When you submit your iOS app for review, the app gets resigned by Apple after being approved, so your code signature isn’t actually used when the end-user downloads your app.


* When you create a new Certificate Signing Request you can select `Saved to disk`. This means, if someone has access to your Apple Developer Account, they can create as many new, valid certificates as they want, without having access to your email account.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_58f03f4186e6c0436eebf811_1492139855970_Screenshot+2017-04-10+06.30.15.png.15.png_)
  


For many iOS developers, the account credentials never leave their computer (e.g. if they use Xcode and 
[fastlane](https://fastlane.tools)), but there is also a handful of third party web services that ask for your Apple ID credentials, which are then stored on their servers. If the service isn't open source, there is no way for you to know how the credentials are stored and secured.

## How to fix iOS code signing? (see what I did there?)


### Don’t require developers to codesign, or make it completely automatic


Don’t require code signing locally on the developer’s machine at all. Tools like the iTunes Transporter already verify the checksums and validity of the uploaded binary. Just by doing this one thing, you never have to deal with code signing again. 

And assuming your Developer account doesn’t have 2-factor auth enabled, there would be no difference in the security across the whole process.

The alternative would be to do all the code signing completely automatic in the background via Xcode. That’s already the case (previously known as Fix Issue button), and it works great for some use-cases, however once your team reaches a certain scale, you’ll quickly run into its limits (see 
[codesigning.guide](https://codesigning.guide)).

### Enforce 2-factor


Enforce 2-step verification for all Apple Developer accounts, offer a way for teams to easily add multiple phone numbers or email addresses. Access to production apps is important enough to enforce 2-step verification for all accounts.

### Require 2 factor auth before resigning the app


Once your app is approved, the owner of the app should be asked to confirm that this version should be shipped. This can be done either via email or SMS verification, but not via the iTunes Connect Web UI directly, as otherwise people with access to the portal could confirm your app release. This could even be its own iTunes Connect role.

### Entitlements


Right now Entitlements are set up on your local machine. This could either be moved onto the server side on iTunes Connect, or work automatically under the hood on your local machine

### Local code signing is still required for Development builds


You’ll always need to sign your app to install it on your actual device, however this became a lot easier over the last two years, as more and more people can use their personal Apple ID to install their app on their real device. This is actually quite critical, as local code signing was abused by multiple app providers to enable people to install apps that are not approved by Apple (e.g. 
[Flux for iOS](https://justgetflux.com/sideload/))

### Ad Hoc builds still require code signing


The above mentioned techniques won’t work for Ad Hoc builds, code signing should still be required as before.
