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

<h1 style="text-align: center; margin-bottom: 40px; margin-top: -50px">About Felix Krause</h1>

<div id="leftCol">
  <img src="/assets/FelixKrauseSpeakingCut.jpg" width="290" style="margin-bottom: 10px" />
  <br />
  <p style="text-align: center;"><small style="">Felix Krause, creator of <a href="http://fastlane.tools" target="_blank">fastlane</a></small></p>
</div>

<div id="rightCol">
  <p>On vacation right now, after having <a href="/blog/ending-my-fastlane-chapter">ended my fastlane chapter</a>.</p>

  <p>Follow what I'm up to on <a href="https://twitter.com/krausefx">Twitter</a> and <a href="https://instagram.com/KrauseFx">Instagram</a>.</p>

  <p>I'm the founder of <a href="http://fastlane.tools" target="_blank">fastlane</a>, an open source tool for iOS and Android developers focussed on making building and releasing apps easier. Just last year, fastlane has saved over 15,000,000 developer hours and is used by tens of thousands of companies around the world.</p>

  <p>I move to a new place <a href="/blog/going-nomad">every month</a>.</p>

  <p><b>fastlane</b></p>

  <p>I worked on <a href="http://fastlane.tools" target="_blank">fastlane</a> at Google and previously Twitter in San Francisco.</p>

  <p><b>Privacy research</b></p>

  <p>I've published various privacy related essays on the iOS permission system. As a result my posts reached #1 on HackerNews multiple times and got covered by major media outlets - <a href="/privacy">Read more about my privacy publications</a>.</p>

  <p><b>Open Source</b></p>

  <p>Additionally to <a href="http://fastlane.tools" target="_blank">fastlane</a>, I'm involved in other open source projects, like <a href="https://github.com/danger/danger" target="_blank">danger</a>.</p>

  <p>I'm the founder of <a href="https://ios-factor.com" target="_blank">iOS-factor.com</a>, an open source best-practices guide on how to build high-quality iOS apps.</p>

  <p><b>Speaking</b></p>

  <p>I spoke at various conferences around the world, most recently Tel Aviv, Oslo, Tokyo, Melbourne, Bangalore, Vienna, Berlin and San Francisco. For speaking engagements get in touch with me using the form below. Check out my 
  <a href="https://github.com/krausefx/speaking" target="_blank">speaking schedule</a>.</p>

  <p>To find my current location, as well as other info, check out <a href="https://whereisfelix.today" target="_blank">WhereIsFelix.today</a>, a fun side project that I use to experiment with new technologies.</p>

  <p><b>Previous Work</b></p>

  <p><a href="http://producthunt.com" target="_blank">Product Hunt</a>, <a href="http://mindnode.com" target="_blank">MindNode</a>, <a href="https://www.wunderlist.com" target="_blank">Wunderlist</a>, <a href="https://www.bikemap.net/" target="_blank">Bikemap</a> and more</p>
</div>

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
</div>

<script type="text/javascript">
  var url = "https://whereisfelixtoday-backend.now.sh/api.json";

  var xmlHttp = new XMLHttpRequest();
  xmlHttp.onreadystatechange = function() { 
      if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
        var content = JSON.parse(xmlHttp.responseText)
        var photos = content["recentPhotos"]
        var personalCarousel = document.getElementById("personalCarousel")
        for (let photoIndex in photos) {
          let currentPhoto = photos[photoIndex]

          var linkNode = document.createElement("a");
          linkNode["href"] = currentPhoto["link"]
          linkNode["target"] = "_blank"
          var imageNode = document.createElement("span")
          imageNode["style"] = "background-image: url(" + currentPhoto["url"] + ")"
          imageNode["alt"] = currentPhoto["text"]

          linkNode.appendChild(imageNode)
          personalCarousel.appendChild(linkNode)

          if (photoIndex > 7) {
            break; // We don't want to load all the images
          }
        }
      }
  }
  xmlHttp.open("GET", url, true); // true = asynchronous 
  xmlHttp.send(null);
</script>

<hr />

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
  }
  @media screen and (min-width: 800px) {
    #leftCol {
        width: 40%; 
        float: left;
        height: 820px;
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
