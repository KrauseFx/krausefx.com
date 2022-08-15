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

If you write a story about any of those posts, make sure to read the original blog post linked, and feel free to use any of the images and videos provided on [krausefx.com](https://krausefx.com), as long as you reference the original blog post, including my name.

If you need any additional resources, or have any follow-up questions that are not covered by the blog post, feel free to reach out to me directly, either on [Twitter](https://twitter.com/KrauseFx) or via [email](/about).

----

<div id="instagram-framed-top">
  <a href="https://krausefx.com/assets/posts/injecting-code/instagram_framed.png" target="_blank">
    <img src="https://krausefx.com/assets/posts/injecting-code/instagram_framed.png" style="width: 250px" alt="An iPhone screenshot, showing a website, rendering what commands got executed by the Instagram app in their in-app browser" />
  </a>
</div>

## [Instagram and Facebook can track anything you do on any website in their in-app browser](/blog/ios-privacy-instagram-and-facebook-can-track-anything-you-do-on-any-website-in-their-in-app-browser)
The iOS Instagram and Facebook app render all third party links and ads within their app using a custom in-app browser. This [causes various risks for the user](https://krausefx.com/blog/follow-user), with the host app being able to track every single interaction with external websites, from all form inputs like passwords and addresses, to every single tap.

- Links to external websites are rendered inside the Instagram app, instead of using the built-in Safari.
- This allows Instagram to monitor everything happening on external websites, without the consent from the user, nor the website provider.
- The Instagram app injects <a href="https://connect.facebook.net/en_US/pcm.js">their JavaScript code</a> into every website shown, including when clicking on ads. Even though the injected script doesn't currently do this, running custom scripts on third party websites allows them to monitor all user interactions, like every button & link tapped, text selections, screenshots, as well as any form inputs, like passwords, addresses and credit card numbers.

<br />

## [Read the full blog post](/blog/ios-privacy-stealpassword-easily-get-the-users-apple-id-password-just-by-asking)

<br />

<div class="press">
  <a href="https://www.theguardian.com/technology/2022/aug/11/meta-injecting-code-into-websites-visited-by-its-users-to-track-them-research-says">
    <img src="/assets/privacy/TheGuardian.png">
  </a>
  <a href="https://news.ycombinator.com/item?id=32415470">
    <img src="/assets/privacy/hackernews.ico">
  </a>
  <a href="https://www.theregister.com/2022/08/12/meta_ios_privacy/">
    <img src="/assets/privacy/TheRegister.jpg">
  </a>
  <a href="https://finance.yahoo.com/news/meta-can-track-facebook-and-instagram-users-on-ios-with-its-in-app-browsers-071834703.html">
    <img src="/assets/privacy/Yahoo.jpg">
  </a>
  <a href="https://www.macrumors.com/2022/08/10/instagram-tracking-users-in-app-browser/">
    <img src="/assets/privacy/MacRumors.png">
  </a>
  <a href="https://www.heise.de/news/In-App-Browser-auf-dem-iPhone-Experte-sieht-Trackingpotenzial-durch-Meta-7217027.html">
    <img src="/assets/privacy/heise.svg">
  </a>  
  <a href="https://9to5mac.com/2022/08/11/in-app-browsers/">
    <img src="/assets/privacy/9to5.png">
  </a>
  <a href="https://www.t-online.de/digital/internet-sicherheit/sicherheit/id_100038034/meta-konzern-kann-nutzeraktivitaeten-verfolgen.html">
    <img src="/assets/privacy/t-online.png">
  </a>
  <a href="https://www.engadget.com/meta-can-track-facebook-and-instagram-users-on-ios-with-its-in-app-browsers-071834703.html">
    <img src="/assets/privacy/engadget.png">
  </a>
  <a href="https://www.cnbctv18.com/technology/instagram-can-track-a-users-web-activity-via-in-app-browser-claims-report-14448592.htm">
    <img src="/assets/privacy/cnbc.png">
  </a>
  <a href="https://derstandard.at/2000064949062/Oesterreichischer-Entwickler-zeigt-wie-Foto-Apps-am-iPhone-schnueffeln">
    <img src="/assets/privacy/derStandard.gif">
  </a>
  <a href="https://abc3340.com/news/nation-world/meta-can-track-users-credit-card-internet-history-on-other-websites-research-claims-facebook-instagram-felix-krause-code-google-engineer">
    <img src="/assets/privacy/abc-logo.png" style="opacity: 0.9">
  </a>
  <a href="https://wfxl.com/news/nation-world/meta-can-track-users-credit-card-internet-history-on-other-websites-research-claims-facebook-instagram-felix-krause-code-google-engineer">
    <img src="/assets/privacy/FoxNews.png" style="opacity: 0.9">
  </a>
  <a href="https://metro.co.uk/2022/08/15/instagram-and-facebook-stalk-you-on-sites-accessed-through-their-apps-17184243/">
    <img src="/assets/privacy/metrocouk.jpg" />
  </a>
</div>

----

<img src="/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_59dc97a83e00bed1b42c0096_1507631710330__img.png_" width="400" align="right" />


## [steal.password](/blog/ios-privacy-stealpassword-easily-get-the-users-apple-id-password-just-by-asking)

Do you want the user’s Apple ID password, to get access to their Apple account, or to try the same email/password combination on different web services? Just ask your users politely, they’ll probably just hand over their credentials, as they’re trained to do so 👌

One of these is Apple asking you for your password and the other one is a phishing popup that steals your password.

How can you protect yourself? Press the home button and open the iCloud settings manually

<br />

## [Read the full blog post](/blog/ios-privacy-stealpassword-easily-get-the-users-apple-id-password-just-by-asking)

<br />

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
  <a href="https://news.ycombinator.com/item?id=15441537">
    <img src="/assets/privacy/hackernews.ico">
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
  <a href="https://www.theregister.co.uk/2017/10/10/apple_ios_password_prompts_phishing/">
    <img src="/assets/privacy/TheRegister.jpg">
  </a>
</div>

----

<img src="/assets/posts/watch-user-screenshot.jpg" style="width: 200px; float: right; border: 2px solid #BBB; margin: 10px" />

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

## [Read the full blog post](/blog/ios-privacy-watchuser-access-both-iphone-cameras-any-time-your-app-is-running)

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
  <a href="http://www.telegraph.co.uk/technology/2017/10/26/warning-iphone-apps-can-silently-turn-cameras-time/">
    <img src="/assets/privacy/Telegraph.png">
  </a>
  <a href="http://www.dailymail.co.uk/sciencetech/article-5020769/iPhone-apps-silently-turn-camera.html">
    <img src="/assets/privacy/DailyMail.jpg">
  </a>
  <a href="https://thenextweb.com/apple/2017/10/26/iphone-camera-permissions-google-ios/">
    <img src="/assets/privacy/TheNextWeb.png">
  </a>
  <a href="https://www.macrumors.com/2017/10/26/developer-warns-iphone-camera/">
    <img src="/assets/privacy/MacRumors.png">
  </a>
  <a href="https://motherboard.vice.com/en_us/article/mb3ezy/iphone-apps-camera-permission-pictures-videos-without-you-noticing">
    <img src="/assets/privacy/Motherboard.svg">
  </a>
  <a href="https://www.unilad.co.uk/featured/creepy-apple-loophole-seriously-infringes-on-your-privacy/">
    <img src="/assets/privacy/Unilad.jpg">
  </a>
  <a href="https://www.theregister.co.uk/2017/10/25/ios_apps_camera_spying/">
    <img src="/assets/privacy/TheRegister.jpg">
  </a>
  <a href="https://www.foxnews.com/tech/iphone-apps-with-access-to-your-camera-can-secretly-spy-on-you">
    <img src="/assets/privacy/FoxNews.png">
  </a>
</div>

----

<img src="/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_59db4461cf81e005db7a2062_1507542261614_Screenshot+2017-10-09+11.40.41.png.41.png_" width="500" align="right" />
## [detect.location](/blog/ios-privacy-detectlocation-an-easy-way-to-access-the-users-ios-location-data-without-actually-having-access)

Once the user grants access to the image library (e.g. to upload a single photo as a profile picture), an iOS app can

* Get a history of the cities, countries, and other places a user has visited, as long as they took a picture there
* Find the user's place of work, by figuring out where they are from 9 to 5
* Get a complete list of the user's cameras and photography devices (which iPhones, Android phones, cameras) and how long they used each device
* Use facial recognization to find out who the user hangs out with and who their partner is. Is the user single?
* Understand the user's background:
  * Did the user attend college? If so, which one?
  * Did the user recently move from the suburbs to the city?
  * Does the user spend a lot of time with their family?

## [Read the full blog post](/blog/ios-privacy-detectlocation-an-easy-way-to-access-the-users-ios-location-data-without-actually-having-access)

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
  <a href="https://www.theregister.co.uk/2017/09/28/ios_image_metadata_location_leaks/">
    <img src="/assets/privacy/TheRegister.jpg">
  </a>
</div>

----

## [take.screenshots](/blog/mac-privacy-sandboxed-mac-apps-can-take-screenshots)

<div style="float: right">
  <a href="/assets/posts/mac-take-screenshots.png" target="_blank">
    <img src="/assets/posts/mac-take-screenshots.png" width="600" />
  </a>
</div>

Sandboxed Mac apps can record your entire screen at any time, without you knowing.

Running the screen through simple OCR software, this allows the attacker to access personal information, like emails, messages, API keys and more

- Take screenshots of your Mac silently without you knowning
- Access every pixel, even if the Mac app is in the background
- Use basic [OCR software](https://en.wikipedia.org/wiki/Optical_character_recognition) to read the text on the screen
- Access all connected monitors

**What's the worst that could happen?**

- Read password and keys from password managers
- Detect what web services you use (e.g. email provider)
- Read all emails and messages you open on your Mac
- When a developer is targeted, this allows the attacker to potentially access sensitive source code, API keys or similar data
- Learn personal information about the user, like their bank details, salary, address, etc.

## [Read the full blog post](/blog/mac-privacy-sandboxed-mac-apps-can-take-screenshots)

<div class="press">
  <a href="https://news.ycombinator.com/item?id=16350277">
    <img src="/assets/privacy/hackernews.ico">
  </a>
  <a href="https://www.heise.de/mac-and-i/meldung/Mac-Apps-koennen-heimlich-Bildschirminhalt-aufzeichnen-trotz-Sandbox-3965929.html">
    <img src="/assets/privacy/heise.svg">
  </a>
  <a href="https://daringfireball.net/2018/02/non_native_apps_threat_to_mac">
    <img src="/assets/privacy/DaringFireball.png">
  </a>
  <a href="https://lifehacker.com/how-mac-apps-can-spy-on-your-computer-1822928525">
    <img src="/assets/privacy/Lifehacker.png">
  </a>
</div>

----

## [trusting-sdks](/blog/trusting-sdks)

Third-party SDKs can often easily be **modified** while you download them! Using a simple [person-in-the-middle attack](https://wikipedia.org/wiki/Man_in_the_middle_attack), anyone in the same network can insert malicious code into the SDK, and with that into your application, as a result running in your user's pockets. A person-in-the-middle attack in this context works by interfering network traffic and insert malicious code into the SDK.

**31%** of the most popular closed-source iOS SDKs are vulnerable to this attack, as well as a total of **623 CocoaPods**. As part of this research I notified the affected parties, and submitted patches to CocoaPods to warn developers and SDK providers.

## [Read the full blog post](/blog/trusting-sdks)

<div class="press">
  <a href="https://thenextweb.com/security/2018/02/15/want-hack-million-iphones-target-sdks-finds-security-researcher/">
    <img src="/assets/privacy/TheNextWeb.png">
  </a>
</div>

----

## [Detect when an iOS user hits the share button on your website](blog/ios-privacy-safari-share-button)

Mobile Safari notifies the server as soon as the user hits the Share button, telling the website operator that this content will likely be shared somewhere else.

<img src="/assets/posts/safari-share-button.png" width="300" />

## [Read the full blog post](/blog/ios-privacy-safari-share-button)

----

## [follow.user](/blog/follow-user)

Custom in-app browsers in iOS apps have full access to the web content, including any JavaScript variables, the full HTML DOM and more. This allows apps to steal the user's sessions, passwords, keys and more. 

## [Read the full blog post](/blog/follow-user)

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

## [Read the full blog post](/blog/ios-privacy-whats-the-user-doing)

<style type="text/css">
  #instagram-framed-top { 
    float: right;
    margin-right: -60px;
    margin-left: 10px;
  }
  @media screen and (max-width: 1000px) {
    #instagram-framed-top {
      display: none;
    }
  }
</style>
