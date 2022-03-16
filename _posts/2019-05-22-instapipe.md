---
layout: post
title: "instapipe.net - Distribute your Instagram stories"
categories: []
tags:
- open-source
- instagram
- telegram
status: publish
type: post
published: true
meta: {}
---

## Background

You want to share experiences as they are happening in your life. Instagram Stories is a great way to do so, thanks to cross-posting to Facebook, Messenger and Instagram itself, allowing most people to view your stories.

However just like Snapchat, the platforms try to lock you in, with the content **you** create. Many of my family members and close friends don't use FB/IG daily, but still wanted to stay up to date on what I'm up to.

Due to lack of an official API, and any kinds of integrations, the only way to access your stories is through the inofficial API the Instagram mobile- and web client use.

## Solution

A simple web service that automatically downloads and publishes your stories on various platforms. It's open source and fully self hosted, check it out [on GitHub](https://github.com/KrauseFx/instapipe).

### Embed into websites

<a href="https://howisFelix.today">
  <img src="/assets/posts/instapipe/whereisfelixScreenshot.jpg" />
</a>

Showing what you're up to on the websites you operate is an easy way to make your online presence more personal.

- [On howisFelix.today?](https://howisFelix.today)
- [Integrated into krausefx.com](https://krausefx.com) (desktop only)
- [Plain live demo](https://krausefx.github.io/instapipe/web/index.html)

**Features**

- Design similar to instagram.com web
- Arrow keys to go back and forth between stories
- Support for photos and videos
- Support for desktop and mobile browsers
- Dismiss stories using ESC key, and clicking the dimmed area
- Pre-loading of the next story for instant rendering
- Basic features like rendering of the progress bar, the relative time stamp, as well as linking to your profile
- Zero dependencies, plain JavaScript, CSS and HTML in a single file

### Provide a JSON API

Of course it also provides you with a JSON API, that can be used to integrate your Instagram stories into any app or service. The API includes all relevant data, including the raw image, location and the exact resolution of the media assets.

<img src="/assets/posts/instapipe/apiScreenshot.jpg" />

[https://instapipe.herokuapp.com/stories.json?user_id=4409072](https://instapipe.herokuapp.com/stories.json?user_id=4409072)

Make sure to manually copy & paste this in a new tab to avoid the cross-site scripting protection

### Telegram group

Many of my friends don't want to check Instagram every day, but still want to stay up to date with what I'm up to. Since they all use Telegram already, I set up a channel that automatically shows the stories I post.

<a href="https://t.me/joinchat/AAAAAFADGfZcXqQj3TK73A">
  <img src="/assets/posts/instapipe/telegramScreenshot.jpg" />
</a>

A [Telegram group](https://t.me/joinchat/AAAAAFADGfZcXqQj3TK73A) containing all my latest stories. In particular nice to get an overview over all your most recent stories. Join it [here](https://t.me/joinchat/AAAAAFADGfZcXqQj3TK73A).

## How it works

Instapipe is a simple server, that periodically fetches your most recent Instagram stories. As soon as a new story is available, it will

- Download the highest resolution photo/video and store it on your personal Google Cloud Bucket
- Store the associated metadata in a database you own, the data includes
  - 24 hours signed URL to the full-resolution photo/video of your Google Cloud Storage
  - The full path of the resource referencing your Google Cloud bucket
  - The user ID who published the asset
  - The height and width of the photo/video
  - The exact time stamp of publishing
  - An `is_video` flag
  - The location (if a location tag is attached)
    - Location Name (e.g. `Das Gym`)
    - `lat` and `lng` coordinates
- Post the new story into a Telegram group ([check it out here](https://t.me/joinchat/AAAAAFADGfZcXqQj3TK73A))

<img src="/assets/posts/instapipe/databaseScreenshot.jpg" />

---

<h3 style="text-align: center; font-size: 140%"><a href="https://instapipe.net">Open instapipe.net</a></h3>

