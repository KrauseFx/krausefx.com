---
layout: post
title: 'iOS Privacy: Instagram and Facebook can track anything you do on any website in their in-app browser'
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

<div class="article-press">
  <a href="https://www.theguardian.com/technology/2022/aug/11/meta-injecting-code-into-websites-visited-by-its-users-to-track-them-research-says">
    <img src="/assets/privacy/TheGuardian.png">
  </a>
  <a href="https://news.ycombinator.com/item?id=32415470">
    <img src="/assets/privacy/hackernews.ico">
  </a>
  <a href="https://www.theregister.com/2022/08/12/meta_ios_privacy/">
    <img src="/assets/privacy/TheRegister.jpg">
  </a>
  <a href="https://finance.yahoo.com/news/meta-can-track-facebook-and-instagram-users-on-ios-with-its-in-app-browsers-071834703.html">
    <img src="/assets/privacy/Yahoo.jpg">
  </a>
  <a href="https://www.macrumors.com/2022/08/10/instagram-tracking-users-in-app-browser/">
    <img src="/assets/privacy/MacRumors.png">
  </a>
  <a href="https://www.heise.de/news/In-App-Browser-auf-dem-iPhone-Experte-sieht-Trackingpotenzial-durch-Meta-7217027.html">
    <img src="/assets/privacy/heise.svg">
  </a>  
  <a href="https://9to5mac.com/2022/08/11/in-app-browsers/">
    <img src="/assets/privacy/9to5.png">
  </a>
  <a href="https://www.t-online.de/digital/internet-sicherheit/sicherheit/id_100038034/meta-konzern-kann-nutzeraktivitaeten-verfolgen.html">
    <img src="/assets/privacy/t-online.png">
  </a>
  <a href="https://www.engadget.com/meta-can-track-facebook-and-instagram-users-on-ios-with-its-in-app-browsers-071834703.html">
    <img src="/assets/privacy/engadget.png">
  </a>
  <a href="https://www.cnbctv18.com/technology/instagram-can-track-a-users-web-activity-via-in-app-browser-claims-report-14448592.htm">
    <img src="/assets/privacy/cnbc.png">
  </a>
  <a href="https://www.derstandard.at/story/2000138185950/facebook-und-instagram-apps-koennten-alles-mitlesen-was-die-nutzer">
    <img src="/assets/privacy/derStandard.gif">
  </a>
  <a href="https://abc3340.com/news/nation-world/meta-can-track-users-credit-card-internet-history-on-other-websites-research-claims-facebook-instagram-felix-krause-code-google-engineer">
    <img src="/assets/privacy/abc-logo.png" style="opacity: 0.9">
  </a>
  <a href="https://wfxl.com/news/nation-world/meta-can-track-users-credit-card-internet-history-on-other-websites-research-claims-facebook-instagram-felix-krause-code-google-engineer">
    <img src="/assets/privacy/FoxNews.png" style="opacity: 0.9">
  </a>
  <a href="https://metro.co.uk/2022/08/15/instagram-and-facebook-stalk-you-on-sites-accessed-through-their-apps-17184243/">
    <img src="/assets/privacy/metrocouk.jpg" style="max-width: 75px">
  </a>
  <a href="https://lifehacker.com/dont-use-in-app-browsers-for-anything-important-1849401900">
    <img src="/assets/privacy/lifehacker.png" />
  </a>
  <a href="https://www.thesun.co.uk/tech/19513404/facebook-instagram-stalking-off-app-tracking">
    <img src="/assets/privacy/thesun.png" style="max-width: 65px" />
  </a>
</div>

<hr style="margin-bottom:20px" />

**Update:** A week later, I've published a new post, looking into other apps including TikTok, where I also found an additional JavaScript event listener of Instagram which can monitor all taps on third party websites.

**[Check it out here](/blog/announcing-inappbrowsercom-see-what-javascript-commands-get-executed-in-an-in-app-browser)**

<hr />

<div id="instagram-framed-top">
  <a href="https://krausefx.com/assets/posts/injecting-code/instagram_framed.png" target="_blank">
    <img src="https://krausefx.com/assets/posts/injecting-code/instagram_framed.png" style="width: 250px" alt="An iPhone screenshot, showing a website, rendering what commands got executed by the Instagram app in their in-app browser: 
      Detected JavaScript Events:
        1.
        document. addEventListener ('selectionchange'
        2.
        function ()
        {
        window.webkit.messageHandlers.fb getSelecti
        onScriptMessageHandler.postMessage(getSelec
        tedText)):
        3. }
        4.
        document. getElementById('iab-pcm-sdk')
        5.
        document.createElement ('script')
        6.
        FakeScriptobj.src
        'https://connect.facebook.net/en US/pcm.is'
        7. document. getElementsByTagName ('script')
        8.
        TagObjectArr[0]
        9.
        TagObjectArr[x].parentNode
        10.
        TagobjectArr[x].parentNode.insertBefore
        11.
        document.getElementsByTagName('iframe')"
     >
  </a>
</div>

The iOS Instagram and Facebook app render all third party links and ads within their app using a custom in-app browser. This [causes various risks for the user](https://krausefx.com/blog/follow-user), with the host app being able to track every single interaction with external websites, from all form inputs like passwords and addresses, to every single tap.

<div style="border-left: 2px solid #00558d; padding-left: 20px; padding: 10px; background-color: rgba(0, 150, 200, 0.1);">
  <b>Note:</b> To keep this post simple, I'll use "Instagram" instead of "Meta" or "Facebook"
</div>

### What does Instagram do?

- Links to external websites are rendered inside the Instagram app, instead of using the built-in Safari.
- This allows Instagram to monitor everything happening on external websites, without the consent from the user, nor the website provider.
- The Instagram app injects <a href="https://connect.facebook.net/en_US/pcm.js">their JavaScript code</a> into every website shown, including when clicking on ads. Even though the injected script doesn't currently do this, running custom scripts on third party websites allows them to monitor all user interactions, like every button & link tapped, text selections, screenshots, as well as any form inputs, like passwords, addresses and credit card numbers.

### Why is this a big deal?

- Apple actively works against cross-host tracking:
  - As of iOS 14.5 [App Tracking Transparency puts the user in control](https://support.apple.com/en-us/HT212025): Apps need to get the user’s permission before tracking their data across apps owned by other companies.
  - Safari already [blocks third party cookies by default](https://webkit.org/blog/10218/full-third-party-cookie-blocking-and-more/)
- Google Chrome is [soon phasing out third party cookies](https://blog.chromium.org/2020/01/building-more-private-web-path-towards.html)
- Firefox just announced [Total Cookie Protection](https://blog.mozilla.org/en/products/firefox/firefox-rolls-out-total-cookie-protection-by-default-to-all-users-worldwide/) by default to prevent any cross-page tracking
- Some ISPs [used to inject their own tracking/ad code into all websites](https://www.infoworld.com/article/2925839/code-injection-new-low-isps.html), however they could only do it for unencrypted pages. With the [rise of HTTPs by default](https://transparencyreport.google.com/https/overview), this isn't an option any more. The approach the Instagram & Facebook app uses here works for any website, no matter if it's encrypted or not.

After the App Tracking Transparency was introduced, <i>Meta</i> announced:

> Apple’s simple iPhone alert is **costing Facebook $10 billion a year**

> Facebook complained that Apple’s App Tracking Transparency favors companies like Google because App Tracking Transparency “carves out browsers from the tracking prompts Apple requires for apps.”

> Websites you visit on iOS don’t trigger tracking prompts because the anti-tracking features are built in.

&ndash; [Daring Fireball](https://daringfireball.net/linked/2022/02/03/facebook-apple-browser-carve-out) & [MacWorld](https://www.macworld.com/article/611551/facebook-app-tracking-transparency-iphone-quarterly-results.html)

With 1 Billion active Instagram users, the amount of data Instagram can collect by injecting the tracking code into every third party website opened from the Instagram & Facebook app is a staggering amount. 

With web browsers and iOS adding more and more privacy controls into the user’s hands, it becomes clear why Instagram is interested in monitoring all web traffic of external websites.

> Facebook bombarded its users with messages begging them to turn tracking back on. It threatened an antitrust suit against Apple. It got small businesses to defend user-tracking, claiming that when a giant corporation spies on billions of people, that’s a form of small business development.

&ndash; [EFF - Facebook Says Apple is Too Powerful. They're Right.](https://www.eff.org/deeplinks/2022/06/facebook-says-apple-too-powerful-theyre-right)

**Note added on 2022-08-11:** Meta is following the ATT (App Tracking Transparency) rules (as added as a note at the bottom of the article). I explained the above to provide some context on why getting data from third party websites/apps is a big deal. The message of this article is about how the iOS Instagram app actively injects and executes JavaScript code on third party websites, using their in-app browser. This article does not talk about the legal aspect of things, but the technical implementation of what is happening, and what is possible on a technical level.

## FAQs for non-tech readers

- **Can Instagram/Facebook read everything I do online?** No! Instagram is only able to read and watch your online activities when you open a link or ad from within their apps.
- **Does Facebook actually steal my passwords, address and credit card numbers?** No! I didn't prove the exact data Instagram is tracking, but wanted to showcase the kind of data they *could* get without you knowing. As shown in the past, if it's possible for a company to get access to data legally and for free, without asking the user for permission, [they will track it](https://twitter.com/steipete/status/1025024813889478656?lang=en).
- **How can I protect myself?** For full details [scroll down to the end of the article](#how-to-protect-yourself-as-a-user). Summary: Whenever you open a link from Instagram (or Facebook or Messenger), make sure to click the dots in the corner to open the page in Safari instead.
- **Is Instagram doing this on purpose?** I can't say how the decisions were made internally. All I can say is that building your own in-app browser takes a non-trivial time to program and maintain, significantly more than just using the privacy and user-friendly alternative that's already been built into the iPhone for the past 7 years.

---

### What gets injected?

The external JavaScript file the Instagram app injects is the ([connect.facebook.net/en_US/pcm.js](https://connect.facebook.net/en_US/pcm.js)) which is code to build a bridge to communicate with the host app. According to Meta's info provided to me in response to this publication, it helps aggregate events, i.e. online purchase, before those events are used for targeted advertising and measurement for the Facebook platform.

### Disclaimer

I don’t have a list of precise data Instagram sends back home. I do have proof that the Instagram and Facebook app actively run JavaScript commands to inject an additional JavaScript SDK without the user’s consent, as well as tracking the user's text selections. If Instagram is doing this already, they could also inject any other JavaScript code. The Instagram app itself is well protected against human-in-the-middle attacks, and only by modifying the Android binary to remove certificate pinning and running it in a simulator.

---

Overall the goal of this project wasn’t to get a list of data that is sent back, but to highlight the privacy & security issues that are caused by the use of in-app browsers, as well as to **prove that apps like Instagram are already exploiting this loophole**.

To summarize the risks and disadvantages of having in-app browsers:

- **Privacy & Analytics:** The host app can track literally everything happening on the website, every tap, input, scrolling behavior, which content gets copy & pasted, as well as data shown like online purchases
- **Stealing of user credentials, physical addresses**, API keys, etc.
- **Ads & Referrals:** The host app can inject advertisements into the website, or replace the ads API key to steal revenue from the host app, or replace all URLs to include your referral code ([this happened before](https://twitter.com/cryptonator1337/status/1269201480105578496))
- **Security:** Browsers spent years optimizing the security UX of the web, like showing the HTTPs encryption status, warning the user about sketchy or unencrypted websites, and more
- Injecting additional JavaScript code onto a third party website can cause issues and glitches, potentially breaking the website
- The user’s browser extensions & content blockers aren’t available
- Deep linking doesn’t work well in most cases
- Often no easy way to share a link via other platforms (e.g. via Email, AirDrop, etc.)

Instagram’s in-app browser supports auto-fill of your address and payment information. However there is no legit reason for this to exist in the first place, with all of this already built into the operating system, or the web browser itself.

## Testing various Meta’s apps

<table class="hijacking-report-screenshot-table">
  <tr>
    <th>Instagram iOS</th>
    <th>Messenger iOS</th>
  </tr>
  <tr>
    <td><a href="https://krausefx.com/assets/posts/injecting-code/instagram_framed.png" target="_blank"><img src="https://krausefx.com/assets/posts/injecting-code/instagram_framed.png" alt="An iPhone screenshot, showing a website, rendering what commands got executed by the Instagram app in their in-app browser: 
      Detected JavaScript Events:
        1.
        document. addEventListener ('selectionchange'
        2.
        function ()
        {
        window.webkit.messageHandlers.fb getSelecti
        onScriptMessageHandler.postMessage(getSelec
        tedText)):
        3. }
        4.
        document. getElementById('iab-pcm-sdk')
        5.
        document.createElement ('script')
        6.
        FakeScriptobj.src
        'https://connect.facebook.net/en US/pcm.is'
        7. document. getElementsByTagName ('script')
        8.
        TagObjectArr[0]
        9.
        TagObjectArr[x].parentNode
        10.
        TagobjectArr[x].parentNode.insertBefore
        11.
        document.getElementsByTagName('iframe')"></a></td>
    <td><a href="https://krausefx.com/assets/posts/injecting-code/messenger_framed.png" target="_blank"><img src="https://krausefx.com/assets/posts/injecting-code/messenger_framed.png" alt="The same code as the previous photo, however this time inside Facebook Messenger"></a></td>
  </tr>
</table>
<table class="hijacking-report-screenshot-table">
  <tr>
    <th>Facebook iOS</th>
    <th>Instagram Android</th>
  </tr>
  <tr>
    <td><a href="https://krausefx.com/assets/posts/injecting-code/facebook_framed.png" target="_blank"><img src="https://krausefx.com/assets/posts/injecting-code/facebook_framed.png" alt="The same code as the previous photo, however this time inside the Facebook iOS app"></a></td>
    <td><a href="https://krausefx.com/assets/posts/injecting-code/android_framed.png" target="_blank"><img src="https://krausefx.com/assets/posts/injecting-code/android_framed.png" alt="The same code as the previous photo, however this time inside Android Instagram"></a></td>
  </tr>
</table>

WhatsApp is opening iOS Safari by default, therefore no issues.

## How it works

To my knowledge, there is no good way to monitor all JavaScript commands that get executed by the host iOS app ([would love to hear if there is a better way](https://twitter.com/KrauseFx)).

I created a new, plain HTML file, with some JS code to override some of the `document.` methods:

```javascript
document.getElementById = function(a, b) {
    appendCommand('document.getElementById("' + a + '")')
    return originalGetElementById.apply(this, arguments);
}
```

Opening that HTML file from the iOS Instagram app yielded the following:

<div style="text-align: center">
  <a href="https://krausefx.com/assets/posts/injecting-code/instagram_framed_cut.png" target="_blank"><img src="https://krausefx.com/assets/posts/injecting-code/instagram_framed_cut.png" alt="The same code as the previous screenshots" style="max-width: 310px; margin-bottom: 20px;" /></a>
</div>

Comparing this to what happens when using a normal browser, or in this case, Telegram, which uses the recommended [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller):

<div style="text-align: center">
  <a href="https://krausefx.com/assets/posts/injecting-code/SFSafariViewController_framed_cut.png" target="_blank"><img src="https://krausefx.com/assets/posts/injecting-code/SFSafariViewController_framed_cut.png" style="max-width: 310px; margin-bottom: 20px;" alt="SFSafariViewController rendering the same page, but this time no JavaScript events were tracked, and a green check mark is shown" /></a>
</div>

As you can see, a regular browser, or [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) doesn’t run any JS code. [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) is a great way for app developers to show third party web content to the user, without them leaving your app, while still preserving the privacy and comfort for the user.

## Technical Details

<div style="text-align: center; margin-bottom: 15px;">
  <a href="https://krausefx.com/assets/posts/injecting-code/flow-chart.png" target="_blank">
    <img src="https://krausefx.com/assets/posts/injecting-code/flow-chart.png" id="inject-code-style" alt="A simple flowchart: starting with the use of the Instagram iOS app. For 3 paths (user taps a link in DMs, user taps a link in bio, user taps a link on an ad), the flow continues to 'Instagram renders external page inside app'. It then subscribes to text selections, and checks if an SDK named 'iab-pcm-sdk' is installed. If no, the Meta tracking pixel is installed. In all cases, the Instagram app queries for a list of iFrames." />
  </a>
</div>

- Instagram adds a new event listener, to get details about every time the user selects any text on the website. This, in combination with listening to screenshots, gives Instagram full insight over what specific piece of information was selected & shared
- The Instagram app checks if there is an element with the ID `iab-pcm-sdk`: According to [this tweet](https://twitter.com/abx1n/status/1557796015364718593), the `iab` likely refers to "In App Browser".
- If no element with the ID `iab-pcm-sdk` was found, Instagram creates a new `script` element, sets its source to [`https://connect.facebook.net/en_US/pcm.js`](https://connect.facebook.net/en_US/pcm.js)
- It then finds the first `script` element on your website to insert the pcm JavaScript file right before
- Instagram also queries for `iframes` on your website, however I couldn’t find any indication of what they’re doing with it

### How to protect yourself as a user?

<div style="float: right; margin-left: 20px;">
  <a href="https://krausefx.com/assets/posts/injecting-code/instagram_open_in_safari_framed.png" target="_blank"><img src="https://krausefx.com/assets/posts/injecting-code/instagram_open_in_safari_framed.png" style="max-height: 180px; margin-top: 20px;" alt="A screenshot of the Instagram iOS app when you click the 3 dots on the top right while viewing an external website, that allows people to open the page in their default browser" /></a>
</div>

#### Escape the in-app-webview

Most in-app browsers have a way to open the currently rendered website in Safari. As soon as you land on that screen, just use that option to escape it. If that button isn’t available, you will have to copy & paste the URL to open the link in the browser of your choice.

#### Use the web version

Most social networks, including Instagram and Facebook, offer a decent mobile-web version, offering a similar feature set. You can use `https://instagram.com` without issues in iOS Safari.

### How to protect yourself as a website provider?

Until Instagram resolves this issue (if ever), you can quite easily trick the Instagram and Facebook app to believe the tracking code is already installed. Just add the following to your HTML code:

```
<span id="iab-pcm-sdk"></span>
<span id="iab-autofill-sdk"></span>
```

Additionally, to prevent Instagram from tracking the user's text selections on your website:

```js
const originalEventListener = document.addEventListener
document.addEventListener = function(a, b) {
    if (b.toString().indexOf("messageHandlers.fb_getSelection") > -1) {
        return null;
    }
    return originalEventListener.apply(this, arguments);
}
```

This will not solve the actual problem of Instagram running JavaScript code against your website, but at least no additional JS scripts will be injected, as well as less data being tracked.

It’s also easy for an app to detect if the current browser is the Instagram/Facebook app by checking the user agent, however I couldn’t find a good way to pop out of the in-app browser automatically to open Safari instead. If you know a solution, I’d [love to know](https://twitter.com/KrauseFx). 

**Update on 2022-08-11:** As response to this article, [Adrian published a post about this exact topic](https://www.holovaty.com/writing/framebust-native-apps/).

## Proposals

### For Apple

Apple is doing a fantastic job building their platform with the user’s privacy in mind. One of the 4 privacy principles:

> **User Transparency and Control:** Making sure that users know what data is shared and how it is used, and that they can exercise control over it.

&ndash; [Apple Privacy PDF](https://www.apple.com/privacy/docs/A_Day_in_the_Life_of_Your_Data.pdf) <small>(April 2021)</small>

At the moment of writing, there is no AppStore Review Rule that prohibits companies from building their own in-app browser to track the user, read their inputs, and inject additional ads to third party websites. However Apple is clearly recommending that to use [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller):

> Avoid using a web view to build a web browser. Using a web view to let people briefly access a website without leaving the context of your app is fine, but Safari is the primary way people browse the web. **Attempting to replicate the functionality of Safari in your app is unnecessary and discouraged.**

&ndash; [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/components/content/web-views/) <small>(June 2022)</small>

> **If your app lets users view websites from anywhere on the Internet, use the [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) class**. If your app customizes, interacts with, or controls the display of web content, use the `WKWebView` class.

&ndash; [Apple SFSafariViewController docs](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) <small>(June 2022)</small>

**Introducing `App-Bound Domains`**

[App-Bound Domains](https://webkit.org/blog/10882/app-bound-domains/) is an excellent new `WebKit` feature making it possible for developers to offer a safer in-app browsing experience when using `WKWebView`. As an app developer, you can define which domains your app can access, and all web requests will be restricted to them. To disable the protection, a user would have to explicitly disable it in the iOS settings app.

App-Bound Domains went live with iOS 14 (~1.5 years ago), however it’s only an opt-in option for developers, meaning the vast majority of iOS apps don’t make use of this feature.

> If the developers of SocialApp **want a better user privacy experience** they have two paths forward:
> - Use `SafariViewController` instead of `WKWebView` for in-app browsing. `SafariViewController` protects user data from SocialApp by loading pages outside of SocialApp’s process space. SocialApp can guarantee it is giving its users the best available user privacy experience while using SafariViewController.
> - Opt-in to App-Bound Domains. The additional `WKWebView` restrictions from App-Bound Domains ensure that SocialApp is not able to track users using the APIs outlined above.

I highlighted the `"want a better user privacy experience"` part, as this is the missing piece: App-Bound Domains should be a requirement for all iOS apps, since the social media apps are the ones injecting the tracking code.

In July 2022 Apple introduced the [Lockdown Mode](https://www.apple.com/newsroom/2022/07/apple-expands-commitment-to-protect-users-from-mercenary-spyware/) to better protect people who are at high risk. Unfortunately the iOS Lockdown Mode doesn't change the way in-app web views work. I have filed a radar with Apple: [rdar://10735684](https://openradar.appspot.com/radar?id=5500665535135744), for which Apple has responded with "This isn't what Lockdown Mode is for"

<div style="text-align: center; margin-bottom: 20px;">
  <img src="https://krausefx.com/assets/posts/injecting-code/apple-response.png" style="max-width: 500px; border: 1px solid #ccc;" />
</div>

**A few immediate steps for Apple to take:**

Update the App Review Rules to require the use of [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) or [App-Bound Domains](https://webkit.org/blog/10882/app-bound-domains/) when displaying any third party websites.

- There should be only a few exception (e.g. browser apps), that require two extra steps:
  - Request an extra entitlement to ensure it’s a valid use-case
  - Have the user confirm the extra permission
- First-party websites/content can still be displayed using the `WKWebView` class, as they are often used for UI elements, or the app actually modifying their first party content (e.g. auto-dismissing of their own cookie banners)

I’ve also submitted a radar ([rdar://38109139](https://openradar.appspot.com/radar?id=4963695432040448)) to Apple as part of my [past blog post](https://krausefx.com/blog/follow-user).

### For Meta

Do what Meta is already doing with WhatsApp: Stop modifying third party websites, and use Safari or [`SFSafariViewController`](https://developer.apple.com/documentation/safariservices/sfsafariviewcontroller) for all third party websites. It's what's best for the user, and the right thing to do.

I've disclosed this issue with Meta through their [Bug Bounty Program](https://www.facebook.com/whitehat/profile/FelixKrause), where within a few hours they confirmed they were able to reproduce the "issue", however I haven't heard back anything else within the last 9 weeks, besides asking me to wait longer until they have a full report. Since there hasn't been any responses on my follow-up questions, nor did they stop injecting tracking code into external websites, I've decided to go public with this information (after giving them another 2 weeks heads-up)

### Update 2022-08-11 (information provided by Meta)

After the publication went live, Meta has sent two emails clarifying what is happening on their end. I addressed their comments, the following has changed:

- The script that gets injected isn't the [Meta Pixel](https://developers.facebook.com/docs/meta-pixel/), but it's the [pcm.js](https://connect.facebook.net/en_US/pcm.js) script, which, according to Meta, helps aggregate events, i.e. online purchase, before those events are used for targeted advertising and measurement for the Facebook platform
- According to Meta, the script injected ([pcm.js](https://connect.facebook.net/en_US/pcm.js)) helps Meta respect the user's ATT opt out choice, which is only relevant if the rendered website has the Meta Pixel installed. However as far as my understanding goes, all of this wouldn't be necessary if Instagram were to open the phone's default browser, instead of building & using the custom in-app browser.

I sent Meta a few follow-up questions - once I hear back, I'll update the post accordingly, and announce the changes on [Twitter](https://twitter.com/KrauseFx).

In the mean-time, everything published in this post is correct: the Instagram app is executing and injecting JavaScript code into third party websites, rendered inside their in-app browser, which exposes a big risk for the user. Also, there is no way to opt-out of the custom in-app browser.

As Meta was providing me with more context and details, I have updated the post to reflect this. You can find the full history of the post, and which parts got edited [over here](https://github.com/KrauseFx/krausefx.com/commits/master).

### Update 2022-08-14 (information provided by Meta)

The main question I asked: If Meta built a whole system to inject JavaScript code (`pcm.js`) into third party websites to [respect people's App Tracking Transparency (ATT) choices](https://twitter.com/andymstone/status/1557825254675841025), why wouldn't Instagram just open all external links in the user's default browser? This would put the user in full control over their privacy settings, and wouldn't require any engineering effort on Meta's end.

To that, the answer was:

> As shared earlier, pcm.js is required to respect a user’s ATT decision. The script needs to be injected to authenticate the source and the integrity (i.e. if pixel traffic is valid) of the data being received. Authentication would include checking that, when data is received from the In App Browser through the WebView-iOS native bridge, it contains a valid nonce coming from the injected script. SFSafariViewController doesn’t support this. There are additional components within the In App Browser that provide security and user features that SFSafariViewController also doesn’t support.

While that answer provides some context, I don't think it answers my question. Other apps, including Meta's own WhatsApp, can operate perfectly fine without using a custom in-app browser.

My ticket with Meta got marked as resolved `"given the items raised in your submission are intentional and not a privacy concern"`.

My second question was about the tracking of the user's text selection, and according to Meta, this is some old code that isn't used anymore:

> In older versions of iOS, this code was necessary to allow users to share selected text to their news feed. As newer versions of iOS have built-in functionality for text selection, this feature has been deprecated for some time and was already identified for removal as part of our standard code maintenance. 
> There is no code in our In App Browser that shares text selection information from websites without the user taking action to share it themselves via a feature (like quote share).

---

Check out my [other privacy and security related publications](/privacy).

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
    max-height: 540px;
  }
  #inject-code-style {
    max-width: 450px;
  }
  #instagram-framed-top { 
    float: right;
    margin-right: -60px;
    margin-left: 10px;
    margin-bottom: 20px;
  }
  @media screen and (max-width: 1000px) {
    #instagram-framed-top {
      display: none;
    }
    #inject-code-style {
      max-width: 100%;
    }
  }
</style>
