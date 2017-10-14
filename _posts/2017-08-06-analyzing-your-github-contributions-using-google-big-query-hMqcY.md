---
layout: post
title: Analyzing your GitHub contributions using Google Big Query
categories: []
tags: []
status: draft
type: post
published: false
meta: {}
---

Do you like those GitHub graphs, but want to know even more about your open source behavior? GitHub has you covered with 
[githubarchive.org](http://githubarchive.org). GitHubArchive offers dumps of all GitHub events of all users and open source projects. New ones are generated every single day, and are instantly accessible. They are very easy to use together with Google Big Query.

Just open 
[this link](https://bigquery.cloud.google.com/savedquery/900199909722:49c7fe0a1133411eb81f2c7f840b2576), click Run Query, wait for about 30 seconds, and you'll get a list of people that comment on any of the 
[fastlane](https://fastlane.tools) repos most often in the year of 2017.

 
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_598679ea37c5815a8217221e_1501985268474__img.png_)
  


To run this query for your own GitHub organization, just replace the "fastlane/%" with your own. You can also easily easily extend the query to show more columns, from the 
[list of available events](https://developer.github.com/v3/activity/events/types/).

### Analyzing your own profile


I was wondering of how my GitHub behavior changed over the last few years, now that fastlane is actively being used by tens of thousands of companies, it’s harder to 
[keep the innovation you had in the beginning](https://krausefx.com/blog/scaling-open-source-communities).

The last 3 years I published a total of

* 16,000 comments


* 5,550 Pull Requests


* 907 releases

across a high number of different GitHub projects.

Here is my last 5 years on GitHub, only open source code, no private repos counted into this.

 
