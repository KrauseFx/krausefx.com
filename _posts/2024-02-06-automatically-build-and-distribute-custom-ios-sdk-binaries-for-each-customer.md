---
layout: post
title: 'Automatically build & distribute custom iOS SDK Binaries for each customer'
categories: []
tags:
- ios
- context
- sdk
- swift
- xcframework
- compile
- distribute
- automation
- fastlane
- custom
status: publish
type: post
published: true
meta: {}
---

<img src="/assets/posts/context-sdk/custom-sdk-visual.png">

**Note:** This is a cross-post of the original publication on [contextsdk.com](https://contextsdk.com/blog/automatically-build-distribute-custom-ios-sdk-binaries-for-each-customer).

## Introduction

This is a follow-up post to our original publication: [How to compile and distribute your iOS SDK as a pre-compiled xcframework](/blog/how-to-automaticallycompile-and-distribute-your-ios-sdk-as-a-pre-compiled-xcframework).

In this technical article we go into the depths of best practices around 

- How to automate the deployment of different variants of your SDK to provide a fully customized, white-glove service for your customers
- How this approach allows your SDK to work offline out-of-the box right from the first app start

## Build Automation

For everyone who knows me, I love automating iOS app-development processes. Having built [fastlane](https://fastlane.tools), I learned just how much time you can save, and most importantly: prevent human errors from happening. With ContextSDK, we fully automated the release process. 

For example, you need to properly update the version number across many points: your 2 podspec files (see our [last blog post](/blog/how-to-automaticallycompile-and-distribute-your-ios-sdk-as-a-pre-compiled-xcframework)), your URLs, adding git tags, updating the docs, etc.

## Custom binaries for each customer

With ContextSDK, we train and deploy custom machine learning models for every one of our customers. The easiest way most companies would solve this is by sending a network request the first time the app is launched, to download the latest custom model for that particular app. However, we believe in fast & robust on-device Machine Learning Model execution, that doesn’t rely on an active internet connection. In particular, many major use-cases of ContextSDK rely on reacting to the user’s context within 2 seconds after the app is first launched, to immediately optimize the onboarding flow, permission prompts and other aspects of your app. 

We needed a way to distribute each customer’s custom model with the ContextSDK binary, without including any models from other customers. To do this, we fully automated the deployment of custom SDK binaries, each including the exact custom model, and features the customer needs.

Our customer management system provides the list of custom SDKs to build, tied together with the details of the custom models:

```json
[
  {
    "bundle_identifiers": ["com.customer.app"],
    "app_id": "c2d67cdb-e117-4c3e-acca-2ae7f1a42210",
    "customModels": [
      {
        "flowId": 8362,
        "flowName": "onboarding_upsell",
        "modelVersion": 73
      }, …
    ]
  }, …
]
```
Our deployment scripts will then iterate over each app, and include all custom models for the given app. You can inject custom classes and custom code before each build through multiple approaches. One approach we took to include custom models dynamically depending on the app, is to update our internal podspec to dynamically add files:‍

```ruby
# ...

source_files = Dir['Classes/**/*.swift']
if ENV["CUSTOM_MODEL_APP_ID"]
  source_files += Dir["Classes/Models/Custom/#{ENV["CUSTOM_MODEL_APP_ID"]}/*.mlmodel"]
end

s.source_files = source_files

# ...
```

In the above example you can see how we leverage a simple environment variable to tell CocoaPods which custom model files to include.

Thanks to iOS projects being compiled, we can guarantee integrity of the codebase itself. Additionally we have hundreds of automated tests (and manual tests) to guarantee alignment of the custom models, matching SDK versions, model versions and each customer’s integration in a separate, auto-generated Xcode project.

Side-note: ContextSDK also supports over-the-air updates of new CoreML files, to update the ones we bundle the app with. This allows us to continuously improve our machine learning models over-time, as we calibrate our context signals to each individual app. Under the hood we deploy new challenger-models to a subset of users, for which we compare the performance, and gradually roll them out more if it matches expectations.

## Conclusion

Building and distributing a custom binary for each customer is easier than you may expect. Once your SDK deployment is automated, taking the extra step to build custom binaries isn’t as complex as you may think.

Having this architecture allows us to iterate and move quickly, while having a very robust development and deployment pipeline. Additionally, once we segment our paid features for ContextSDK more, we can automatically only include the subset of functionality each customer wants enabled. For example, we recently launched [AppTrackingTransparency.ai](https://apptrackingtransparency.ai/), where a customer may only want to use the ATT-related features of ContextSDK, instead of using it to optimise their in-app conversions.

If you have any questions, feel free to reach out to us on [Twitter](https://twitter.com/context_sdk) or [LinkedIn](https://www.linkedin.com/company/contextsdk), or subscribe to our newsletter on [contextsdk.com](https://contextsdk.com/blog).

**Note:** This is a cross-post of the original publication on [contextsdk.com](https://contextsdk.com/blog/automatically-build-distribute-custom-ios-sdk-binaries-for-each-customer).
