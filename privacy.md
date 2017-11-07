---
layout: page
title: Privacy
categories: []
tags: []
status: publish
type: page
published: true
meta: {}
---

# Privacy research

I work on privacy research projects for the iOS platform in my free time. Those projects are in no way affiliated with my work or my employer.

My privacy research posts and tweets had more than 10,000,000 impressions within just a few weeks. The goal is to raise awareness of what technology can do, and educate on how you, as a user, can protect yourself.

I'm taking a short break on privacy related publications, and launch more projects in 2018.

Feel free to write about any of the topics below, make sure to read the original blog post linked, and feel free to use any of the images and videos provided on [krausefx.com](https://krausefx.com), as long as you reference the original blog post, including my name.

If you need any additional resources, or have any follow-up questions that are not covered by the blog post, feel free to reach out to me directly, either on [Twitter](https://twitter.com/KrauseFx) or via [email](/about).

----

## [watch.user](/blog/ios-privacy-watchuser-access-both-iphone-cameras-any-time-your-app-is-running)

**Every iOS app you ever gave permission to use your camera can record you any time it runs - without notice**

Once you grant an app access to your camera, it can

- access both the front and the back camera
- record you at any time the app is in the foreground
- take pictures and videos without telling you
- upload the pictures/videos it takes immediately
- run real-time face recognition to detect facial features or expressions
- Have you ever used a social media app while using the bathroom? 🚽

All without indicating that your phone is recording you and your surrounding, no LEDs, no light or any other kind of indication.

### [Read the full blog post](/blog/ios-privacy-watchuser-access-both-iphone-cameras-any-time-your-app-is-running)

<div class="press">
  <a href="https://lifehacker.com/how-to-stop-ios-apps-from-secretly-spying-through-your-1819877630">
    <img src="/assets/privacy/Lifehacker.png">
  </a>
  <a href="https://9to5mac.com/2017/10/26/ios-camera-permissions-abuse/">
    <img src="/assets/privacy/9to5.png">
  </a>
  <a href="https://gizmodo.com/developer-shows-how-iphone-apps-can-theoretically-spy-o-1819874714">
    <img src="/assets/privacy/Gizmodo.png">
  </a>
  <a href="https://www.macrumors.com/2017/10/26/developer-warns-iphone-camera/">
    <img src="/assets/privacy/MacRumors.png">
  </a>
  <a href="https://thenextweb.com/apple/2017/10/26/iphone-camera-permissions-google-ios/">
    <img src="/assets/privacy/TheNextWeb.png">
  </a>
  <a href="https://motherboard.vice.com/en_us/article/mb3ezy/iphone-apps-camera-permission-pictures-videos-without-you-noticing">
    <img src="/assets/privacy/Motherboard.svg">
  </a>
  <a href="https://www.unilad.co.uk/featured/creepy-apple-loophole-seriously-infringes-on-your-privacy/">
    <img src="/assets/privacy/Unilad.jpg">
  </a>
</div>

----

## [steal.password](/blog/ios-privacy-stealpassword-easily-get-the-users-apple-id-password-just-by-asking)

Do you want the user’s Apple ID password, to get access to their Apple account, or to try the same email/password combination on different web services? Just ask your users politely, they’ll probably just hand over their credentials, as they’re trained to do so 👌

<img src="/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_59dc97a83e00bed1b42c0096_1507631710330__img.png_" width="500" />

### [Read the full blog post](/blog/ios-privacy-stealpassword-easily-get-the-users-apple-id-password-just-by-asking)

<div class="press">
  <a href="https://daringfireball.net/linked/2017/10/10/ios-phishing">
    <img src="/assets/privacy/DaringFireball.png">
  </a>
  <a href="https://lifehacker.com/how-to-stop-ios-apps-from-stealing-your-apple-id-passwo-1819978731">
    <img src="/assets/privacy/Lifehacker.png">
  </a>
  <a href="https://9to5mac.com/2017/10/10/psa-apple-id-phishing-attempt/">
    <img src="/assets/privacy/9to5.png">
  </a>
  <a href="https://www.macrumors.com/2017/10/10/apple-ios-phishing-attack-concept/">
    <img src="/assets/privacy/MacRumors.png">
  </a>
  <a href="https://arstechnica.com/information-technology/2017/10/beware-of-sketchy-ios-popups-that-want-your-apple-id/">
    <img src="/assets/privacy/ArsTechnica.png">
  </a>
  <a href="http://fortune.com/2017/10/10/apple-iphone-password-phishing-scam/?iid=sr-link2">
    <img src="/assets/privacy/Fortune.jpg">
  </a>
  <a href="https://motherboard.vice.com/en_us/article/ne7gxz/ios-iphone-password-phishing-app-popups">
    <img src="/assets/privacy/Motherboard.svg">
  </a>
  <a href="https://www.theguardian.com/technology/2017/oct/12/apple-id-iphone-password-demands-security-flaw-phishing-attack-fake-sign-in-request">
    <img src="/assets/privacy/TheGuardian.png">
  </a>
  <a href="https://finance.yahoo.com/news/beware-apple-iphone-password-phishing-174756750.html">
    <img src="/assets/privacy/Yahoo.jpg">
  </a>
  <a href="https://www.wired.com/story/apple-id-password-phishing/">
    <img src="/assets/privacy/Wired.png">
  </a>
  <a href="http://www.dailymail.co.uk/sciencetech/article-5020769/iPhone-apps-silently-turn-camera.html">
    <img src="/assets/privacy/DailyMail.jpg">
  </a>
</div>

----

## [detect.location](/blog/ios-privacy-detectlocation-an-easy-way-to-access-the-users-ios-location-data-without-actually-having-access)

<img src="/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_59db4461cf81e005db7a2062_1507542261614_Screenshot+2017-10-09+11.40.41.png.41.png_" width="700" />

Once the user grants access to the image library (e.g. to upload a single photo as a profile picture), an iOS app can

* Get a history of the cities, countries, and other places a user has visited, as long as they took a picture there
* Find the user's place of work, by figuring out where they are from 9 to 5
* Get a complete list of the user's cameras and photography devices (which iPhones, Android phones, cameras) and how long they used each device
* Use facial recognization to find out who the user hangs out with and who their partner is. Is the user single?
* Understand the user's background:
  * Did the user attend college? If so, which one?
  * Did the user recently move from the suburbs to the city?
  * Does the user spend a lot of time with their family?

### [Read the full blog post](/blog/ios-privacy-detectlocation-an-easy-way-to-access-the-users-ios-location-data-without-actually-having-access)

<div class="press">
  <a href="https://lifehacker.com/how-apps-use-your-photos-to-track-your-location-1819802266">
    <img src="/assets/privacy/Lifehacker.png">
  </a>
  <a href="http://t3n.de/news/datenleck-ios-metadaten-fotos-862803/">
    <img src="/assets/privacy/t3n.png">
  </a>
  <a href="https://derstandard.at/2000064949062/Oesterreichischer-Entwickler-zeigt-wie-Foto-Apps-am-iPhone-schnueffeln">
    <img src="/assets/privacy/derStandard.gif">
  </a>
</div>

----

## [user.activity](/blog/ios-privacy-whats-the-user-doing)

Any website you're visiting instantly gets access to your smartphone's acceleration and gyro sensor values in real-time without asking the user for permission.

<img src="/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_59db442dcf81e005db7a1f0b_1507542072340_photo.jpg_" width="450" />

As a result, any website you visit, can do a pretty precise guess on if you are:

* sitting
* standing
* walking
* running
* driving
* taking a picture
* taking a selfie
* lying in bed, laying the phone on a table

### [Read the full blog post](/blog/ios-privacy-whats-the-user-doing)

<style type="text/css">
  .press > a {
    text-decoration: none;
  }
  .press > a > img {
    max-height: 70px;
    max-width: 180px;
    margin: 10px;
  }
</style>
