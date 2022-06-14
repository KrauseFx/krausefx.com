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

Turns out, both the iOS Instagram and Facebook app render all third party links within their app, tracking every single interaction, from all form inputs, to every single button click.

### Monitoring executed JavaScript

To my knowledge, there is no good way to monitor any JavaScript commands that get executed by the host iOS app ([let me know if you know more](https://krausefx.com/about)).

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

Whoah, okay, and just to be sure this doesn’t happen when using a normal browser, or in this case, Telegram, which uses the recommended [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller):

<div style="text-align: center">
  <img src="/assets/posts/hijacking.report/SFSafariViewController_framed_cut.png" style="max-width: 310px; margin-bottom: 20px;" />
</div>

As you can see, a regular browser, or [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) doesn’t cause any of those JavaScript events, indicating that Instagram is doing something sketchy here.

I’ve tried a few of Meta’s iOS apps, and here are the results:

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

### What does Meta do here?

Looking at what Meta's apps do:

- They check if there is an element with the ID `iab-pcm-sdk`: surprisingly I found quite little information about this online. Basically it seems to be a [cross-platform tracking SDK provided by IAB Tech Lab](https://iabtechlab.com/wp-content/uploads/2021/04/Authenticated-UID-APAC-v2.0-Deck.pdf), however I don’t know anything about the relationship between Meta and [IAB Tech Lab](https://iabtechlab.com/).
- If no element with the ID `iab-pcm-sdk` was found, the Meta's apps create a new `script` element, sets its source to [`https://connect.facebook.net/en_US/pcm.js`](https://connect.facebook.net/en_US/pcm.js), which is the source code for the Meta tracking pixel
- It then finds the first `script` element on your website, and inserts Meta’s JS script right before yours, **injecting the Meta Pixel onto your website**
- Meta's apps also query for iFrames on your website, however I couldn't find any indication of what they're doing with it

## What to do as a user?

<div style="float: right">
  <img src="/assets/posts/hijacking.report/instagram_open_in_safari_framed.png" style="max-height: 180px; margin-top: 20px;" />
</div>

### Escape the in-app-webview

Most in-app browsers will have a way to open the currently rendered website in Safari. As soon as you land on that screen, just use that option to escape it. If that button isn’t available, you will have to copy & paste the URL to open the link in the browser of your choice.


### Use the web version

Most social networks, including Instagram and Facebook, offer a decent mobile-web version, offering a similar feature set. In the case of Instagram, you can use https://instagram.com without issues in iOS Safari.

## What to do as a website operator?

Until Facebook publishes an official solution (if ever), you can quite easily trick the Instagram and Facebook app to believe the Meta Pixel is already installed. Just add the following to your HTML code

```html
<span id="iab-pcm-sdk"></span>
<span id="iab-autofill-sdk"></span>
```

This will still have the Facebook and Instagram iOS app run JavaScript to verify the two SDKs are setup, but won’t import, nor run, any other external JS code.

### Meta Pixel

TODO: intro sentence

> The Meta Pixel is a snippet of JavaScript code that allows you to track visitor activity on your website. It works by loading a small library of functions which you can use whenever a site visitor takes an action (called an event) that you want to track (called a conversion). Tracked conversions appear in the Ads Manager where they can be used to measure the effectiveness of your ads, to define custom audiences for ad targeting, for dynamic ads campaigns, and to analyze that effectiveness of your website's conversion funnels.
> 
> The Meta Pixel can collect the following data:
> 
> - Http Headers – Anything present in HTTP headers. HTTP Headers are a standard web protocol sent between any browser request and any server on the internet. HTTP > Headers include IP addresses, information about the web browser, page location, document, referrer and person using the website.
> - Pixel-specific Data – Includes Pixel ID and the Facebook Cookie.
> - Button Click Data – Includes any buttons clicked by site visitors, the labels of those buttons and any pages visited as a result of the button clicks.
> - Optional Values – Developers and marketers can optionally choose to send additional information about the visit through Custom Data events. Example custom data > events are conversion value, page type and more.
> - Form Field Names – Includes website field names like email, address, quantity, etc., for when you purchase a product or service. We don't capture field values > unless you include them as part of Advanced Matching or optional values.

via https://developers.facebook.com/docs/meta-pixel 2022-06-08



## Proposal

I published more posts on how to access the camera, the user's location data, their Mac screen and their iCloud password, check out [krausefx.com/privacy](/privacy) for more.

---

<h3 style="text-align: center; font-size: 40px; margin-top: 40px">
  <a href="https://github.com/KrauseFx/hijacking.report" target="_blank" style="text-decoration: underline;">
    Open on GitHub
  </a>
</h3>

<style type="text/css">
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
