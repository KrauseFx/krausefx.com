---
layout: page
title: Data
categories: []
tags: []
status: publish
type: page
published: true
meta: {}
---

{% include instapipe.html %}
<script type="text/javascript">
  let url = "https://where-is-felix-today-backend.herokuapp.com/api.json"

  function daysAgo(date) {
    const deltaDays = Math.floor((Date.now() - date.getTime()) / (1000 * 3600 * 24));
    if (deltaDays === 0) {
      return "today";
    } else if (deltaDays === 1) {
      return "yesterday";
    } else {
      return deltaDays + " days ago";
    }
  }

  httpGetAsync(url, function(data) {
    const otherFxLifeData = data["otherFxLifeData"]
    console.log(data)

    // Render map
    document.getElementById("currentLocationMap").style.background = "url('" + data["mapsUrl"] + "') no-repeat"

    // Render current & next locations
    if (data["isMoving"] == false) {
      document.getElementById("isMovingContainer").style.display = "none"
      document.getElementById("currentCityB").innerHTML = data["currentCityText"]
    } else {
      document.getElementById("currentCityContainer").style.display = "none"
      document.getElementById("nextCityB").innerHTML = data["currentCityText"]
    }
    if (data["nextCityText"]) {
      document.getElementById("nextCityB").innerHTML = data["nextCityText"]
    } else {
      document.getElementById("nextCityContainer").style.display = "none"
    }

    // Render today's metadata
    document.getElementById("current-weight").innerHTML = 
      "<span class='highlighted'>" + (otherFxLifeData["weight"]["value"] * 0.453592).toFixed(1) + " kg</span>/ " +
      (otherFxLifeData["weight"]["value"]).toFixed(1) + " lbs"
    document.getElementById("current-weight-time").innerHTML = "(" + daysAgo(new Date(otherFxLifeData["weight"]["time"])) + ")"
    document.getElementById("current-sleep-duration").innerHTML =
      "Slept <span class='highlighted'>" + otherFxLifeData["sleepDurationWithings"]["value"] + " hours</span>tonight"

    // Render food data (if available)
    if (data["todaysMacros"]["kcal"] > 0) {
      document.getElementById("todaysMacros-kcal").innerHTML = data["todaysMacros"]["kcal"] + " kcal"
      document.getElementById("total-kcal").innerHTML = otherFxLifeData["macrosCarbs"]["value"] * 4 + otherFxLifeData["macrosProtein"]["value"] * 4 + otherFxLifeData["macrosFat"]["value"] * 9

      document.getElementById("todaysMacros-carbs").innerHTML = data.todaysMacros.carbs + "g carbs"
      document.getElementById("todaysMacros-protein").innerHTML = data.todaysMacros.protein + "g protein"
      document.getElementById("todaysMacros-fat").innerHTML = data.todaysMacros.fat + "g fat"

      document.getElementById("macrosCarbs-value").innerHTML = data.otherFxLifeData["macrosCarbs"]["value"]
      document.getElementById("macrosProtein-value").innerHTML = data.otherFxLifeData["macrosProtein"]["value"]
      document.getElementById("macrosFat-value").innerHTML = data.otherFxLifeData["macrosFat"]["value"]
    } else {
      document.getElementById("food-data-container").style.display = "none"
    }

    document.getElementById("realTimeDataDiv").style.display = "block"
  })

  function httpGetAsync(url, callback) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = function() { 
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            callback(JSON.parse(xmlHttp.responseText));
        }
    }
    xmlHttp.open("GET", url, true);
    xmlHttp.send(null);
  }
</script>

<div id="mapsContainer">
  <div id="mapsMenuBannerCover"></div>
  <img id="currentLocationMap">
</div>
<div id="story-available">
  <img id="storyProfilePicture" src="assets/FelixKrauseCropped.jpg" onclick="showStories()" />
</div>
<div id="mapsContainerCover"></div>

<div id="realTimeDataDiv">
  <h3 id="currentCityContainer">Felix is currently in <b id="currentCityB" class="highlighted"></b></h3>
  <h3 id="isMovingContainer">Felix is currently heading to <b id="nextCityB" class="highlighted"></b></h3>
  <h4 id="nextCityContainer">Leaving for <span id="nextCityText"></span> <span id="nextCityTime"></span></h4>

  <p><span id="current-weight" class="span-key"></span> <span id="current-weight-time" class="span-value"></span></p>
  <p id="current-sleep-duration" />

  <div id="food-container">
    <h3>Felix ate today</h3>
    <div class="food-overview">
      <span>
        <span class="highlighted" id="todaysMacros-kcal"></span> of <span id="total-kcal"></span> kcal
      </span>
        <span>
        <span class="highlighted" id="todaysMacros-carbs"></span> of <span id="macrosCarbs-value"></span>g
      </span>
        <span>
        <span class="highlighted" id="todaysMacros-protein"></span> of <span id="macrosProtein-value"></span>g
      </span>
        <span>
        <span class="highlighted" id="todaysMacros-fat"></span> of <span id="macrosFat-value"></span>g
      </span>
    </div>
  </div>

  <p><a href="https://whereisfelix.today">More real-time data</a></p>
</div>

<h1>My whole life in a single database</h1>

As part of the [FxLifeSheet project](https://github.com/KrauseFx/FxLifeSheet) I've started back in 2019, I started collecting all kinds of metrics about my life.
Every single day for the last 2.5 years I've tracked over 100 different data types of my life.

I haven't yet had the time to analyze all the outcomes, but felt like I already have some very interesting graphs I'd like to share here.

Currently, I have <b>~370,000 data points</b>, with the biggest data sources being:

<table>
  <tr><th>Data Source</th><th>Number of data entries</th><th>Type of data</th></tr>
  <tr><td>RescueTime</td><td>150,000</td><td>Daily computer usage</td></tr>
  <tr><td>Foursquare Swarm</td><td>125,000</td><td>Location and POI data</td></tr>
  <tr><td>Manually entered</td><td>63,000</td><td>Fitness, mood, socializing, productivity</td></tr>
  <tr><td>Manually entered time ranges</td><td>10,000</td><td>Occupation, lockdown status, home setup</td></tr>
  <tr><td>Weather API</td><td>16,000</td><td>Temperature, rain, sunlight, wind, air pressure</td></tr>
  <tr><td>Apple Health</td><td>1,000</td><td>Steps data</td></tr>
</table>

This project has 3 components:

<b>◦ Database</b>

A timestamp-based key-value database of all data entries powered by Postgres. This allows me to add and remove questions on-the-fly.

<img src="graphs/assets/fxlifesheet-database.png">

<b>◦ Data Inputs</b>

Multiple times a day, I manually answer questions [FxLifeSheet](https://github.com/KrauseFx/FxLifeSheet) sends me via a Telegram bot.

<b>◦ Data Visualizations</b>

After having tried various tools available to visualize, I ended up writing my own data analysis layer using Ruby, JavaScript together with [Plotly](https://plotly.com/javascript/).

<div id="graphs-container">
  
    
    

    <div class="graphs-entry">
      <h3>Flying Stats - General</h3>
      <p class="graph-description">
        All flights taken within the last 7 years, tracked using Foursquare Swarm, analyzed by JetLovers.
      </p>

      <ul>
        
          <li>This clearly shows the impact of COVID starting 2020</li>
        
          <li>Sunday has been my "commute" day, flying between San Francisco, New York City and Vienna</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        JetLovers, Swarm
      </span>

      <img src="graphs/screens/jetlovers-stats.png" class="image-link" alt="Flying Stats - General" onclick="enlargeImage('graphs/screens/jetlovers-stats.png', 'Flying Stats - General')" />

      <span class="graph-date">7 years of data - Last updated on 2021-12-12</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Flying Stats - Top</h3>
      <p class="graph-description">
        All flights taken within the last 7 years, tracked using Foursquare Swarm, analyzed by JetLovers.
      </p>

      <ul>
        
          <li>Frankfurt - Vienna was the flight connecting me with most US airports</li>
        
          <li>Germany is high up on the list due to layovers, even though I didn't spend time there</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        JetLovers, Swarm
      </span>

      <img src="graphs/screens/jetlovers-top.png" class="image-link" alt="Flying Stats - Top" onclick="enlargeImage('graphs/screens/jetlovers-top.png', 'Flying Stats - Top')" />

      <span class="graph-date">7 years of data - Last updated on 2021-12-12</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Top Cities (Checkins)</h3>
      <p class="graph-description">
        Each time I checked-into a place (e.g. Coffee, Restaurant, Airport, Gym) at a given city, this is tracked as a single entry
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <img src="graphs/screens/swarm-cities-top.png" class="image-link" alt="Top Cities (Checkins)" onclick="enlargeImage('graphs/screens/swarm-cities-top.png', 'Top Cities (Checkins)')" />

      <span class="graph-date">7 years of data - Last updated on 2021-12-12</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Top Cities over the years</h3>
      <p class="graph-description">
        Each check-in at a given city is counted as a single entry, grouped by years
      </p>

      <ul>
        
          <li>2016 and 2017 I lived in San Francisco</li>
        
          <li>2018 and 2019 I lived in New York City</li>
        
          <li>2020 and 2021 I lived in Vienna</li>
        
          <li>The longer it's been since I moved away from Austria, the more time I actually spent back home in Austria for visits and vacations</li>
        
          <li>2020 clearly shows the impact of COVID</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <img src="graphs/screens/swarm-cities-top-years.png" class="image-link" alt="Top Cities over the years" onclick="enlargeImage('graphs/screens/swarm-cities-top-years.png', 'Top Cities over the years')" />

      <span class="graph-date">7 years of data - Last updated on 2021-12-12</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Top Categories of Checkins</h3>
      <p class="graph-description">
        Each check-in at a given category is tracked, and summed up over the last years
      </p>

      <ul>
        
          <li>In 2020 and 2021, check-ins at Offices went down to zero due to COVID, and a distributed work setup</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <img src="graphs/screens/swarm-categories-top.png" class="image-link" alt="Top Categories of Checkins" onclick="enlargeImage('graphs/screens/swarm-categories-top.png', 'Top Categories of Checkins')" />

      <span class="graph-date">7 years of data - Last updated on 2021-12-12</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Maximal temperature each day of the year</h3>
      <p class="graph-description">
        Historic weather data based on the location I was at on that day based on my Swarm check-ins. Days with no data are rendered as white
      </p>

      <ul>
        
          <li>Summer 2019 I spent in New York City, while 2020 and 2021 I spent in Vienna. The graph shows the summer in NYC to reach higher temperatures</li>
        
          <li>Week 36 in 2021 I spent in Iceland, therefore significantly lower temperatures</li>
        
          <li>End of November in 2019 I spent in Buenos Aires, therefore way higher temperatures</li>
        
          <li>December 2019 I spent in Columbus, Ohio, being the coldest week of the year</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Visual Crossing historic weather data, Swarm
      </span>

      <img src="graphs/screens/weather-temperature-max.png" class="image-link" alt="Maximal temperature each day of the year" onclick="enlargeImage('graphs/screens/weather-temperature-max.png', 'Maximal temperature each day of the year')" />

      <span class="graph-date">3 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Weather conditions per year</h3>
      <p class="graph-description">
        Historic weather data based on the location I was at on that day based on my Swarm check-ins.
      </p>

      <ul>
        
          <li>2019 I experienced more cloudy weather than the following years</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Visual Crossing historic weather data, Swarm
      </span>

      <img src="graphs/screens/weather-conditions.png" class="image-link" alt="Weather conditions per year" onclick="enlargeImage('graphs/screens/weather-conditions.png', 'Weather conditions per year')" />

      <span class="graph-date">3 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Alcoholic Beverages per day</h3>
      <p class="graph-description">
        Alcohol drinks per day. Days with no data are rendered as white
      </p>

      <ul>
        
          <li>Unless there are social obligations, or there is a party, I usually drink 0 alcoholic drinks</li>
        
          <li>Friday and Saturday nights are clearly visible on those graphs</li>
        
          <li>2021 and summer/winter of 2019 also show the Wednesday night party in Vienna</li>
        
          <li>Q2 and Q4 2020 clearly show the COVID lockdowns, as well as Q2 2021</li>
        
          <li>Summer of 2021 all bars and dance clubs were open in Vienna</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/manual-alcohol-intake.png" class="image-link" alt="Alcoholic Beverages per day" onclick="enlargeImage('graphs/screens/manual-alcohol-intake.png', 'Alcoholic Beverages per day')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Workouts in the gym</h3>
      <p class="graph-description">
        Each green square represents a strength-workout in the gym, I try my best to purchase day passes at gyms while traveling
      </p>

      <ul>
        
          <li>During the first lockdown in Q2 2020 I didn't have access to a gym, and didn't track home-workouts</li>
        
          <li>In 2021 I tend to work out less often on Sunday, the day I visit my family's place</li>
        
          <li>In Q4 2021 I had a cold for a longer time</li>
        
          <li>I went from ~50 workouts per year in 2014/2015 to ~200 per year in 2018 - 2021</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/manual-gym-visits.png" class="image-link" alt="Workouts in the gym" onclick="enlargeImage('graphs/screens/manual-gym-visits.png', 'Workouts in the gym')" />

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    

    <div class="graphs-entry">
      <h3>Living Style</h3>
      <p class="graph-description">
        From late 2017 to early 2020 I lived without a permanent home address, staying at various Airbnbs or taking over a few weeks of a lease from a friend
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/manual-living-style-years.png" class="image-link" alt="Living Style" onclick="enlargeImage('graphs/screens/manual-living-style-years.png', 'Living Style')" />

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
</div>

<div id="enlargedImageContainer" onclick="dismissImage()">
  <a target="_blank" id="enlargedImageLink">
    <img id="enlargedImage" />
  </a>
  <p id="enlargedImageTitle"></p>
</div>

<script type="text/javascript">
  function enlargeImage(img, title) {
    document.getElementById("enlargedImageContainer").style.display = "block";
    document.getElementById("enlargedImage").src = img;
    document.getElementById("enlargedImageLink").href = img;
    document.getElementById("enlargedImageTitle").innerHTML = title;
  }
  function dismissImage() {
    document.getElementById("enlargedImageContainer").style.display = "none";
  }

  window.addEventListener("keyup", function(e) {
    if (e.keyCode == 27) { // ESC
      dismissImage()
      return true;
    }
  }, false);
</script>

<style type="text/css">
  #graphs-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
    margin-top: 30px;
  }
  #enlargedImageContainer {
    position: fixed;
    display: none;
    z-index: 100;
    top: 0;
    cursor: pointer;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.8);
    height: 100%%;
    width: 100%%;
    text-align: center;
    padding-top: 40px;
  }
  #enlargedImage {
    background-color: green;
    object-fit: contain;
    max-height: calc(100% - 80px);
    max-width: 1200px;
  }
  @media (max-width: 1200px) {
    #enlargedImage {
      max-width: 100%;
      max-height: 100%;
    }
  }
  #enlargedImageTitle {
    color: white;
    font-size: 30px;
    font-weight: bold;
    margin-top: 20px;
  }
  .graphs-entry {
    max-width: 470px;
    margin: 10px;
    border: 2px solid #e4e7ef;
    border-radius: 9px;
    padding: 20px;
  }
  .graphs-entry > ul > li {
    color: #555;
  }
  .graphs-entry > h3 {
    font-size: 140%;
  }
  .graph-description {
    color: #555;
  }
  .graph-sources-header {
    color: #555;
    font-weight: bold;
  }
  .graph-sources {
    color: #777;
  }
  .graph-date {
    float: right;
    color: #777;
    margin-top: 10px;
    font-size: 75%;
    margin-bottom: -10px;
  }
  .image-link {
    padding-top: 10px;
    cursor: pointer;
  }

  /* Real-Time Dashboard UI */
  #mapsContainer {
    width: 100%;
    height: 'auto';
    position: absolute;
    top: 0px;
    left: 0px;
    z-index: -1;
  }
  #mapsMenuBannerCover {
    height: 90px;
    border-bottom: 2px solid #e4e7ef;
    background-color: rgba(255, 255, 255, 0.9);
    width: 100%;
    position: absolute;
    top: 0px;
    z-index: 2;
  }
  #currentLocationMap {
    width: 100%;
    background-position: center !important;
    background-size: cover !important;
    height: 350px;
  }
  #mapsContainerCover {
    height: 320px;
  }
  #storyProfilePicture {
    width: 128px;
    height: 128px;
    border-radius: 70px;
    cursor: pointer;
    border: 4px solid #fff;
  }
  #story-available {
    margin-left: auto;
    margin-right: auto;
    left: 0;
    right: 0;
    position: absolute;
    top: 280px;
    z-index: 10 !important;
  }
  #realTimeDataDiv {
    width: 100%;
    text-align: center;
    display: none;
    border-bottom: 2px solid #e4e7ef;
    margin-bottom: 25px;
    padding-bottom: 10px;
    margin-top: -33px;
  }
  #realTimeDataDiv > p > span.span-value {
    color: #666;
    font-size: 90%;
  }
  .highlighted {
    font-weight: normal;
    background-color: rgba(255, 255, 0, 0.35);
    padding: 5px;
    margin-left: -5px;
  }
  .food-overview > span {
    margin: 0 30px;
  }
  #food-container {
    margin-bottom: 20px;
  }
</style>
