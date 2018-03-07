---
layout: post
title: "How I use Twitter"
categories: []
tags:
- twitter
status: publish
type: post
published: true
meta: {}
---


## Background

For most people, using the official Twitter client works fine. It's optimized to show you new content you might be interested in, makes it easy to follow new users, and shows content that might be most relevant to you first. If you have an engineering mindset, chances are you want to be in control of what you see in your timeline.

I use Twitter to stay up to date with certain people. I want to hear about new projects or new content they published, new blog posts, thoughts of them, etc. I'm not interested in hearing political opinions, sport scores, etc, which I already have Facebook for. If I follow someone, I'll read every single tweet from them. For the last 5 years, I didn't miss a tweet in my timeline, so I have to be very careful about who to follow, and what content to see. So I set out to customize Twitter to archive that goal, and to only see about 50-75 tweets per day.


## Solution

I've been using [Tweetbot](https://tapbots.com/tweetbot/) for the last few years, the technique described below might work with other third party Twitter clients also.


### Muted Keywords

Very basic list of words, that as soon as a tweet contains one of them, it will be hidden, examples include:

*   headphone jack
*   drake
*   podcast
*   president

### Muted users

I stopped using this feature, now that I use secret lists to follow people (see below), and disabled RTs. Muting users for a given time period or forever is useful for a few situations:



*   Some users in your timeline might promote a product, so you can mute that product
*   If a user is at a conference/event you're not interested in, you can mute them for a few days


### Muted Regexes

A very powerful feature of Tweetbot is to define a regex to hide tweet. I use it to hide annoying jokes like



*   `remember \w+`
*   `german word for \w+`
*   `\w+ is the new \w+`

or to hide tweets from people that think we're interested about their airplane delays or #sports



*   `(virgin|Virgin|@United|delta|Delta|JetBlue|jetblue)`
*   twitter.com/i/moments
*   For every #sports #event there are also custom-made mute filters (truncated): `(?#World Cup)(?i)((?# Terms)(Brazil\s*2014|FIFA|World\s*Cup|Soccer|F(oo|u)tbal)|(?# Chants)(go a l |[^\w](ole\s*){2,})|(?# Teams)(#(B....`


### Hide all mentions

This very much changed my whole timeline (for the better). Turns out, I follow people for their announcements, what they work on, what they're doing, what they're thinking about, etc. I actually don't want to see 2 people communicating publicly using @ mentions, unless it's a topic I'm interested in. So I started hiding all tweets that start with an `@` symbol using a simple Tweetbot regex



*   `^@`

If I want to see responses to a tweet, I'd swipe to the left side, and see all replies.


### Muted Clients

Muting certain clients has been amazing, very easy to set up and cleans up your timeline a lot. Some of the clients I mute:



*   Buffer (to avoid "content marketing", so many companies make the mistake of tweeting the same posts every week or so using Buffer)
*   IFTTT (lots of people use that to auto-post not original content)
*   Spotify
*   Foursquare (I follow friends on Swarm already, no need to see it twice)
*   Facebook

<img src="/assets/posts/tweetbot_filters.png" width="220" style="float: right; margin-left: 20px"/>


### Secret Lists

One issue I had was to balance the number of tweets in my timeline, and then also being polite and following friends. To avoid the whole "Why are you not following me?" conversation, I now use a private list to follow about 300 people only. I [open sourced the script](https://github.com/krausefx/twitter-unfollow) I used to migrate all the people I used to follow over to a private list.


### Disable RTs

This has been a great change: As described above, I follow people for what they do, what they think of, and what they're working on. Some people have the habit of RTing content that might be interesting, but not relevant to why I want to stay subscribed to their tweets. On Tweetbot, you can.

### Muting hashtags

<img src="/assets/posts/tweetbot_filters_2.png" width="220" style="float: right; margin-left: 20px; margin-top: 20px"/>


I thank everyone for using hashtags for certain events, making it easy to hide them from my timeline :)


### Disadvantages of this approach

Some of the newer Twitter features don't have an API, and therefore can't be offered by Tweetbot. This includes Polls, Moments and Group DMs. Since I don't want to miss group DMs, I set up email notifications for Twitter DMs, and set up a Gmail filter to auto-archive emails that are not from group DMs.


### Summary

I've spent quite some time optimizing that workflow, and it's very specific, and probably not useful for most people. I try to minimize my time on social media, I only browse my Twitter feed when I have a few minutes to kill on the go. Meaning I work through my timeline only on my iPhone, and reply to mentions and DMs only on my Mac. I don't want to come across uninterested, I do follow people on Facebook, I do read news and stay up to date. Twitter is a place for very specific content for me, and I want to keep using it as that.
