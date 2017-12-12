---
layout: post
title: "Introducing Overkill - Don't let iTunes interrupt your workflow"
categories: []
tags:
- itunes
- overkill
status: publish
type: post
published: true
meta: {}
---

Exactly one year after the initial launch of Overkill as a shell script, after being [#1 on ProductHunt](https://www.producthunt.com/posts/overkill), I'm extremely excited to announce that **Overkill is now a native Mac app**.

Did iTunes ever launch without you opening it? Use Overkill to instantly kill the iTunes process once it opened itself, so your workflow isn't interrupted.

<p style="color: #888; margin-left: 20px">But Felix, you can use the check box to not launch iTunes when you connect your phone!</p>

Yes, that is correct, but connecting a device to your Mac is only one of the many reasons when iTunes can't wait to spread joy:

- You click the play/pause key while listening to a web-based music player (e.g. SoundCloud, YouTube)
- Someone sent you a link to an iOS app
- You click on a link on the web, and didn't expect it to be an Music link
- You updated iTunes
- You launch iTunes iby clicking on the icon by mistake
- You open a video/music file in Finder, and forgot to change the default app to VLC
- You connect Bluetooth headphones

### Before Overkill

<div class="video">
  <figure>
    <iframe width="670" height="400" src="//www.youtube.com/embed/4kn-HefqjXE" frameborder="0" allowfullscreen></iframe>
  </figure>
</div>

As you can see in the video above, iTunes would launch while you're typing something, stealing the window focus, and making this sound we all love to hear.

### With Overkill

<div class="video">
  <figure>
    <iframe width="670" height="400" src="//www.youtube.com/embed/Uk2oEKMC2_k" frameborder="0" allowfullscreen></iframe>
  </figure>
</div>

With Overkill, you connect your iPhone to charge it, and you can still use your Mac.

## Introducing Overkill for Mac

Overkill is a simple, elegant Mac app, that runs in the background and makes sure iTunes never interrupts your work. 
And for those movie nights where you actually want to use iTunes, just click on `Pause Overkill` and enjoy the evening.

<img src="/assets/posts/overkill.png" />

If you have other apps you don't want to launch automatically (e.g. Photos app), you can add those apps to the Overkill list as well.

No installation required, just download Overkill from the link below, double click the Overkill icon, and you're good to go!

<h3 style="text-align: center; font-size: 35px; margin-bottom: 50px">
  <a href="https://github.com/KrauseFx/overkill-for-mac/releases/download/1.0/Overkill.zip" target="_blank" style="color: #60A74E !important; text-decoration: underline;">
    Download Overkill Mac App
  </a>
</h3>

Unfortunately I couldn't submit Overkill to the Mac App Store, as the sandboxing doesn't allow the termination of other processes.

## Features

- Runs silently in the background, and kills iTunes
- Easily pause Overkill if you want to use iTunes
- Support for both Dark and Light mode of the menu bar
- Supports auto start
- Supports any Mac app, e.g. add the Photos app to be killed also
- No CPU usage, no polling, no analytics, just 300 lines of native Mac code

Additionally, as most of the project I work on, Overkill is 100% open source under the MIT license:

<h3 style="text-align: center; font-size: 30px; margin-top: 0px">
  <a href="https://github.com/KrauseFx/overkill-overkill-for-mac" target="_blank" style="text-decoration: underline;">
    Open on GitHub
  </a>
</h3>

