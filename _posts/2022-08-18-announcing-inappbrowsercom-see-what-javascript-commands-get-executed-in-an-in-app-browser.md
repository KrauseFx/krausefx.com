---
layout: post
title: 'iOS Privacy: Announcing InAppBrowser.com - see what JavaScript commands get injected through an in-app browser'
categories: []
tags:
- ios
- privacy
- hijacking
- sniffing
- apps
- browser
status: publish
type: post
published: true
meta: {}
---

[Last week I published a report](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser) on the risks of mobile apps using in-app browsers. Some apps, like Instagram and Facebook, inject JavaScript code into third party websites that cause potential security and privacy risks to the user. 

I was so happy to see the article featured by major media outlets across the globe, like [TheGuardian](https://www.theguardian.com/technology/2022/aug/11/meta-injecting-code-into-websites-visited-by-its-users-to-track-them-research-says) and [The Register](https://www.theregister.com/2022/08/12/meta_ios_privacy/), generated a [over a million impressions on Twitter](https://twitter.com/KrauseFx/status/1557412468368052225), and was ranked [#1 on HackerNews](https://news.ycombinator.com/item?id=32415470) for more than 12 hours. After reading through the replies and DMs, I saw a common question across the community:

<!-- The code below is duplicated, once for mobile, once for desktop -->
<div class="tiktokcontainer" id="desktop">
  <a href="/assets/posts/inappbrowser/app_screenshots/tiktok_top.png" target="_blank">
    <img 
      src="/assets/posts/inappbrowser/app_screenshots/tiktok_top.png"
      alt="An iPhone showing the inappbrowser.com website, rendered inside TikTok, showing how there is CSS code being added, added monitoring for all taps and all keyboard inputs, as well as getting the coordinates of elements the user taps"
    />
  </a>
  <h4>TikTok's In-App Browser injecting code to observe all taps and keyboard inputs, which can include passwords and credit cards</h4>
</div>

**"How can I verify what apps do in their webviews?"**

Introducing [InAppBrowser.com](https://InAppBrowser.com), a simple tool to list the JavaScript commands executed by the iOS app rendering the page.

To try this this tool yourself:

1. Open an app you want to analyze
1. Share the url [https://InAppBrowser.com](https://InAppBrowser.com) somewhere inside the app (e.g. send a DM to a friend, or post to your feed)
1. Tap on the link inside the app to open it
1. Read the report on the screen

<!-- The code below is duplicated, once for mobile, once for desktop -->
<div class="tiktokcontainer no-print" id="mobile">
  <a href="/assets/posts/inappbrowser/app_screenshots/tiktok_top.png" target="_blank">
    <img 
      src="/assets/posts/inappbrowser/app_screenshots/tiktok_top.png"
      alt="An iPhone showing the inappbrowser.com website, rendered inside TikTok, showing how there is CSS code being added, added monitoring for all taps and all keyboard inputs, as well as getting the coordinates of elements the user taps"
    />
  </a>
  <h4>TikTok's In-App Browser injecting code to observe all taps and keyboard inputs, which can include passwords and credit cards</h4>
</div>

I started using this tool to analyze the most popular iOS apps that have their own in-app browser. Below are the results I’ve found.

For this analysis I have excluded all third party iOS browsers (Chrome, Brave, etc.), as they use JavaScript to offer some of their functionality, like a password manager. Apple requires all third party iOS browsers apps to use the Safari rendering engine `WebKit`.

***Important Note:*** This tool can't detect all JavaScript commands executed, as well as doesn't show any tracking the app might do using native code (like custom gesture recognisers). More details on this below.

**Fully Open Source**

[InAppBrowser.com](https://InAppBrowser.com) is designed for everybody to verify for themselves what apps are doing inside their in-app browsers. I have decided to open source the code used for this analysis, you can check it out on [GitHub](https://github.com/KrauseFx/inAppBrowser.com). This allows the community to update and improve this script over time.

## iOS Apps that have their own In-App Browser

- **Option to open in default browser**: Does the app provide a button to open the currently shown link in the default browser?
- **Modify page**: Does the app inject JavaScript code into third party websites to modify its content? This includes adding tracking code (like inputs, text selections, taps, etc.), injecting external JavaScript files, as well as creating new HTML elements.
- **Fetch metadata**: Does the app run JavaScript code to fetch website metadata? This is a harmless thing to do, and doesn't cause any real security or privacy risks.
- **JS**: A link to the JavaScript code that I was able to detect. Disclaimer: There might be other code executed. The code might not be a 100% accurate representation of all JS commands.

<div id="table-scroll-container">
  <table class="in-app-browser-overview">
    <tr style="height: 60px; line-height: 23px;">
      <th>App</th>
      <th title="Does the app provide a button to open the currently shown link in the default browser?">Option to open in default browser</th>
      <th title="Does the app inject JavaScript code into third party websites to modify its content? This includes adding tracking code (like inputs, text selections, taps, etc.), injecting external JavaScript files, as well as creating new HTML elements.">Modify page</th>
      <th title="Does the app run JavaScript code to fetch website metadata? This is a harmless thing to do, and doesn't cause any real security or privacy risks.">Fetch metadata</th>
      <th>JS</th>
      <th>Updated</th>
    </tr>
    {% for app in site.data.in_app_browsers %}
      <tr>
        <td class="app-name">{{ app.name }}</td>
        {% if app.has_open_in_browser == true %}
          <td class="browser-green">✅</td>
        {% else %}
          <td class="browser-red">⛔️</td>
        {% endif %}

        {% if app.js_modify_content == false %}
          <td class="browser-green">
        {% else %}
          <td class="browser-red">
        {% endif %}
          <a target="_blank" href="/assets/posts/inappbrowser/app_screenshots/{{ app.screenshot }}.png">
            {% if app.js_modify_content == true %}
              <span class="injecting">Yes</span>
            {% else %}
              <span class="not-injecting">None</span>
            {% endif %}
          </a>
        </td>

        {% if app.runs_js == false %}
          <td class="browser-green">
        {% else %}
          <td class="browser-red">
        {% endif %}
          <a target="_blank" href="/assets/posts/inappbrowser/app_screenshots/{{ app.screenshot }}.png">
            {% if app.runs_js == true %}
              <span class="injecting">Yes</span>
            {% else %}
              <span class="not-injecting">None</span>
            {% endif %}
          </a>
        </td>
        <td>
          {% if app.runs_js == true %}
            <a target="_blank" href="/assets/posts/inappbrowser/app_js/{{ app.screenshot }}.js">.js</a>
          {% endif %}
        </td>
        <td class="last-updated">{{ app.last_updated }}</td>
      </tr>
    {% endfor %}
  </table>
</div>

Click on the `Yes` or `None` on the above table to see a screenshot of the app.

**Important**: Just because an app injects JavaScript into external websites, doesn't mean the app is doing anything malicious. There is no way for us to know the full details on what kind of data each in-app browser collects, or how or if the data is being transferred or used. This publication is stating the JavaScript commands that get executed by each app, as well as describing what effect each of those commands might have. For more background on the risks of in-app browsers, check out [last week's publication](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser).

Even if some of the apps above have green checkmarks, they might use the new `WKContentWorld` isolated JavaScript, which I'll describe below.

## TikTok monitoring all keyboard inputs and taps

<a href="/assets/posts/inappbrowser/app_screenshots/tiktok.png" target="_blank">
  <img class="details-for-specific-app" src="/assets/posts/inappbrowser/app_screenshots/tiktok_cut.png" >
</a>

When you open any link on the TikTok iOS app, it's opened inside their in-app browser. While you are interacting with the website, **TikTok subscribes to all keyboard inputs** (including passwords, credit card information, etc.) and every tap on the screen, like which buttons and links you click.

- TikTok iOS subscribes to every keystroke (text inputs) happening on third party websites rendered inside the TikTok app. This can include passwords, credit card information and other sensitive user data. (`keypress` and `keydown`). We can't know what TikTok uses the subscription for, but from a technical perspective, **this is the equivalent of installing a keylogger** on third party websites.
- TikTok iOS subscribes to every tap on any button, link, image or other component on websites rendered inside the TikTok app.
- TikTok iOS uses a JavaScript function to get details about the element the user clicked on, like an image (`document.elementFromPoint`)

<a href="/assets/posts/inappbrowser/app_js/tiktok.js" target="_blank">Here</a> is a list of all JavaScript commands I was able to detect.

## Instagram does more than just inserting `pcm.js`

<a href="/assets/posts/inappbrowser/app_screenshots/instagram.png" target="_blank">
  <img class="details-for-specific-app" src="/assets/posts/inappbrowser/app_screenshots/instagram_cut.png" >
</a>

[Last week's post](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser) talked about how Meta injects the [`pcm.js`](https://connect.facebook.net/en_US/pcm.js) script onto third party websites. [Meta claimed](https://twitter.com/KrauseFx/status/1558867249691123712) they only inject the script to respect the user's ATT choice, and additional "security and user features".

> The code in question allows us to respect people's privacy choices by helping aggregate events (such as making a purchase online) from pixels already on websites, before those events are used for advertising or measurement purposes.

&ndash; [via this tweet](https://twitter.com/andymstone/status/1557825414176940035)

After improving the JavaScript detection, **I now found some additional commands Instagram executes:**

- Instagram iOS subscribes to every tap on any button, link, image or other component on external websites rendered inside the Instagram app.
- Instagram iOS subscribes to every time the user selects a UI element (like a text field) on third party websites rendered inside the Instagram app.

<a href="/assets/posts/inappbrowser/app_js/instagram.js" target="_blank">Here</a> is a list of all JavaScript commands I was able to detect.

**Note on subscribing**: When I talk about "*App subscribes to*", I mean that the app subscribes to the JavaScript events of that type (e.g. all taps). There is no way to verify what happens with the data.

## Apps can hide their JavaScript activities from this tool

Since iOS 14.3 (December 2020), Apple introduced the support of running JavaScript code in the [context of a specified frame and content world](https://developer.apple.com/documentation/webkit/wkcontentworld). JavaScript commands executed using this approach can still fully access the third party website, but can't be detected by the website itself (in this case a tool like InAppBrowser.com).

> Use a WKContentWorld object as a namespace to separate your app’s web environment from the environment of individual webpages or scripts you execute. Content worlds help prevent issues that occur when two scripts modify environment variables in conflicting ways. [...]
> Changes you make to the DOM are visible to all script code, regardless of content world.

&ndash; [Apple WKContentWorld Docs](https://developer.apple.com/documentation/webkit/wkcontentworld)

This new system was initially built so that website operators can't interfere with JavaScript code of browser plugins, and to make fingerprinting more difficult. As a user, you can check the source code of any browser plugin, as you are in control over the browser itself. However with in-app browsers we don't have a reliable way to verify all the code that is executed.

So when Meta or TikTok want to hide the JavaScript commands they execute on third party websites, all they'd need to do is to update their JavaScript runner:

```swift
// Currently used code by Meta & TikTok
self.evaluateJavaScript(javascript)

// Updated to use the new system
self.evaluateJavaScript(javascript, in: nil, in: .defaultClient, completionHandler: { _ in })
```

For example, Firefox for iOS already [uses the new WKContentWorld system](https://github.com/mozilla-mobile/firefox-ios/blob/d613cb24d5dc717466f098e13625a3e0c5e4703e/Shared/Extensions/WKWebViewExtensions.swift#L19-L29). Due to the open source nature of Firefox and Google Chrome for iOS it's easy for us as a community to verify nothing suspicious is happening.

Especially after the publicity of [last week's post](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser), as well as this one, tech companies that still use custom in-app browsers will very quickly update to use the new `WKContentWorld` isolated JavaScript system, so their code becomes undetectable to us.

Hence, **it becomes more important than ever to find a solution to end the use of custom in-app browsers** for showing third party content.

### Valid use-cases for in-app webviews

There are many valid reasons to use an in-app browser, particularly when an app accesses its own websites to complete specific transactions. For example, an airline app might not have the seat selection implemented natively for their whole airplane fleet. Instead they might choose to reuse the web-interface they already have. If they weren’t able to inject cookies or JavaScript commands inside their webview, the user would have to re-login while using the app, just so they can select their seat. Shoutout to Venmo, which uses their own in-app browser for all their internal websites (e.g. Terms of Service), but as soon as you tap on an external link, they automatically transition over to `SFSafariViewController`.

However, there are data privacy & integrity issues when you use in-app browsers to visit non-first party websites, such as how Instagram and TikTok show all external websites inside their app. More importantly, those apps rarely offer an option to use a standard browser as default, instead of the in-app browser. And in some cases (like TikTok), there is no button to open the currently shown page in the default browser.

## iOS Apps that use Safari

The apps below follow Apple's recommendation of using Safari or `SFSafariViewController` for viewing external websites. More context on `SFSafariViewController` in the [original article](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser).

All apps that use `SFSafariViewController` or `Default Browser` are on the safe side, and there is no way for apps to inject any code onto websites, even with the new `WKContentWorld` system.

<div id="table-scroll-container">
  <table class="in-app-browser-overview safari-users">
    <tr>
      <th>App</th>
      <th>Technology</th>
      <th>Updated</th>
    </tr>
    {% for app in site.data.using_safari %}
      <tr>
        <td class="app-name-safari">{{ app.name }}</td>
        <td class="technology">{{ app.technology }}</td>
        <td class="last-updated">{{ app.last_updated }}</td>
      </tr>
    {% endfor %}
  </table>
</div>

## What can we do?

**As a user of an app**

<div id="youtube-button">
  <img 
    src="/assets/posts/inappbrowser/app_screenshots/video-preview.png" 
    onclick="window.open('https\:\/\/www.youtube.com/watch?v=i2SfbHpZDQI')"
    alt="A link to the YouTube video showing the website in action inside the Instagram app" />
  <p><b>Demo video of how to escape the Instagram In-App Browser</b></p>
</div>

Most in-app browsers have a way to open the currently shown website in Safari. As soon as you land inside an in-app browser, use the `Open in Browser` feature to switch to a safer browser. If that button isn’t available, you will have to copy & paste the URL to open the link in the browser of your choice. If the app makes it difficult to even do that, you can tap & hold a link on the website and then use the Copy feature, which can be a little tricky to get right.

TikTok doesn't have a button to open websites in the default browser.

**Companies using in-app browsers**

If you’re at a company where you have an in-app browser, use it only for your own pages and open all external links in the user's default browser. Additionally, provide a setting to let users choose a default browser over an in-app browser experience. Unfortunately, these types of changes rarely get prioritized over features that move metrics inside of tech organizations. However, it's so important for people to educate others on their team, and their managers, about the positive impact of making better security and privacy decisions for the user. These changes can be transparently marketed to users as an opportunity to build further trust.

**Major tech companies**

It’s important to call out how much movement there’s been in the privacy of data space, but it’s unclear how many of these changes have been motion vs. true progress for the industry and the user. 

> "Many tech companies take heat for 'abusing their users' privacy', when in fact they try to balance out business priorities, great user experiences, and ensuring they are respecting privacy and user data. It's clear why companies were motivated to provide an in-app experience for external websites in the first place.
> 
> With the latest technology, companies can start to provide a smooth experience for the user, while respecting their privacy. It's possible for iOS or Android developers to move the privacy standards and responsibility to Apple & Google (e.g. stricter app reviews, more permission screens, etc.), however this is a much larger conversation where companies need to work together to define what standards should exist. We can't have one or two companies set the direction for the entire industry, since a solution needs to work for the large majority of companies. Otherwise, we're left in a world where companies are forced to get creative on finding ways to track additional user data from any source possible, or define their own standards of what's best for user privacy, ultimately hurting the consumer and the product experience."

&ndash; [Hemal Shah](https://twitter.com/hemal)

Technology-wise [App-Bound Domains](https://webkit.org/blog/10882/app-bound-domains/) seems to be an excellent new WebKit feature making it possible for developers to offer a safer in-app browsing experience when using `WKWebView`. As an app developer, you can define which domains your app can access (your own), and you won't be able to control third party pages any more. To disable the protection, a user would have to explicitly disable it in the iOS settings app. However, at the time of writing, this system is not yet enabled by default.

### FAQs for non-tech readers

- **Can in-app browsers read everything I do online?** No! They are only able to read and watch your online activities when you open a link or ad from within their apps.
- **Do the apps above actually steal my passwords, address and credit card numbers?** No! I wanted to showcase that bad actors could get access to this data with this approach. As shown in the past, if it’s possible for a company to get access to data legally and for free, without asking the user for permission, [they will track it](https://twitter.com/steipete/status/1025024813889478656).
- **How can I protect myself?** Whenever you open a link from any app, see if the app offers a way to open the currently shown website in your default browser. During this analysis, every app besides TikTok offered a way to do this.
- **Are companies doing this on purpose?** Building your own in-app browser takes a non-trivial time to program and maintain, significantly more than just using the privacy and user-friendly alternative that’s already been built into the iPhone for the past 7 years. Most likely there is some motivation there for the company to track your activities on those websites.
- **I opened InAppBrowser.com inside an app, and it doesn't show any commands. Am I safe?** No! First of all, the website only checks for one of many hundreds of attack vectors: JavaScript injection from the app itself. And even here, as of December 2020, app developers can completely hide the commands they execute, therefore offering no way for us to verify what is actually happening under the hood.


<style type="text/css">
  .in-app-browser-overview td, tr { 
    text-align: center;
    line-height: 10px
  }
  .safari-users tr {
  }
  .last-updated {
    font-size: 70%;
    color: #999;
  }
  .injecting {
    /* This is a bad thing */
    color: #f00;
    font-weight: bold;
    
    /* Underline also in red */
    text-decoration: underline;
  }
  .not-injecting {
    color: #00a000;
    font-weight: bold;
  }
  .technology {
    color: #00a000;
    min-width: 180px;
  }
  .in-app-browser-overview .app-name {
    text-align: left;
    min-width: 110px;
  }
  .in-app-browser-overview .app-name-safari {
    text-align: left;
    min-width: 140px;
  }
  .browser-green {
    background-color: rgba(0, 255, 0, 0.2);
  }
  .browser-red {
    background-color: rgba(255, 0, 0, 0.2);
  }
  .tiktokcontainer {
    text-align: center;
  }
  .tiktokcontainer a {
    margin-bottom: -15px;  
    margin-top: -10px;
  }
  @media screen and (min-width: 1001px) {
    #mobile.tiktokcontainer {
      display: none;
    }
    .tiktokcontainer {
      width: 310px;
      float: right;
      margin-left: 30px;
      margin-right: -40px;
    }
    .tiktokcontainer h4 {
      font-size: 0.9em;
      margin-top: 10px;
    }
  }
  @media screen and (max-width: 1000px) {
    #desktop.tiktokcontainer {
      display: none;
    }
    .tiktokcontainer {
      width: 100%;
      margin-right: 10px;
      margin-left: 0px;
      margin-top: 30px;
    }
    .tiktokcontainer img {
      max-width: 310px;
    }
    .tiktokcontainer h4 {
      font-size: 1em;
      margin-bottom: 40px;
    }
  }
  @media screen and (max-width: 800px) {
    .in-app-browser-overview {
      width: 100%;
    }
    #youtube-button {
      width: 100% !important;
      float: none !important;
      margin-left: 0px !important;
    }
    #youtube-button img {
      margin-left: 0px !important;
      width: calc(100% - 60px) !important;
    }
  }
  @media screen and (max-width: 600px) {
    /* Really only used for mobile */
    #table-scroll-container {
      width: calc(100% + 40px);
      margin-left: -20px;
      margin-right: -40px;
      overflow-x: scroll;
    }
  }
  #youtube-button {
    width: 250px; 
    float: right; 
    margin: 20px; 
    margin-left: 30px; 
    margin-bottom: 0px; 
    margin-top: 0px; 
    text-align: center;
  }
  #youtube-button img {
    margin-bottom: 5px;
    border: 2px solid #333; 
    cursor: pointer;
    max-width: 220px;
  }
  @media print
  {    
      .no-print, .no-print *
      {
          display: none !important;
      }
  }
  .hijacking-second-table {
    width: calc(100% + 300px);
  }
  .hijacking-second-table th {
    text-align: center;
  }
  .hijacking-second-table td {
    text-align: left;
    padding: 10px;
    vertical-align: top;
  }
  .hijacking-second-table img {
    width: 90%;
    max-width: 330px;
  }
  .hijacking-second-table p {
    margin-bottom: 0px;
    margin-top: 5px;
  }
  .hijacking-second-table ul {
    margin-top: 10px;
  }
  .hijacking-second-table .img-row td {
    text-align: center;
  }
  @media screen and (max-width: 800px) {
    #hijacking-table-desktop {
      display: none;
    }
    .hijacking-second-table {
      width: 100% !important;
    }
  }
  @media screen and (min-width: 801px) {
    .hijacking-table-mobile {
      display: none;
    }
  }
  .details-for-specific-app {
    float: right; 
    width: 300px;
    margin-right: -110px;
    margin-left: 25px;
  }
  @media screen and (max-width: 930px) {
    .details-for-specific-app {
      float: none !important;
      width: 100% !important;
      max-width: 300px !important;
      margin-left: 0px !important;
      margin-right: 0px !important;
    }
  }
</style>
