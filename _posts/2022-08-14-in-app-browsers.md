---
layout: post
title: 'iOS Privacy: In App Browsers'
categories: []
tags:
- ios
- privacy
- hijacking
- sniffing
status: publish
type: post
published: true
meta: {}
---

[Last week I’ve published a report](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser) on the risks of mobile apps using in-app browsers. Some apps, like Instagram and Facebook, inject JavaScript code into third party websites that cause potential security and privacy risks to the user. 

I was so surprised to see the article featured by major media outlets across the globe, like [TheGuardian](https://www.theguardian.com/technology/2022/aug/11/meta-injecting-code-into-websites-visited-by-its-users-to-track-them-research-says) and [The Register](https://www.theregister.com/2022/08/12/meta_ios_privacy/), generated a [over a million impressions on Twitter](https://twitter.com/KrauseFx/status/1557412468368052225), and was ranked [#1 on HackerNews](https://news.ycombinator.com/item?id=32415470) for more than 12 hours. After reading through the replies and DMs, I saw a common question across the community:

**"What tools can I use to verify what apps are doing inside their webviews?"**

Introducing [InAppBrowser.com](https://InAppBrowser.com), a simple tool to list the JavaScript commands executed by the iOS app rendering the page.

To try this this tool yourself:

1. Open an app you want to analyze
1. Share the url [https://inappbrowser.com](https://inappbrowser.com) somewhere inside the app (e.g. - send a DM to a friend, or post to your feed)
1. Tap on the link inside the app to open it
1. Read the report on the screen

<!-- TODO: insert video here -->

I started to use this tool to analyze the most popular iOS apps that have their own in-app browser. Below are the results I’ve found. For this analysis I have excluded all third party iOS browsers (Chrome, Brave, Firefox, etc.), as they often use JavaScript to offer some of their functionality, like a password manager, or more advanced media management.

## iOS Apps that have their own In-App Browser

- **Option to open in default browser**: Does the app provide a button to open the currently shown link in the default browser?
- **Modify page**: Does the app inject JavaScript code into third party websites to modify its content? This includes adding tracking code (like inputs, text selections, taps, etc.), injecting external JavaScript files, as well as creating new HTML elements.
- **Fetch metadata**: Does the app run JavaScript code to fetch website metadata? This is a harmless thing to do, and doesn't cause any real security or privacy risks.

<table class="in-app-browser-overview">
  <tr style="height: 60px; line-height: 23px;">
    <th style="width: 110px">App</th>
    <th title="Does the app provide a button to open the currently shown link in the default browser?">Option to open in default browser</th>
    <th title="Does the app inject JavaScript code into third party websites to modify its content? This includes adding tracking code (like inputs, text selections, taps, etc.), injecting external JavaScript files, as well as creating new HTML elements.">Modify page</th>
    <th title="Does the app run JavaScript code to fetch website metadata? This is a harmless thing to do, and doesn't cause any real security or privacy risks.">Fetch metadata</th>
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
        <a target="_blank" href="/assets/app_screenshots/{{ app.screenshot }}.png">
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
        <a target="_blank" href="/assets/app_screenshots/{{ app.screenshot }}.png">
          {% if app.runs_js == true %}
            <span class="injecting">Yes</span>
          {% else %}
            <span class="not-injecting">None</span>
          {% endif %}
        </a>
      </td>
      <td class="last-updated">{{ app.last_updated }}</td>
    </tr>
  {% endfor %}
</table>

Click on the `Yes` or `None` on the above table to see a screenshot of the app. If any of the above apps were updated to address those concerns, please reach out to me ([privacy@krausefx.com](mailto:privacy@krausefx.com)), so I can update the table.

## iOS Apps that use Safari

The apps below follow Apple's recommendation of using Safari or SFSafariViewController for viewing external websites. More context on this in the [original article](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser).

<table class="in-app-browser-overview safari-users">
  <tr>
    <th>App</th>
    <th>Technology</th>
    <th>Updated</th>
  </tr>
  {% for app in site.data.using_safari %}
    <tr>
      <td class="app-name">{{ app.name }}</td>
      <td class="technology">{{ app.technology }}</td>
      <td class="last-updated">{{ app.last_updated }}</td>
    </tr>
  {% endfor %}
</table>

---

As a reminder, just because an app is running JavaScript to collect metadata inside of an in-app browsing session does not mean it’s malicious or dangerous. There are many reasons to use an in-app browser, particularly when an app is accessing its own websites to complete specific transactions. For example, an airline app might not have the seat selection implemented natively for their whole fleet. Instead they might choose to reuse the web-interface they already have. If they weren’t able to inject cookies or JavaScript commands inside their webview, the user would have to re-login while using the app, just to select their seats.

However, there are data privacy & integrity issues when you use in-app browsers to visit non-first party websites, such as using Instagram to click on links that take you to third party websites. More importantly, those apps rarely offer an option to use a default browser, instead of the in-app browser. And in some cases (like TikTok), there is not even a button to open the currently shown page in the default browser.

## What's next?

**Companies using in-app browsers:**

If you’re at a company where you have an in-app browser, only use it for your own website and open all external links in the default browser. Additionally, provide a setting to let users choose a default browser over an in-app browser experience.

**Every day users**

Users should be more careful when using in-app browsers, and instead choose to open links on their default browser. Secondarily, consumers should be more active in the conversation around privacy and data usage. More consumer feedback needs to be heard on how users think about their privacy, data, and product experiences. There’s a tradeoff between being the most private and data responsible, and creating magical software experiences we love, so understanding where that line is can help companies align to user values much faster.

**Major tech companies**

It’s important to call out how much movement there’s been in the privacy of data space, but it’s unclear how many of these changes have been motion vs. true progress for the industry and the customer. It’s clear that one size doesn’t fit all, and one company can’t set the standard for every business out there. There needs to be a much larger conversation where companies work together to define what standards should exist, and how it equally impacts everyone who operates within them. We can’t have a hierarchy when it comes to user privacy or user data, because ultimately it leads to worse user and product experiences.

Technology-wise [App-Bound Domains](https://webkit.org/blog/10882/app-bound-domains/) seems to be an excellent new WebKit feature making it possible for developers to offer a safer in-app browsing experience when using WKWebView. As an app developer, you can define which domains your app can access, and all web requests will be restricted to them. To disable the protection, a user would have to explicitly disable it in the iOS settings app. However, at the time of writing, this system is not enabled by default.

### Non-Technical FAQ
- **Can in-app browsers read everything I do online?** No! They are only able to read and watch your online activities when you open a link or ad from within their apps.
- **Do the apps above actually steal my passwords, address and credit card numbers?** No! I wanted to showcase that bad actors could get access to this data with this approach. As shown in the past, if it’s possible for a company to get access to data legally and for free, without asking the user for permission, [they will track it](https://twitter.com/steipete/status/1025024813889478656).
- **How can I protect myself?** Whenever you open a link from any app, see if the app offers a way to open the currently shown website in your default browser. During this analysis, every app besides TikTok offered a way to do this.
- **Why are companies doing this on purpose?** Building your own in-app browser takes a non-trivial time to program and maintain, significantly more than just using the privacy and user-friendly alternative that’s already been built into the iPhone for the past 7 years. Most likely there is some motivation there for the company to track your activities on those websites.


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
  }
  .in-app-browser-overview .app-name {
    text-align: left;
  }
  .browser-green {
    background-color: rgba(0, 255, 0, 0.2);
  }
  .browser-red {
    background-color: rgba(255, 0, 0, 0.2);
  }
</style>
