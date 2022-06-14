---
layout: post
title: 'iOS Privacy: Instagram and Facebook inject code into third party websites'
categories: []
tags:
- ios
- privacy
- hijacking
- instagram
- meta
- facebook
- sniffing
status: publish
type: post
published: true
meta: {}
---

Meta’s apps like Instagram and Facebook are known for locking the user into their own custom web-view to show external websites right within their app. Over 4 years ago, I have published [a blog post about the large risks](https://krausefx.com/blog/follow-user) that come for the user, as well as the website provider, ranging from stealing user’s credentials & data, as well as injecting third party ads.

Both the iOS Instagram and Facebook app render all third party links within their app using a custom in-app browser, tracking every single interaction, from all form inputs, to every single button click.

### What does Meta do?

- Links to external websites are rendered inside the Instagram app, instead of using the built-in Safari or the Apple recommended [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller)
- This allows Instagram to monitor everything happening on external websites, without the consent from the user, nor the website provider.
- The Instagram app injects the <a href="https://developers.facebook.com/docs/meta-pixel">Meta Tracking Pixel</a> into any third party website which allows Instagram to monitor all user interactions with the external website, like every button/link tapped and any form inputs.

### Why is this a big deal?

- Apple actively works on preventing this kind of data sniffing:
  - As of iOS 14.5 [App Tracking Transparency puts the user in control](https://support.apple.com/en-us/HT212025). It requires apps to get the user’s permission before tracking their data across apps or websites owned by other companies.
  - Safari already [blocks third party cookies by default](https://webkit.org/blog/10218/full-third-party-cookie-blocking-and-more/)
- Google Chrome is [soon phasing out third party cookies](https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html)
- Firefox just announced [Total Cookie Protection](https://blog.mozilla.org/en/products/firefox/firefox-rolls-out-total-cookie-protection-by-default-to-all-users-worldwide/) by default to 
- Some ISPs [used to inject their own tracking/ad code into all websites](https://www.infoworld.com/article/2925839/code-injection-new-low-isps.html), however they could only do it for unencrypted pages. With the [rise of HTTPs by default](https://transparencyreport.google.com/https/overview), this isn't an option any more. However, the approach the Instagram & Facebook app use here works for any website, no matter if encrypted or not.

Meta is actively working around the App Tracking Transparency permission system, that was designed to prevent this exact type of data collection.

> Apple’s simple iPhone alert is **costing Facebook $10 billion a year**

> Facebook complained that Apple’s App Tracking Transparency favors companies like Google because App Tracking Transparency “carves out browsers from the tracking prompts Apple requires for apps.”

> Websites you visit on iOS don’t trigger tracking prompts because the anti-tracking features are built in.

&ndash; [Daring Fireball](https://daringfireball.net/linked/2022/02/03/facebook-apple-browser-carve-out) & [MacWorld](https://www.macworld.com/article/611551/facebook-app-tracking-transparency-iphone-quarterly-results.html)

With 1 Billion active Instagram users, the amount of data <i>Meta</i> can collect by injecting tracking SDKs into every third party website opened from the Instagram app is a potentially staggering amount. 
With web browsers and iOS adding more and more privacy controls into the user’s hands, it becomes clear why Meta would be interested in being able to monitor web traffic on external websites.

### Disclaimer

I don’t have proof over the precise data Instagram is sending back home. The Instagram app is well protected against human-in-the-middle attacks, and only by modifying the Android binary to remove certificate pinning and running it in a simulator, I was able to inspect some of its web traffic.

<img src="/assets/posts/hijacking.report/proxyman-android.png" />

Even then, most of the actual data had another layer of encryption/compression. It is clear that the development team really doesn’t want you to investigate what kind of data is sent back to the API. I have decided not to spend more time on this.

<img src="/assets/posts/hijacking.report/proxyman-android-details-3.png" />

Overall the goal of this project wasn’t to get a precise list of data that is sent back, but to highlight the privacy & security issues that are possible due to the use of in-app browsers, as well as showing that companies are exploiting this loophole already.

To summarize the risks and disadvantages of having in-app browsers:

- **Privacy & Analytics:** The host app can track literally everything happening on the website, every tap, input, scrolling behaviour, which content gets copy & pasted, as well as data shown like purchases
- **Stealing of user credentials, physical addresses**, API keys, etc.
- **Ads & Referrals:** The host app can inject advertisements into the website, or replace the ads API key to steal revenue from the host app, or replace all URLs to include your referral code ([this happened before](https://twitter.com/cryptonator1337/status/1269201480105578496))
- **Security:** Browsers spent years optimising the security UX of the web, like showing the HTTPs encryption status, warning the user about sketchy or unencrypted websites, and more
- Injecting additional JavaScript code onto a third party website can cause issues and glitches, potentially breaking the website
- The user’s browser extensions & content blockers aren’t available
- Deep linking doesn’t work well in most cases
- Often no easy way to share a link via other platforms (e.g. via Email, AirDrop, etc.)

Instagram’s in-app browser supports auto-fill for your address, as well as payment information. There is no reason for this to exist in the first place, with all of this already built into the operating system, or the web browser itself.

----

### How to protect yourself as a user?

<div style="float: right">
  <img src="/assets/posts/hijacking.report/instagram_open_in_safari_framed.png" style="max-height: 180px; margin-top: 20px;" />
</div>

#### Escape the in-app-webview

Most in-app browsers will have a way to open the currently rendered website in Safari. As soon as you land on that screen, just use that option to escape it. If that button isn’t available, you will have to copy & paste the URL to open the link in the browser of your choice.

#### Use the web version

Most social networks, including Instagram and Facebook, offer a decent mobile-web version, offering a similar feature set. In the case of Instagram, you can use `https://instagram.com` without issues in iOS Safari.

### How to protect yourself as a website provider?

Until Facebook resolves this issue (if ever), you can quite easily trick the Instagram and Facebook app to believe the Meta Pixel is already installed. Just add the following to your HTML code:

```
<span id="iab-pcm-sdk"></span>
<span id="iab-autofill-sdk"></span>
```

This will not solve the actual problem of Meta running JavaScript code against your website, but at least no additional JS scripts will be injected.

It's easy for an app to detect if the current browser is the Instagram/Facebook app by checking the user agent, however I couldn't find a good way to pop out of the in-app browser automatically to open Safari instead. If you know a solution, I'd [love to know](https://twitter.com/KrauseFx).

### Meta Pixel

The external JavaScript file the Instagram app injects ([connect.facebook.net/en_US/pcm.js](https://connect.facebook.net/en_US/pcm.js)) is the <i>Meta Pixel</i>, as well as some code to build a bridge to communicate with the host app.

> The Meta Pixel is a snippet of JavaScript code that **allows you to track visitor activity on your website**. It works by loading a small library of functions which you can use whenever a site visitor takes an action that you want to track [...]
>
> The Meta Pixel can collect the following data:
> - [...]
> - Button Click Data – Includes any buttons clicked by site visitors, the labels of those buttons and any pages visited as a result of the button clicks.
> - Form Field Names – Includes website field names like email, address, quantity, etc., for when you purchase a product or service. We don’t capture field values unless you include them as part of Advanced Matching or optional values.

&ndash; [developers.facebook.com/docs/meta-pixel](https://developers.facebook.com/docs/meta-pixel) <small>(June 2022)</small>

I highlighted `"The Meta Pixel allows you to track visitor activity on your website"`, as this is where the problem lies: It's perfectly okay for a website provider to decide to implement the Meta pixel to track visitor activity. However in this case, the website provider **did not** consent to having the Facebook Pixel installed. On top of that, the website provider doesn't even have a way to opt-out.

## How it works

To my knowledge, there is no good way to monitor any JavaScript commands that get executed by the host iOS app ([would love to hear if there is a better way](https://twitter.com/KrauseFx)).

I created a new, plain HTML file, with some JS code to override some of the `document.` methods:

```javascript
document.getElementById = function(a, b) {
    appendCommand('document.getElementById("' + a + '")')
    return originalGetElementById.apply(this, arguments);
}
```

Full source code is available on [GitHub](https://github.com/KrauseFx/hijacking.report).

Opening that HTML file from the iOS Instagram app yielded the following:

<div style="text-align: center">
  <img src="/assets/posts/hijacking.report/instagram_framed_cut.png" style="max-width: 310px; margin-bottom: 20px;" />
</div>

Comparing this to what happens when using a normal browser, or in this case, Telegram, which uses the recommended [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller):

<div style="text-align: center">
  <img src="/assets/posts/hijacking.report/SFSafariViewController_framed_cut.png" style="max-width: 310px; margin-bottom: 20px;" />
</div>

As you can see, a regular browser, or [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) doesn’t cause any of those JavaScript events.

## Testing various Meta’s apps

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

WhatsApp is opening iOS Safari by default, therefore no issues.

## Technical Details

<div style="text-align: center; margin-bottom: 15px;">
  <img src="/assets/posts/hijacking.report/flow-chart.png" style="max-width: 450px;" />
</div>

- They check if there is an element with the ID `iab-pcm-sdk`: surprisingly I found very little information about this online. Basically it seems to be a [cross-platform tracking SDK provided by IAB Tech Lab](https://iabtechlab.com/wp-content/uploads/2021/04/Authenticated-UID-APAC-v2.0-Deck.pdf), however I don’t know enough about the relationship between Meta and [IAB Tech Lab](https://iabtechlab.com/) (e.g. [this tweet](https://twitter.com/IABTechLab/status/1519414703239438336))
- If no element with the ID `iab-pcm-sdk` was found, the Meta’s apps create a new `script` element, sets its source to [`https://connect.facebook.net/en_US/pcm.js`](https://connect.facebook.net/en_US/pcm.js), which is the source code for the Meta tracking pixel
- It then finds the first `script` element on your website, and inserts Meta’s JS script right before yours, **injecting the Meta Pixel onto your website**
- Meta’s apps also query for `iframes` on your website, however I couldn’t find any indication of what they’re doing with it

## Proposals

### For Apple

Apple is doing an excellent job building their platform with the user’s privacy in mind. One of the 4 privacy principals

> **User Transparency and Control:** Making sure that users know what data is shared and how it is used, and that they can exercise control over it.

&ndash; [Apple Privacy PDF](https://www.apple.com/privacy/docs/A_Day_in_the_Life_of_Your_Data.pdf) <small>(April 2021)</small>

At the moment of writing, there is no App Review Rule to prohibit companies from building their own in-app browser to watch the user browsing the web, read all inputs, and inject additional ads and tracking to third party websites. However Apple is clearly recommending that we use `SFSafariViewController`.

> Avoid using a web view to build a web browser. Using a web view to let people briefly access a website without leaving the context of your app is fine, but Safari is the primary way people browse the web. **Attempting to replicate the functionality of Safari in your app is unnecessary and discouraged.**

&ndash; [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/content/web-views/) <small>(June 2022)</small>

> **If your app lets users view websites from anywhere on the Internet, use the `SFSafariViewController` class**. If your app customizes, interacts with, or controls the display of web content, use the `WKWebView` class.

&ndash; [Apple SFSafariViewController docs](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) <small>(June 2022)</small>

**Introducing `App-Bound Domains`**

[App-Bound Domains](https://webkit.org/blog/10882/app-bound-domains/) is an excellent new `WebKit` feature to make it possible for developers to offer a safer in-app browsing experience when using `WKWebView`. As an app developer, you can define which domains your app can access, and all web requests will be restricted to those domains. To disable the protection, a user would have to explicitly disable it in the iOS settings app.

App-Bound Domains went live with iOS 14 (~1.5 years ago), however to this day, it's only an opt-in option for developers, meaning the vast majority of iOS apps don't make use of this feature.

> If the developers of SocialApp **want a better user privacy experience** they have two paths forward:
> - Use `SafariViewController` instead of `WKWebView` for in-app browsing. `SafariViewController` protects user data from SocialApp by loading pages outside of SocialApp’s process space. SocialApp can guarantee it is giving its users the best available user privacy experience while using SafariViewController.
> - Opt-in to App-Bound Domains. The additional `WKWebView` restrictions from App-Bound Domains ensure that SocialApp is not able to track users using the APIs outlined above.

I highlighted the `"want a better user privacy experience"` part, as this is the missing piece: App-Bound Domains should be a requirement for all iOS apps, since the social media apps are the ones injecting the tracking code.

**A few immediate steps for Apple to take:**

Update the App Review Rules to require the use of `SFSafariViewController` or [App-Bound Domains](https://webkit.org/blog/10882/app-bound-domains/) when displaying any third party websites.

- There should be only a few exception (like browser apps) that have an extra permission screen
- First-party websites/content can still be displayed using the `WKWebView` class, as they are often used for UI elements, or the app actually modifying their first party content (e.g. auto-dismissing of their own cookie banners)

I've also submitted a radar ([rdar://38109139](https://openradar.appspot.com/radar?id=4963695432040448)) to Apple 4 years ago.

### For Meta

Do what Meta is already doing with WhatsApp: Using Safari or `SFSafariViewController` for all third party websites.

## Hijacking.report website

As part of this research project, I want to share the tools I built to help everyone do the same.

Introducing <a href="https://hijacking.report">hijacking.report</a>, a simple standalone website that prints out a list of all the JavaScript commands that get executed by the host iOS app.

To use <a href="https://hijacking.report">hijacking.report</a>, you’ll have to open the link from within the app you want to test. If it’s a social media app, it’s easiest to just post the link and open it immediately after. If it’s a messenger app, send the link to yourself or a friend and open it from there.

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
