---
layout: post
title: Automatically download and upload dSYM symbolication files from iTunes Connect
  for Bitcode iOS apps using fastlane
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

When submitting iOS apps to the App Store with Bitcode enabled, your app gets recompiled by Apple, to be optimized for specific devices and architectures. While Bitcode is optional, it's more and more encouraged by Apple, and even required for watchOS and tvOS apps.

Due to the fact that recompiling happens on Apple's servers, third party crash reporters don't have access to the symbolication files, which are required to properly associate the crash stack trace with the exact files and line numbers in your source code.

The current solution to solve this for Bitcode enabled apps is to manually download the dSYM files from Apple and upload them to your crash reporting service. Downloading the files can be done either using Xcode or iTunes Connect. 
  
       
![Download dSYM symbolication files using the Xcode Organizer](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_56fdbe9d746fb9c9ad4a91b8_1459469990425__img.png_)<small>Download dSYM symbolication files using the Xcode Organizer</small>
  


  
       
![Download dSYM symbolication files from iTunes Connect](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_56fdbea92eeb817849350e5b_1459470022763__img.png_)<small>Download dSYM symbolication files from iTunes Connect</small>
  


The problem with this approach is not only the time you spend doing this manually for every single release, but also the lack of automation. There was no way to automatically do this process after every release, or just periodically on every day, so you end up spending a lot of engineering time on repetitive tasks.

## Introducing automatic fastlane dSYM download


With the latest version of 
[fastlane](https://fastlane.tools), you can now easily download all available dSYM symbolication files from iTunes Connect and upload them straight to the crash reporting service of your choice.

```ruby
lane :refresh_dsyms do
  download_dsyms                  # Download dSYM files from iTC
  upload_symbols_to_crashlytics   # Upload them to Crashlytics
  clean_build_artifacts           # Delete the local dSYM files
end
```

All you have to do is define a lane (as seen above) and run:

```
fastlane refresh_dsyms
```

It's easy to just run this task on your existing CI infrastructure every day or so, however you're totally free to trigger it whenever and wherever you want. 
  
       
![dSYM download in action - click on the gif to start it from the beginning](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_56fdd79622482e392236a02c_1459476473900__img.gif_) <small>dSYM download in action</small>
  


You can find more information about the available options in the 
[fastlane docs](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Actions.md#download_dsyms).

Currently the dSYM upload is supported by 
[Crashlytics](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Actions.md#upload_symbols_to_crashlytics), 
[Sentry](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Actions.md#upload_symbols_to_sentry) and 
[HockeyApp](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Actions.md#hockeyapp). If your service is still missing and they provide an API, feel free to submit a PR to add it to fastlane.

## Open Source


As always, everything described in this article is completely open source under the MIT license, check out the following source files:

* [download_dsym.rb](https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/download_dsyms.rb) action (takes care of actually downloading the zip file from iTunes Connect)
* [Access to build details, including dSYM files](https://github.com/fastlane/fastlane/pull/3641) (spaceship code to receive the dSYM download URLs)
* [upload_symbols_to_crashlytics](https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/upload_symbols_to_crashlytics.rb) (Upload the dSYM files to Crashlytics)
* [upload_symbols_to_sentry](https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/upload_symbols_to_sentry.rb) (Upload the dSYM files to Sentry)
* [hockey](https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/hockey.rb) (Upload ipa and dSYM files to Hockey)

****


# Getting started

If you're already using fastlane, just update your existing 
Fastfile and add the new 
refresh_dsyms lane to it.

### Step 1: Install fastlane

If you haven't yet had the change to try 
[fastlane](https://fastlane.tools), now is the perfect time. To quickly get started:

```
[sudo] gem install fastlane --verbose
```

```
cd your/project
```

```
mkdir fastlane && touch fastlane/Fastfile fastlane/Appfile
```

### Step 2: Update Appfile


Edit your `Appfile` to include your bundle identifier and iTunes Connect Apple ID.

### Step 3: Update Fastfile

Update your Fastfile to include the refresh_dsyms lane (seen above). You're all set, now you can run 

### Step 4: Enjoy fastlane

```
fastlane refresh_dsyms
```

On the first run you'll be asked for your password, which will be stored in your local Keychain. 

You wonder what else you can add to your `Fastfile`? Check out the [available actions](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Actions.md) to see all 170 built-in fastlane integrations, you can already use today. 
