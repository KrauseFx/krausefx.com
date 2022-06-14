---
layout: post
title: 'iOS Privacy: How Instagram and Facebook inject JavaScript into third party websites'
categories: []
tags:
- ios
- privacy
- hijacking
- instagram
- meta
- facebook
status: publish
type: post
published: true
meta: {}
---

Meta’s apps like Instagram and Facebook are known for locking the user into their own custom web-view to show external websites right within their app. Over 4 years ago, I have published [a blog post about the large risks](https://krausefx.com/blog/follow-user) that come for the user, as well as the website provider, ranging from stealing user’s credentials & data, as well as injecting third party ads.

Both the iOS Instagram and Facebook app render all third party links within their app using a custom in-app browser, tracking every single interaction, from all form inputs, to every single button click.

### What does Meta do?

<div style="text-align: center; margin-bottom: 15px;">
  <img src="/assets/posts/hijacking.report/flow-chart.png" style="max-width: 450px;" />
</div>

1. Links to external websites are rendered inside the Instagram app, instead of using the built-in Safari or the Apple recommended [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller)
2. This allows Instagram to monitor everything happening on external websites, without the consent from the user, nor the website provider.
3. The Instagram app injects the <a href="https://developers.facebook.com/docs/meta-pixel">Meta Tracking Pixel</a> into any third party website which allows Instagram to monitor all user interactions with the external website, like every button/link tapped and any form inputs.

### Why is this a big deal?

- Apple actively works on preventing this kind of data sniffing:
  - As of iOS 14.5 [App Tracking Transparency puts the user in control](https://support.apple.com/en-us/HT212025). It requires apps to get the user’s permission before tracking their data across apps or websites owned by other companies.
  - Safari already [blocks third party cookies by default](https://webkit.org/blog/10218/full-third-party-cookie-blocking-and-more/)
- Google Chrome is [soon phasing out third party cookies](https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html)

Meta is actively working around the App Tracking Transparency permission system, that was designed to prevent this exact type of data collection.

> Apple’s simple iPhone alert is **costing Facebook $10 billion a year**

> Facebook complained that Apple’s App Tracking Transparency favors companies like Google because App Tracking Transparency “carves out browsers from the tracking prompts Apple requires for apps.”

> Websites you visit on iOS don’t trigger tracking prompts because the anti-tracking features are built in.

&ndash; [Daring Fireball](https://daringfireball.net/linked/2022/02/03/facebook-apple-browser-carve-out) & [MacWorld](https://www.macworld.com/article/611551/facebook-app-tracking-transparency-iphone-quarterly-results.html)

With 1 Billion active Instagram users, the amount of data <i>Meta</i> can collect by injecting tracking SDKs into every third party website opened from the Instagram app is a potentially staggering amount.

----

### How to protect yourself as a user?

<div style="float: right">
  <img src="/assets/posts/hijacking.report/instagram_open_in_safari_framed.png" style="max-height: 180px; margin-top: 20px;" />
</div>

#### Escape the in-app-webview

Most in-app browsers will have a way to open the currently rendered website in Safari. As soon as you land on that screen, just use that option to escape it. If that button isn’t available, you will have to copy & paste the URL to open the link in the browser of your choice.

#### Use the web version

Most social networks, including Instagram and Facebook, offer a decent mobile-web version, offering a similar feature set. In the case of Instagram, you can use https://instagram.com without issues in iOS Safari.

### How to protect yourself as a website provider?

Until Facebook publishes an official solution (if ever), you can quite easily trick the Instagram and Facebook app to believe the Meta Pixel is already installed. Just add the following to your HTML code

```html
<span id="iab-pcm-sdk"></span>
<span id="iab-autofill-sdk"></span>
```

This will still have the Facebook and Instagram iOS app run JavaScript to verify the two SDKs are setup, but won’t import, nor run, any other external JS code.

### Meta Pixel

TODO: intro sentence

> The Meta Pixel is a snippet of JavaScript code that **allows you to track visitor activity on your website**. It works by loading a small library of functions which you can use whenever a site visitor takes an action that you want to track [...]
>
> The Meta Pixel can collect the following data:
> - [...]
> - Button Click Data – Includes any buttons clicked by site visitors, the labels of those buttons and any pages visited as a result of the button clicks.
> - Form Field Names – Includes website field names like email, address, quantity, etc., for when you purchase a product or service. We don't capture field values unless you include them as part of Advanced Matching or optional values.

via [developers.facebook.com/docs/meta-pixel](https://developers.facebook.com/docs/meta-pixel) <small>(June 2022)</small>

## How it works

To my knowledge, there is no good way to monitor any JavaScript commands that get executed by the host iOS app ([let me know if you know of a better way](https://krausefx.com/about)).

So I created a new, plain HTML file, with some JavaScript code to override some of the `document.` methods:

```javascript
document.getElementById = function(a, b) {
    resultsList.innerHTML += "<li>document.getElementById(\"" + a + "\")</li>"
    return originalGetElementById.apply(this, arguments);
}
```

Hosting that HTML file, sending the URL as an Instagram DM, and opening it inside the in-app browser, yielded the following:

<div style="text-align: center">
  <img src="/assets/posts/hijacking.report/instagram_framed_cut.png" style="max-width: 310px; margin-bottom: 20px;" />
</div>

Comparing this to what happens when using a normal browser, or in this case, Telegram, which uses the recommended [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller):

<div style="text-align: center">
  <img src="/assets/posts/hijacking.report/SFSafariViewController_framed_cut.png" style="max-width: 310px; margin-bottom: 20px;" />
</div>

As you can see, a regular browser, or [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) doesn’t cause any of those JavaScript events.

## Technical Details

<table class="hijacking-report-screenshot-table">
  <tr>
    <th>Instagram</th>
    <th>Messenger</th>
  </tr>
  <tr>
    <td><img src="/assets/posts/hijacking.report/instagram_framed.png"></td>
    <td><img src="/assets/posts/hijacking.report/messenger_framed.png"></td>
  </tr>
</table>
<table class="hijacking-report-screenshot-table">
  <tr>
    <th>Facebook</th>
    <th>Instagram Android</th>
  </tr>
  <tr>
    <td><img src="/assets/posts/hijacking.report/facebook_framed.png"></td>
    <td><img src="/assets/posts/hijacking.report/android.png"></td>
  </tr>
</table>

Looking at what Meta's apps do:

- They check if there is an element with the ID `iab-pcm-sdk`: surprisingly I found very little information about this online. Basically it seems to be a [cross-platform tracking SDK provided by IAB Tech Lab](https://iabtechlab.com/wp-content/uploads/2021/04/Authenticated-UID-APAC-v2.0-Deck.pdf), however I don’t know anything about the relationship between Meta and [IAB Tech Lab](https://iabtechlab.com/).
- If no element with the ID `iab-pcm-sdk` was found, the Meta's apps create a new `script` element, sets its source to [`https://connect.facebook.net/en_US/pcm.js`](https://connect.facebook.net/en_US/pcm.js), which is the source code for the Meta tracking pixel
- It then finds the first `script` element on your website, and inserts Meta’s JS script right before yours, **injecting the Meta Pixel onto your website**
- Meta's apps also query for `iframes` on your website, however I couldn't find any indication of what they're doing with it

## Proposals

### For Apple

At the moment of writing, there is no App Review Rule to prohibit companies from building their own in-app browser to watch the user browsing the web, read all inputs, and inject additional ads and tracking to third party websites. However Apple is clearly recommending that we use `SFSafariViewController`.

> Avoid using a web view to build a web browser. Using a web view to let people briefly access a website without leaving the context of your app is fine, but Safari is the primary way people browse the web. **Attempting to replicate the functionality of Safari in your app is unnecessary and discouraged.**

&ndash; [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/content/web-views/) <small>(June 2022)</small>

> **If your app lets users view websites from anywhere on the Internet, use the `SFSafariViewController` class**. If your app customizes, interacts with, or controls the display of web content, use the `WKWebView` class.

&ndash; [Apple SFSafariViewController docs](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) <small>(June 2022)</small>

**A few immediate steps to take:**

Update the App Review Rules to require the use of `SFSafariViewController` when displaying any third party websites.
- The only exception should be browser apps
- First-party websites/content can still be displayed using the `WKWebView` class, as they are often used for UI elements, or the app actually modifying their first party content (e.g. auto-dismissing of their own cookie banners)

### For Meta

Do what WhatsApp is already doing: Using Safari or `SFSafariViewController` for all third party websites.

## Hijacking.report website

As part of this research project, I want to share the tools I built to help everyone do the same.

Introducing <a href="https://hijacking.report">hijacking.report</a>, a simple standalone website that prints out a list of all the JavaScript commands that get executed by the host iOS app.

To use <a href="https://hijacking.report">hijacking.report</a>, you'll have to open the link from within the app you want to test. If it's a social media app, it's easiest to just post the link and open it immediately after. If it's a messenger app, send the link to yourself or a friend and open it from there.

<style type="text/css">
  .hijacking-report-screenshot-table {
    width: 98%;
  }
  .hijacking-report-screenshot-table th {
    text-align: center;
  }
  .hijacking-report-screenshot-table td {
    text-align: center;
  }
  .hijacking-report-screenshot-table img {
    max-height: 420px;
  }
</style>
