---
layout: post
title: "iOS Privacy: Track website activities, steal user data & credentials and add your own ads to any website in your iOS app"
categories: []
tags:
- security
- privacy
- sdks
status: publish
type: post
published: true
meta: {}
---

## Background

<div class="video" style="float: right; margin-left: 20px">
  <figure>
    <iframe src="//www.youtube.com/embed/ZIogd0kv80c" frameborder="0" allowfullscreen width="170" height="350"></iframe>
  </figure>
</div>

Most iOS apps need to show external web content at some point. Apple provided multiple ways for a developer to do so, the official ones are:

### Launch a URL in Safari

This will use the app switcher to move your own app into the background. This way, the user has their own browser (Safari), with their session and content blocker, browser plugins (e.g. 1Password), etc. As launching Safari puts your app into the background, many app developers are worried the user doesn't come back to them.

Check out the first video to see how this looks in action ➡️

### Use in-app [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller)

Many third party iOS apps use this approach (e.g. Tweetbot). 
<div class="video" style="float: right; margin-left: 20px;">
  <figure>
    <iframe src="//www.youtube.com/embed/EPH5XGbigJU" frameborder="0" allowfullscreen width="170" height="350"></iframe>
  </figure>
</div>
It allows an app developer to use the built-in Safari with all its features, without making the user leave your application. It features all the Safari features, but from within your application.

Check out the second video to see how this looks in action ➡️

### Current state with larger social network apps

Many larger iOS apps re-implemented their own in-app web browser. While this was necessary many years ago, nowadays it's not only not required any more, it actually adds a major risk to the end-user.

Those custom in-app browsers usually use their own UI elements:

*   Custom address bar
*   Custom SSL indicator
*   Custom share button
*   Custom reload button

<img src="/assets/posts/browser/browser.png" width="250" style="float: right; margin-left: 30px" />

## Problems with custom in-app browsers

If an app renders their own [WKWebView](https://developer.apple.com/documentation/webkit/wkwebview), they not only cause inconvenience for the user, but they actually put them at serious risk.


### Convenience


#### User session

The user's login session isn't available, meaning if you get a link to e.g. an Amazon product, you now have to login and enter your 2-factor authentication code to purchase a product.


#### Browser extensions

If the user has browser extensions (like password managers), they won't have access to them in a custom in-app browser.


#### Deep linking

Deep linking itself has multiple open issues on the iOS platform. By using a custom in-app browser, it adds an extra layer that doesn't work well with deep linking. Instead of opening the Amazon app when tapping on an Amazon link in "Social Media App X", it opens the product in a plain web-view, with no login session, and no way to open the product in the app.


#### Content blockers

If the user has content blockers installed, they're not being used by custom in-app browsers. 


#### Bookmarks

<img src="/assets/posts/browser/browser-dialog.png" width="250" style="float: right; margin-left: 30px" />

There is no way for the user to store the current URL in their bookmarks.

#### Share a website

Apps use this opportunity to force their users to use whatever "social features" they think are useful to them. Usually that means locking the user into their ecosystem, and not allowing people to share the content on the platform of their choice. There should be an explicit App Store rule against this.


### Security & Privacy

Using a custom in-app browser, allows the app developer to inject **ANY** JavaScript code into the website the user visits. This means, any content, any data and any input that is shown or stored on the website is accessible to the app.


#### Analytics

This is basically the main reason why in-app browsers are still a thing: It allows the app maintainer to inject additional analytics code, without telling the user. This way, the app's developer can track the following:



*   How long does the user visit the linked website?
*   How fast does the user scroll?
*   Which links does the user open, and how long do they stay on each of them?
*   Combined with [watch.user](https://krausefx.com/blog/ios-privacy-watchuser-access-both-iphone-cameras-any-time-your-app-is-running), the app can record you while you browse third party websites, or even use the iPhone X face sensor to parse your face
*   Every single tap, swipe or any other gesture
*   Device movements, GPS location (if granted) and any other granted iOS sensor, while the app is still in the foreground.


#### User credentials

Any app with an in-app browser can easily steal the user's email address, passwords and two-factor authentication codes. They can do that by injecting JavaScript code that bridges the data over to the app, or directly to a remote host. This is simple, it's basically code like this:

```javascript
email = document.getElementById("email").value
password = document.getElementById("password").value
```

That's all that's needed: just inject the code above to every website, run it on every user's key stroke, and you'll get a nice list of email addresses and passwords.

To run JavaScript in your own web view, you can just use

```ruby
NSString *script = @"document.getElementById('password').value";

[self evaluateJavaScript:script completionHandler:^(id result, NSError *error) { ... }];
```


#### User data

Once the user is logged in, you also get access to the full HTML DOM + JavaScript data & events, which means you have full access to whatever the user sees. This includes things like your emails, your Amazon order history, your friend list, or whatever other data/website you access from an in-app web view.


#### HTTPs

Usually the web browser has a standardised way of indicating the SSL certificate next to the browser's URL. In the case of custom in-app browsers, the SSL logo is being added by the app's author, meaning you trust the app's maintainer to only show the logo if it's actually a valid SSL certificate.


#### Ads

Custom in-app browsers allow all app developers to inject their own ad system into any website that's shown as part of their app. But not only that, they can **replace** the ads identifier of ads that are already shown on the website, so that the revenue goes directly to them, instead of the website owner.

#### And more

These are just some of the things that immediately come to my mind, every time I use an in-app browser, there are probably a lot more evil things a company [or SDK](https://krausefx.com/blog/trusting-sdks) could be doing.


### How can we solve this?

*   Reject apps that don't use [SFSafariViewController](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) or launch Safari directly to show third party website content
*   There should be exceptions, e.g. if a webview is used to show parts of the UI, or dynamic content, but it should be illegal to use webviews to show a linked or third party website

I also [filed a radar for this issue](https://openradar.appspot.com/radar?id=4963695432040448).
