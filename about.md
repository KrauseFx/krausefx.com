---
layout: page
title: About Felix Krause
categories: []
tags: []
status: publish
type: page
published: true
meta: {}
---

<h1 style="text-align: center; margin-bottom: 30px; margin-top: -60px">About</h1>

<div id="leftCol">
  <img src="/assets/FelixKrauseProfilePicture.jpg" width="290" style="margin-bottom: 10px; margin-top: 5px;" />
  <br />
  <p style="text-align: center;"><small style="">Felix Krause, creator of <a href="https://fastlane.tools" target="_blank">fastlane</a></small></p>
</div>

<div id="rightCol">
  <p>Follow what I'm up to on <a href="https://twitter.com/krausefx">Twitter</a> and <a href="https://instagram.com/KrauseFx">Instagram</a>, as well as <a href="https://howisFelix.today">howisFelix.today</a></p>

  <p>I'm the founder of <a href="https://fastlane.tools" target="_blank">fastlane</a>, an open source tool for iOS and Android developers focussed on making building and releasing apps easier. Just last year, fastlane has saved over 33,000,000 developer hours and is used by hundreds of thousands of companies around the world. My work got featured on various news platforms, like <a href="https://www.theguardian.com/technology/2017/oct/12/apple-id-iphone-password-demands-security-flaw-phishing-attack-fake-sign-in-request">The Guardian</a>, <a href="https://www.telegraph.co.uk/technology/2017/10/26/warning-iphone-apps-can-silently-turn-cameras-time/">The Telegraph</a>, <a href="https://www.unilad.co.uk/featured/creepy-apple-loophole-seriously-infringes-on-your-privacy/">Unilad</a> and <a href="https://www.forbes.at/artikel/30u30-2017-felix-krause.html" target="_blank">Forbes 30 under 30</a> (German), as well as being on the <a href="https://twitter.com/krausefx/status/737989912847224832?lang=en">Forbes Cover</a> (DACH region).</p>

  <p><b>fastlane</b></p>

  <p>I worked on <a href="https://fastlane.tools" target="_blank">fastlane</a> at Google and previously Twitter in San Francisco.</p>

  <p><b>Privacy research</b></p>

  <p>I've published various privacy related essays on the iOS permission system. As a result my posts reached #1 on HackerNews multiple times and got covered by major media outlets. <a href="/privacy">Read more about my privacy publications</a>.</p>

  <p><b>Open Source</b></p>

  <p>Additionally to <a href="https://fastlane.tools" target="_blank">fastlane</a>, I've been involved in other open source projects, like <a href="https://github.com/danger/danger" target="_blank">danger</a> and <a href="https://instapipe.net">instapipe</a>.</p>

  <p>I'm the founder of <a href="https://ios-factor.com" target="_blank">iOS-factor.com</a>, an open source best-practices guide on how to build and ship high-quality iOS apps.</p>

  <p><b>Speaking</b></p>

  <p>I spoke at various conferences around the world, most recently Madrid, Tel Aviv, Oslo, Tokyo, Melbourne, Bangalore, Vienna, Berlin and San Francisco. For speaking engagements get in touch with me using the form below.

  <p>To see my current location, upcoming trips, and more, check out <a href="https://howisFelix.today" target="_blank">howisFelix.today</a>.</p>

  <p><b>Previous work and projects</b></p>
  <p>Product Hunt, MindNode, Wunderlist, Bikemap, <a href="https://github.com/xcpretty/xcode-install">xcode-install</a> amongst others. Check out the <a href="/projects">Projects overview</a> for more details.</p>

  <p>I moved to a new place <a href="/blog/going-nomad">every month</a> without having an apartment for 2.5 years</p>

  <p>Every other year I take the exact same photo as my Twitter/GitHub profile picture, introducing <a href="/blog/continuous-delivery-for-your-profile-picture">Continuous Delivery for your profile picture</a>.</p>

  <p>You can always reach me via Email <a href="mailto:contact@krausefx.com">contact@krausefx.com</a> or <a href="https://twitter.com/KrauseFx">Twitter</a>.</p>

<hr style="margin-top: 35px" />

<h2>Personal Photos</h2>
<div class="imageCarousel" id="personalCarousel">
</div>

<hr />

<h2>Speaking</h2>
<div class="imageCarousel">
  <a href="/assets/speaking/FelixKrause1.jpg" target="_blank">
    <img src="/assets/speaking/FelixKrause1.jpg" alt="Felix Krause (KrauseFx) speaking at conference at Facebook Mobile at Scale in Tel Aviv, Israel" />
  </a>
  <a href="/assets/speaking/FelixKrause4.jpg" target="_blank">
    <img src="/assets/speaking/FelixKrause4.jpg" alt="Felix Krause (KrauseFx) speaking at conference at trySwift in New York" />
  </a>
  <a href="/assets/speaking/FelixKrause2.jpg" target="_blank">
    <img src="/assets/speaking/FelixKrause2.jpg" alt="Felix Krause (KrauseFx) speaking at conference at Facebook Mobile at Scale in Tel Aviv, Israel" />
  </a>
  <a href="/assets/speaking/FelixKrause5.jpg" target="_blank">
    <img src="/assets/speaking/FelixKrause5.jpg" alt="Felix Krause (KrauseFx) speaking at conference at WeAreDevelopers in Vienna, Austria" />
  </a>
  <a href="/assets/speaking/FelixKrause3.jpg" target="_blank">
    <img src="/assets/speaking/FelixKrause3.jpg" alt="Felix Krause (KrauseFx) speaking at conference at Facebook Mobile at Scale in Tel Aviv, Israel" />
  </a>
  <a href="/assets/speaking/FelixKrause6.jpg" target="_blank">
    <img src="/assets/speaking/FelixKrause6.jpg" alt="Felix Krause (KrauseFx) speaking at conference at trySwift in New York" />
  </a>
  <a href="/assets/speaking/FelixKrause7.jpg" target="_blank">
    <img src="/assets/speaking/FelixKrause7.jpg" alt="Felix Krause (KrauseFx) speaking at conference at trySwift in New York" />
  </a>
</div>

<script type="text/javascript">
  var url = "https://where-is-felix-today-backend.herokuapp.com/api.json";

  var xmlHttp = new XMLHttpRequest();
  xmlHttp.onreadystatechange = function() { 
      if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
        var content = JSON.parse(xmlHttp.responseText)
        var photos = content["recentPhotos"]
        var personalCarousel = document.getElementById("personalCarousel")
        for (let photoIndex in photos) {
          let currentPhoto = photos[photoIndex]

          if (currentPhoto["url"].indexOf("20220218.jpg") > -1) {
            // Since we have that photo right above
            continue;
          }

          var linkNode = document.createElement("a");
          linkNode["href"] = currentPhoto["link"] || "https://instagram.com/krausefx"
          linkNode["target"] = "_blank"
          var imageNode = document.createElement("span")
          imageNode["style"] = "background-image: url(" + currentPhoto["url"] + ")"
          imageNode["alt"] = currentPhoto["text"]

          linkNode.appendChild(imageNode)
          personalCarousel.appendChild(linkNode)

          if (photoIndex > 8) {
            break; // We don't want to load all the images
          }
        }
      }
  }
  xmlHttp.open("GET", url, true); // true = asynchronous 
  xmlHttp.send(null);
</script>

<hr />
  
  You can reach me easily via <a href="https://twitter.com/KrauseFx">Twitter</a> and email <a href="mailto:contact@krausefx.com">contact@krausefx.com</a>, or use the form below

<div style="width: 100%; float: left; margin-top: 20px; margin-bottom: 20px;">
  <form id="contactform" method="POST" action="https://formspree.io/contact@krausefx.com">
    <p><b>Email Address</b></p>
    <input type="email" name="_replyto" placeholder="Your email address">

    <p><b>Message</b></p>
    <textarea placeholder="Your message" name="message"></textarea>
    <input type="hidden" name="_subject" value="New message from krausefx.com" />
    <br />
    <input type="submit" value="Submit">
  </form>
</div>

<hr />
<p style="text-align: right; color: #999">
  WeAreDevelopers photos by Tamás Künsztler
</p>

<style type="text/css">
  .imageCarousel {
    margin-top: 30px;
    height: 310px;
    width: 100%;
    overflow-y: none;
    overflow-x: scroll;
    white-space: nowrap;
  }

  .imageCarousel > a > img {
    height: 300px;
    width: auto;
    max-width: none; /* to override page wide attribute */
    display: inline-block;
  }
  #personalCarousel > a > span {
    /* I didn't spend the time investigating why this is necessary */
    margin-right: 5px;
    height: 300px;
    display: inline-block;
    width: 300px; /* IG pictures should always be square */
    background-size: cover;
    background-repeat: no-repeat;
    background-position: 50% 50%;
  }
  #contactform {
    padding-top: 30px;
  }

  #contactform input[type="email"] {
    width: calc(100% - 20px);
    height: 30px;
    font-size: 16px;
    padding: 10px;
    margin-bottom: 10px;
  }
  #contactform textarea {
    width: calc(100% - 30px);
    height: 100px;
    font-size: 16px;
    border: 1px solid #ccc;
    background-color: #fafafa;
    padding: 15px;
    resize: vertical;
  }
  #contactform input[type="submit"] {
    display: inline-block;
    width: 127px;
    height: 42px;
    background-color: #272727;
    color: white;
    font-weight: 600;
    font-style: normal;
    font-size: 14px;
    border: none;
    margin-top: 10px;
    cursor: pointer;
  }
  #leftCol {
    margin-bottom: 40px;
    margin-right: 30px;
    width: 100%;
    text-align: center;
  }
  @media screen and (max-width: 800px) {
    .imageCarousel {
      height: 190px;
    }
    .imageCarousel > a > img {
      height: 180px;
    }
    #personalCarousel > a > span {
      height: 180px;
      width: 180px;
    }
    #leftCol > img { 
      width: 40%;
    }
    #leftCol > p {
      display: none;
    }
  }
  @media screen and (min-width: 800px) {
    #leftCol {
        width: 40%; 
        float: left;
        height: 900px;
      }
    }
  }
  @media screen and (min-width: 800px) {
    #rightCol {
      width: 55%; 
      float: right;
    }
  }
  }
</style>
