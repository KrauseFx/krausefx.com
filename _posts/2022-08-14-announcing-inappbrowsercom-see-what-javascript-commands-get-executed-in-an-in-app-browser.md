---
layout: post
title: 'iOS Privacy: Announcing InAppBrowser.com - see what JavaScript commands get executed in an in-app browser'
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

I was so surprised to see the article featured by major media outlets across the globe, like [TheGuardian](https://www.theguardian.com/technology/2022/aug/11/meta-injecting-code-into-websites-visited-by-its-users-to-track-them-research-says) and [The Register](https://www.theregister.com/2022/08/12/meta_ios_privacy/), generated a [over a million impressions on Twitter](https://twitter.com/KrauseFx/status/1557412468368052225), and was ranked [#1 on HackerNews](https://news.ycombinator.com/item?id=32415470) for more than 12 hours. After reading through the replies and DMs, I saw a common question across the community:

<!-- The code below is duplicated, once for mobile, once for desktop -->
<div class="tiktokcontainer" id="desktop">
  <a href="/assets/inappbrowser/app_screenshots/tiktok_framed.png" target="_blank">
    <img 
      src="/assets/inappbrowser/app_screenshots/tiktok_framed.png"
      alt="An iPhone showing the inappbrowser.com website, rendered inside TikTok, showing how there is CSS code being added, added monitoring for all taps and all keyboard inputs, as well as getting the coordinates of elements the user taps"
    />
  </a>
  <h4>TikTok's In-App Browser injecting code to observe all taps and keyboard inputs</h4>
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
  <a href="/assets/inappbrowser/app_screenshots/tiktok_framed.png" target="_blank">
    <img 
      src="/assets/inappbrowser/app_screenshots/tiktok_framed.png"
      alt="An iPhone showing the inappbrowser.com website, rendered inside TikTok, showing how there is CSS code being added, added monitoring for all taps and all keyboard inputs, as well as getting the coordinates of elements the user taps"
    />
  </a>
  <h4>TikTok's In-App Browser injecting code to observe all taps and keyboard inputs</h4>
</div>

I started using this tool to analyze the most popular iOS apps that have their own in-app browser. Below are the results I’ve found.

For this analysis I have excluded all third party iOS browsers (Chrome, Brave, etc.), as they often use JavaScript to offer some of their functionality, like a password manager.

**Important Note:** This tool can't detect all JavaScript commands executed, as well as doesn't show any tracking the app might do using native code (like custom gesture recognisers). More details on this below.

**Fully Open Source**

[InAppBrowser.com](https://InAppBrowser.com) is designed for everybody to verify for themselves on what apps are doing inside their in-app browsers. I have decided to open source the code used for this analysis, you can check it out on [GitHub](https://github.com/KrauseFx/inAppBrowser.com). This allows the community to update and improve this script over time.

## iOS Apps that have their own In-App Browser

- **Option to open in default browser**: Does the app provide a button to open the currently shown link in the default browser?
- **Modify page**: Does the app inject JavaScript code into third party websites to modify its content? This includes adding tracking code (like inputs, text selections, taps, etc.), injecting external JavaScript files, as well as creating new HTML elements.
- **Fetch metadata**: Does the app run JavaScript code to fetch website metadata? This is a harmless thing to do, and doesn't cause any real security or privacy risks.

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
          <a target="_blank" href="/assets/inappbrowser/app_screenshots/{{ app.screenshot }}.png">
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
          <a target="_blank" href="/assets/inappbrowser/app_screenshots/{{ app.screenshot }}.png">
            {% if app.runs_js == true %}
              <span class="injecting">Yes</span>
            {% else %}
              <span class="not-injecting">None</span>
            {% endif %}
          </a>
        </td>
        <td><a target="_blank" href="/assets/inappbrowser/app_js/{{ app.screenshot }}.js">.js</a></td>
        <td class="last-updated">{{ app.last_updated }}</td>
      </tr>
    {% endfor %}
  </table>
</div>

Click on the `Yes` or `None` on the above table to see a screenshot of the app.

**Important**: Just because an app injects JavaScript into external websites, doesn't mean the app is doing anything malicious. There is no way for us to know the full details on what kind of data each in-app browser collects, or how or if the data is being transferred or used. This publication is stating the JavaScript commands that get executed by each app, as well as describing what effect each of those commands might have. For more background on the risks of in-app browsers, check out [last week's publication](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser).

There are many valid reasons to use an in-app browser, particularly when an app accesses its own websites to complete specific transactions. For example, an airline app might not have the seat selection implemented natively for their whole airplane fleet. Instead they might choose to reuse the web-interface they already have. If they weren’t able to inject cookies or JavaScript commands inside their webview, the user would have to re-login while using the app, just so they can select their seat. Shoutout to Venmo, which uses their own in-app browser for all their internal websites (e.g. Terms of Service), but as soon as you tap on an external link, they automatically transition over to `SFSafariViewController`.

However, there are data privacy & integrity issues when you use in-app browsers to visit non-first party websites, such as how Instagram and TikTok show all external websites inside their app. More importantly, those apps rarely offer an option to use a standard browser as default, instead of the in-app browser. And in some cases (like TikTok), there is not even a button to open the currently shown page in the default browser.

### Apps can hide their JavaScript activities from this tool

Since iOS 14.3 (December 2020), Apple introduced the support of running JavaScript code in the [context of a specified frame and content world](https://developer.apple.com/documentation/webkit/wkcontentworld). JavaScript commands executed using this approach can still fully access the third party website, but can't be detected by the website itself (in this case a tool like InAppBrowser.com).

> Use a WKContentWorld object as a namespace to separate your app’s web environment from the environment of individual webpages or scripts you execute. Content worlds help prevent issues that occur when two scripts modify environment variables in conflicting ways. [...]
> Changes you make to the DOM are visible to all script code, regardless of content world.

&ndash; [Apple WKContentWorld Docs](https://developer.apple.com/documentation/webkit/wkcontentworld)

This new system was initially built so that website operators can't interfere with JavaScript code of browser plugins. As a user, you can check the source code of any browser plugin, as you are in control over the browser itself. However with in-app browsers we don't have a reliable way to verify all the code that is executed.

So if Meta or TikTok want to hide the JavaScript commands they execute on third party websites, all they'd need to do is to update their JavaScript runner:

```swift
// Currently used code by Meta & TikTok
self.evaluateJavaScript(javascript)

// Updated to use the new system
self.evaluateJavaScript(javascript, in: nil, in: .defaultClient, completionHandler: { _ in })
```

For example, Firefox for iOS already [uses the new WKContentWorld system](https://github.com/mozilla-mobile/firefox-ios/blob/d613cb24d5dc717466f098e13625a3e0c5e4703e/Shared/Extensions/WKWebViewExtensions.swift#L19-L29). Due to the open source nature of Firefox and Google Chrome for iOS it's easy for us as a community verify nothing suspicious is happening.

Especialy after the publicity of [last week's post](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser), as well as this one, tech companies who are still using custom in-app browsers will very quickly update to use the new JavaScript isolated world system, so their code becomes undetectable to us.

Hence, **it becomes more important than ever to find a solution to end the use of custom in-app browsers** for showing third party content. As you can see on the list below, all apps that use `SFSafariViewController` or `Default Browser` are on the green side, and there is no way for apps to inject their tracking code onto websites. However, the apps listed in the first table **do** use a custom in-app browser, and even if they only have green checkmarks, they might just use the `Isolated World JavaScript`, therefore I wasn't able to prove any JavaScript injections.


## iOS Apps that use Safari

The apps below follow Apple's recommendation of using Safari or `SFSafariViewController` for viewing external websites. More context on `SFSafariViewController` in the [original article](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser).

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

All the apps listed above have no way to inject any JavaScript commands onto external websites. Even the `Isolated World JavaScript` method described above won't work, as the `SFSafariViewController` and Safari itself run in a completely separate sandbox and process, with no direct access with the app itself.

## What can we do?

**As a user of an app**

<div id="youtube-button">
  <img 
    src="/assets/app_screenshots/video-preview.png" 
    onclick="window.open('https\:\/\/www.youtube.com/watch?v=i2SfbHpZDQI')"
    alt="A link to the YouTube video showing the website in action inside the Instagram app" />
  <p><b>Demo video of how to leave the Instagram In-App Browser</b></p>
</div>

Most in-app browsers have a way to open the currently rendered website in Safari. As soon as you land inside an in-app browser, use the `Open in Browser` feature to escape it. If that button isn’t available, you will have to copy & paste the URL to open the link in the browser of your choice. If the app makes it difficult to even do that, you can tap & hold a link on the website and then use the Copy feature, which can be a little tricky to get right.

TikTok doesn't offer a way to open the currently shown website in your default browser.

**Companies using in-app browsers**

If you’re at a company where you have an in-app browser, use it only for your own pages and open all external links in the user's default browser. Additionally, provide a setting to let users choose a default browser over an in-app browser experience. Maybe the [previous](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser) and this publication will help convince your managers to remove the in-app browser from your app.

**Major tech companies**

It’s important to call out how much movement there’s been in the privacy of data space, but it’s unclear how many of these changes have been motion vs. true progress for the industry and the user. 

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

</style>
