---
layout: post
title: "'trainer' - the simplest way to generate a JUnit report of your iOS tests"
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

If you're running tests for your iOS code base on some kind of Continuous Integration, you usually have to generate a JUnit file to report the test results, including error information, to your CI system. Until now, the easiest solution was to use the amazing [xcpretty](https://github.com/supermarin/xcpretty), which parses the `xcodebuild` output and converts it to something more readable, additionally to generating the JUnit report.

Since there were [some difficulties](https://github.com/supermarin/xcpretty/issues/227) with the new Xcode 8, [Peter Steinberger](https://twitter.com/steipete) and me had the idea to parse the test results the same way Xcode server does it: using the [Xcode plist logs](http://michele.io/test-logs-in-xcode). 

[trainer](https://github.com/KrauseFx/trainer) is a simple standalone tool (that also contains a fastlane plugin), which does exactly that: Convert the plist files to JUnit reports.

> By using trainer, the Twitter iOS code base now generates JUnit reports 10 times faster.


To start using [trainer](https://github.com/KrauseFx/trainer), just add the following to your Fastfile:

```ruby
lane :test do
  scan(scheme: "ThemojiUITests", 
       output_types: "", 
       fail_build: false)

  trainer(output_directory: ".")
end
```

By combining [trainer](http://github.com/KrauseFx/trainer) with [danger](http://danger.systems), you can automatically show the failed tests right in your pull request, without having to open the actual output.
  
      
[![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_57ac1cc98419c28d7983eba9_1470897374679__img.png_)](https://github.com/Themoji/ios/pull/26)

For more information about when to use trainer, check out the 
[full blog article on PSPDFKit](https://pspdfkit.com/blog/2016/converting-xcode-test-results-the-fast-way/).
