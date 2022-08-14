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

[Last week I've published a detailed report](https://krausefx.com/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser) on the risks of In-App Browsers, as well as how apps like Instagram and Facebook are injecting JavaScript code into third party websites. 
The article was featured by major media outlets across the globe, like [TheGuardian](https://www.theguardian.com/technology/2022/aug/11/meta-injecting-code-into-websites-visited-by-its-users-to-track-them-research-says) and [The Register](https://www.theregister.com/2022/08/12/meta_ios_privacy/), got a [over a million impressions on Twitter](https://twitter.com/KrauseFx/status/1557412468368052225), and was ranked [#1 on HackerNews](https://news.ycombinator.com/item?id=32415470) for more than 12 hours.

One of the main questions by the community was: Where can they access the tool to verify what apps are doing inside their webviews?

Introducing [hijacking.report](https://hijacking.report), a simple tool to list all JavaScript commands executed by the iOS app rendering the link.

Steps to use [hijacking.report](https://hijacking.report):

1. Open the app you want to analyze
1. Send or post [https://hijacking.report](https://hijacking.report) in app
1. Tap on the link inside the app to open it
1. Read the report on the screen

## iOS Apps that built their own In-App Browser

<table class="in-app-browser-overview">
  <tr style="height: 60px; line-height: 23px;">
    <th style="width: 150px">App</th>
    <th>"Open in Browser" button</th>
    <th>Shows URL</th>
    <th>Runs JS for metadata</th>
    <th>Injects JS</th>
    <th>Last updated</th>
  </tr>
  {% for app in site.data.in_app_browsers %}
    <tr>
      <td class="app-name">{{ app.name }}</td>
      {% if app.has_open_in_browser == true %}
        <td class="browser-green">✅</td>
      {% else %}
        <td class="browser-red">⛔️</td>
      {% endif %}

      {% if app.shows_url == true %}
        <td class="browser-green">✅</td>
      {% else %}
        <td class="browser-red">⛔️</td>
      {% endif %}

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
      <td class="last-updated">{{ app.last_updated }}</td>
    </tr>
  {% endfor %}
</table>

## iOS Apps that use Safari

<table class="in-app-browser-overview safari-users">
  <tr>
    <th>App</th>
    <th>Technology</th>
    <th>Last updated</th>
  </tr>
  {% for app in site.data.using_safari %}
    <tr>
      <td class="app-name">{{ app.name }}</td>
      <td class="technology">{{ app.technology }}</td>
      <td class="last-updated">{{ app.last_updated }}</td>
    </tr>
  {% endfor %}
</table>


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
