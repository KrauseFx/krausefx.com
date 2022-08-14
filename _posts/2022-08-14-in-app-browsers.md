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

There are several lightweight markup languages that are supersets of Markdown. They include basic syntax and build upon it by adding additional elements like tables, code blocks, syntax highlighting, URL auto-linking, and footnotes. Many of the most popular Markdown applications use one of the following lightweight markup languages:

There are several lightweight markup languages that are supersets of Markdown. They include basic syntax and build upon it by adding additional elements like tables, code blocks, syntax highlighting, URL auto-linking, and footnotes. Many of the most popular Markdown applications use one of the following lightweight markup languages:

There are several lightweight markup languages that are supersets of Markdown. They include basic syntax and build upon it by adding additional elements like tables, code blocks, syntax highlighting, URL auto-linking, and footnotes. Many of the most popular Markdown applications use one of the following lightweight markup languages:

There are several lightweight markup languages that are supersets of Markdown. They include basic syntax and build upon it by adding additional elements like tables, code blocks, syntax highlighting, URL auto-linking, and footnotes. Many of the most popular Markdown applications use one of the following lightweight markup languages:

There are several lightweight markup languages that are supersets of Markdown. They include basic syntax and build upon it by adding additional elements like tables, code blocks, syntax highlighting, URL auto-linking, and footnotes. Many of the most popular Markdown applications use one of the following lightweight markup languages:

---

## iOS Apps that built their own In-App Browser

<table class="in-app-browser-overview">
  <tr style="height: 60px; line-height: 23px;">
    <th style="width: 150px">App</th>
    <th>"Open in Browser" button</th>
    <th>Shows URL</th>
    <th>Injects JavaScript</th>
    <th>Last updated</th>
  </tr>
  {% for app in site.data.in_app_browsers %}
    <tr>
      <td class="app-name">{{ app.name }}</td>
      <td>
        {% if app.has_open_in_browser == true %}
          ✅
        {% else %}
          ⛔️
        {% endif %}
      </td>
      <td>
        {% if app.shows_url == true %}
          ✅
        {% else %}
          ⛔️
        {% endif %}
      </td>
      <td>
        <a target="_blank" href="/assets/app_screenshots/{{ app.screenshot }}.png">
          {% if app.injects_js == true %}
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
</style>
