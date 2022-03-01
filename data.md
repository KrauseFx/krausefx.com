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
  function daysOrHoursAgo(date) {
    if (daysAgo(date) == "today") {
      const hours = Math.floor((Date.now() - date.getTime()) / (1000 * 3600));
      if (hours == 1) { return "1 hour ago"; }
      else if (hours < 1) { return "less than an hour ago"; }
      else { return hours + " hours ago"; }
    } else {
      return daysAgo(date);
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
      "<span class='highlighted'>" + otherFxLifeData["sleepDurationWithings"]["value"] + " hours</span>tonight"
    document.getElementById("last-workout").innerHTML = daysAgo(new Date(otherFxLifeData["gym"]["time"]))
    document.getElementById("last-meditated").innerHTML = daysAgo(new Date(otherFxLifeData["meditated"]["time"]))
    document.getElementById("data-points").innerHTML = otherFxLifeData["totalAmountOfEntries"]["value"].toLocaleString()
    document.getElementById("data-entries-count").innerHTML = otherFxLifeData["totalAmountOfEntries"]["value"].toLocaleString()


    // Git Details
    document.getElementById("git-time-ago").innerHTML = daysOrHoursAgo(new Date(data["lastCommitTimestamp"]))
    document.getElementById("git-link").href = data["lastCommitLink"]
    document.getElementById("git-link").innerHTML = data["lastCommitMessage"]
    document.getElementById("git-repo-link").href = "https://github.com/" + data["lastCommitRepo"]
    document.getElementById("git-repo-link").innerHTML = data["lastCommitRepo"]

    // Mood
    document.getElementById("current-feeling").innerHTML = data["currentMoodLevel"] + " " + data["currentMoodEmoji"]
    document.getElementById("mood-hours-ago").innerHTML = "(" + data["currentMoodRelativeTime"] + ")"

    // Render food data (if available)
    if (data["todaysMacros"]["kcal"] > 0) {
      document.getElementById("todaysMacros-kcal").innerHTML = data["todaysMacros"]["kcal"] + " kcal"
      const totalKcal = otherFxLifeData["macrosCarbs"]["value"] * 4 + otherFxLifeData["macrosProtein"]["value"] * 4 + otherFxLifeData["macrosFat"]["value"] * 9;
      document.getElementById("total-kcal").innerHTML = totalKcal

      document.getElementById("todaysMacros-carbs").innerHTML = data.todaysMacros.carbs + "g carbs"
      document.getElementById("todaysMacros-protein").innerHTML = data.todaysMacros.protein + "g protein"
      document.getElementById("todaysMacros-fat").innerHTML = data.todaysMacros.fat + "g fat"

      document.getElementById("macrosCarbs-value").innerHTML = data.otherFxLifeData["macrosCarbs"]["value"]
      document.getElementById("macrosProtein-value").innerHTML = data.otherFxLifeData["macrosProtein"]["value"]
      document.getElementById("macrosFat-value").innerHTML = data.otherFxLifeData["macrosFat"]["value"]


      document.getElementById("todaysMacros-kcal-bar-inner").style.width = Math.min(100, Math.round((data["todaysMacros"]["kcal"] / totalKcal) * 100)) + "%"
      document.getElementById("todaysMacros-protein-bar-inner").style.width = Math.min(100, Math.round((data.todaysMacros.protein / data.otherFxLifeData["macrosProtein"]["value"]) * 100)) + "%"
      document.getElementById("todaysMacros-carbs-bar-inner").style.width = Math.min(100, Math.round((data.todaysMacros.carbs / data.otherFxLifeData["macrosCarbs"]["value"]) * 100)) + "%"
      document.getElementById("todaysMacros-fat-bar-inner").style.width = Math.min(100, Math.round((data.todaysMacros.fat / data.otherFxLifeData["macrosFat"]["value"]) * 100)) + "%"

      // Turn the bars red when too high
      if (data.todaysMacros.protein > data.otherFxLifeData["macrosProtein"]["value"]) {
        document.getElementById("todaysMacros-protein-bar-inner").style.background = "red";
      }
      if (data.todaysMacros.carbs > data.otherFxLifeData["macrosCarbs"]["value"]) {
        document.getElementById("todaysMacros-carbs-bar-inner").style.background = "red";
      }
      if (data.todaysMacros.fat > data.otherFxLifeData["macrosFat"]["value"]) {
        document.getElementById("todaysMacros-fat-bar-inner").style.background = "red";
      }
      if (data["todaysMacros"]["kcal"] > totalKcal) {
        document.getElementById("todaysMacros-kcal-bar-inner").style.background = "red";
      }

      // Render the food list
      let foodEntriesTable = document.getElementById("foodEntriesTable")
      for (let i = 0; i < data.todaysFoodItems.length; i++) {
        let foodItem = data.todaysFoodItems[i]
        let row = document.createElement("tr")
        row.className = i >= 3 ? "hidden-food" : ""
        row.style.display = i >= 3 ? "none" : ""
        const amount = foodItem.amount.split("/")[0] // Sometimes mfp has weird slashes, with the units ending up too long
        row.innerHTML = "<td>" + foodItem.name + "</td><td>" + amount + "</td>"
        foodEntriesTable.appendChild(row)
      }
      if (data.todaysFoodItems.length > 3) {
        let row = document.createElement("tr")
        row.className = "show-more-food"
        row.innerHTML = "<td colspan='2'><a onclick='toggleFood()' id='show-all-food-a'>Show all food entries</a></td>"
        foodEntriesTable.appendChild(row)
      }
    } else {
      document.getElementById("food-container").style.display = "none"
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
  function toggleFood() {
    // Iterate over all `hidden-food` rows and toggle their display
    let rows = document.getElementsByClassName("hidden-food")
    for (let i = 0; i < rows.length; i++) {
      rows[i].style.display = rows[i].style.display == "none" ? "table-row" : "none"
    }
    const a = document.getElementById("show-all-food-a")
    a.innerHTML = a.innerHTML == "Show all food entries" ? "Hide food entries" : "Show all food entries"
  }
</script>

<div id="mapsContainer">
  <div id="mapsMenuBannerCover"></div>
  <img id="currentLocationMap">
</div>
<div id="story-available" class="story-not-available">
  <img id="storyProfilePicture" src="assets/FelixKrauseCropped.jpg" onclick="showStories()" />
</div>
<div id="mapsContainerCover"></div>

<div id="realTimeDataDiv">
  <h3 id="currentCityContainer">Felix is currently in <b id="currentCityB" class="highlighted"></b></h3>
  <h3 id="isMovingContainer">Felix is currently heading to <b id="nextCityB" class="highlighted"></b></h3>
  <h4 id="nextCityContainer">Leaving for <span id="nextCityText"></span> <span id="nextCityTime"></span></h4>
  <hr />
  <h3 id="feels-h">Felix feels <span class="highlighted" id="current-feeling"></span> <span id="mood-hours-ago" class="ago-subtle"></span></h3>
  <hr />

  <div id="food-container">
    <h3>Felix ate today</h3>
    <div class="food-overview">
      <div>
        <span class="highlighted" id="todaysMacros-kcal"></span> of <span id="total-kcal"></span> kcal
        <span class="macro-bar-outer">
          <div class="macro-bar-inner" id="todaysMacros-kcal-bar-inner"></div>
        </span>
      </div>
      <div>
        <span class="highlighted" id="todaysMacros-carbs"></span> of <span id="macrosCarbs-value"></span>g
        <span class="macro-bar-outer">
          <div class="macro-bar-inner" id="todaysMacros-carbs-bar-inner"></div>
        </span>
      </div>
      <div>
        <span class="highlighted" id="todaysMacros-protein"></span> of <span id="macrosProtein-value"></span>g
        <span class="macro-bar-outer">
          <div class="macro-bar-inner" id="todaysMacros-protein-bar-inner"></div>
        </span>
      </div>
      <div>
        <span class="highlighted" id="todaysMacros-fat"></span> of <span id="macrosFat-value"></span>g
        <span class="macro-bar-outer">
          <div class="macro-bar-inner" id="todaysMacros-fat-bar-inner"></div>
        </span>
      </div>
    </div>

    <div id="foodEntries">
      <table id="foodEntriesTable" cellspacing="0" cellpadding="0">
      </table>
    </div>
    <hr />
  </div>

  <div id="table-container">
    <table id="real-time-table" cellspacing="0" cellpadding="0">
      <tr>
        <td>Weight</td>
        <td>
          <span id="current-weight"></span>
          <span id="current-weight-time" class="ago-subtle"></span>
        </td>
      </tr>
      <tr>
        <td>Slept</td>
        <td id="current-sleep-duration"></td>
      </tr>
      <tr>
        <td>Last workout</td>
        <td><span class="highlighted" id="last-workout" /></td>
      </tr>
      <tr>
        <td>Last meditated</td>
        <td><span class="highlighted" id="last-meditated" /></td>
      </tr>
      <tr>
        <td>Number of data entries</td>
        <td><span class="highlighted" id="data-entries-count" /></td>
      </tr>
    </table>
  </div>

  <hr />
  <p style="margin-top: -25px;" class="git-footnote">Last code commit: <span id="git-time-ago" class="git-footnote" /></p>
  <h3 id="git-header">
    <a target="_blank" href="" id="git-link"></a>
  </h3>
  <p class="git-footnote">on GitHub repo <a target="_blank" href="" id="git-repo-link"></a></p>
  <hr />

  <p style='text-align: center; margin-top: -10px;'><a href="https://whereisfelix.today">More real-time data on WhereIsFelix.today</a></p>
</div>

<h1>My whole life in a single database</h1>

As part of the [FxLifeSheet project](https://github.com/KrauseFx/FxLifeSheet) I've started back in 2019, I started collecting all kinds of metrics about my life.
Every single day for the last 2.5 years I've tracked over 100 different data types of my life.

I haven't yet had the time to analyze all the outcomes, but felt like I already have some very interesting graphs I'd like to share here.

Currently, I have <b><span id="data-points">~380,000</span> data points</b>, with the biggest data sources being:

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
        All flights taken within the last 7 years, tracked using Foursquare Swarm, analyzed by <a href='https://www.jetlovers.com/' target='_blank'>JetLovers</a>.
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
        All flights taken within the last 7 years, tracked using Foursquare Swarm, analyzed by <a href='https://www.jetlovers.com/' target='_blank'>JetLovers</a>.
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
      <h3>My life in weeks</h3>
      <p class="graph-description">
        Inspired by Your Life in Weeks by WaitButWhy, I use Google Sheets to visualize every week of my life, with little notes on what city/country I was at, and other life events that have happened.
      </p>

      <ul>
        
          <li>The first 14 years I didn't really get done much</li>
        
          <li>Taking a few weeks (or even months) off between jobs (if you have the possibility) is one of the best decisions I've made</li>
        
          <li>Yellow area indicates no active full-time employment</li>
        
          <li>Shades of blue indicate my full-time employments</li>
        
          <li>Shades of red is formal education</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/life-in-weeks.png" class="image-link" alt="My life in weeks" onclick="enlargeImage('graphs/screens/life-in-weeks.png', 'My life in weeks')" />

      <span class="graph-date">27.5 years of data - Last updated on 2022-02-24</span>
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
        
          <li>Days in Summer are warmer than days in Winter</li>
        
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
      <h3>Location History</h3>
      <p class="graph-description">
        Every Swarm check-in visualized on a map. Only areas where I've had multiple check-ins are rendered.
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <img src="graphs/screens/map-world-overview.jpg" class="image-link" alt="Location History" onclick="enlargeImage('graphs/screens/map-world-overview.jpg', 'Location History')" />

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Location History</h3>
      <p class="graph-description">
        Every Swarm check-in over the last 7 years visualized on a map, including the actual trip (flight, drive, etc.)
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <img src="graphs/screens/map-world-trip.jpg" class="image-link" alt="Location History" onclick="enlargeImage('graphs/screens/map-world-trip.jpg', 'Location History')" />

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Location History - Cities</h3>
      <p class="graph-description">
        Every Swarm check-in over the last 7 years visualized, zoomed in
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <img src="graphs/screens/map-combined.jpg" class="image-link" alt="Location History - Cities" onclick="enlargeImage('graphs/screens/map-combined.jpg', 'Location History - Cities')" />

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Happy Days</h3>
      <p class="graph-description">
        Bucketing all days, by the days at which I was above average happy (excited, pumped). On days where I was happy:
      </p>

      <ul>
        
          <li>50% more likely to have pushed my comfort zone</li>
        
          <li>45% more likely to have medidated that day</li>
        
          <li>40% more likely to feel good about the current direction in life, and working towards it</li>
        
          <li>15% warmer than the average</li>
        
          <li>15% less time on social media</li>
        
          <li>30% less time spent watching TV</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/mood-happy-days.png" class="image-link" alt="Happy Days" onclick="enlargeImage('graphs/screens/mood-happy-days.png', 'Happy Days')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Average daily steps over time</h3>
      <p class="graph-description">
        Measured through the iPhone's Health app, which stayed the same over the last 8 years, while my smart watches have changed over time
      </p>

      <ul>
        
          <li>I walk more than twice as much when I'm in New York City, compared to any other city</li>
        
          <li>In NYC I had the general rule of thumb to walk instead of taking public transit whenever it's less than 40 minutes. I used that time to call friends & family, or listen to audio books</li>
        
          <li>Vienna is very walkable, however also has excellent public transit with subway trains coming every 3-5 minutes causing me to walk less</li>
        
          <li>San Francisco was always scary to walk</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Apple Health
      </span>

      <img src="graphs/screens/daily-steps.png" class="image-link" alt="Average daily steps over time" onclick="enlargeImage('graphs/screens/daily-steps.png', 'Average daily steps over time')" />

      <span class="graph-date">8 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Number of Swarm checkins over time</h3>
      <p class="graph-description">
        Number of Swarm checkins on each quarter over the last 10 years. I didn't use Foursquare Swarm as seriously before 2015. Once I moved to San Francisco in Q3 2015 I started my habit of checking into every POI I visit
      </p>

      <ul>
        
          <li>Q3 2015 I moved to San Francisco, however I couldn't check-in yet, since my move was a secret until the official announced at the Twitter Flight conference</li>
        
          <li>Q2 2020 clearly shows the impact of COVID with Q3 already being open in Austria</li>
        
          <li>Q3 2021 the vaccine was already widely available and I was able to travel/visit more again</li>
        
          <li>My time in New York was the most active when it comes to check-ins. When I'm in NYC, I tend to eat/drink out more, and grab to-go food, which I do way less in Vienna</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <img src="graphs/screens/swarm-number-of-checkins.png" class="image-link" alt="Number of Swarm checkins over time" onclick="enlargeImage('graphs/screens/swarm-number-of-checkins.png', 'Number of Swarm checkins over time')" />

      <span class="graph-date">10 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Days in full lockdown</h3>
      <p class="graph-description">
        Number of days per year that I've spent in full lockdown, meaning closed restaurants, bars and non-essential stores.
      </p>

      <ul>
        
          <li>Parts of the Austrian lockdown I've spent already vaccinated in the US</li>
        
          <li>2021 I spent more days in a full lockdown than in 2020, even with vaccines available</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/lockdown-days.png" class="image-link" alt="Days in full lockdown" onclick="enlargeImage('graphs/screens/lockdown-days.png', 'Days in full lockdown')" />

      <span class="graph-date">3 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Correlation between weight and resting heart rate</h3>
      <p class="graph-description">
        This graph clearly shows the correlation between my body weight, and my sleeping/resting heart rate. The resting heart rate is measured by the <a href='https://www.withings.com/us/en/scanwatch' target='_blank'>Withings Scanwatch</a> while sleeping, and basically indicates how hard your heart has to work while not being active. Generally the lower the resting heart rate, the better.
      </p>

      <ul>
        
          <li>I started my lean bulk (controlled weight gain combined with 5 workouts a week) in August 2020</li>
        
          <li>The resting rate rate grew from 58bpm to 67bpm from August 2020 to March 2021 (~8 months) with a weight gain of 8.5kg (19lbs)</li>
        
          <li>The spike in resting heart rate in July, August 2020 was due to bars and nightclubs opening up again in Austria</li>
        
          <li>After a night of drinking, my sleeping heart rate is about 50% - 75% higher than after a night without any alcohol</li>
        
          <li>The spike in resting heart rate in October/November/December 2021 was due to having bronchitis and a cold/flu, not getting correct treatment early enough</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Withings Scanwatch, Withings Scale
      </span>

      <img src="graphs/screens/weight-sleeping-hr.png" class="image-link" alt="Correlation between weight and resting heart rate" onclick="enlargeImage('graphs/screens/weight-sleeping-hr.png', 'Correlation between weight and resting heart rate')" />

      <span class="graph-date">1.5 years of data - Last updated on 2022-02-09</span>
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
        From late 2017 to early 2020 I lived without a permanent home address as a <a href='/blog/one-year-nomad' target='_blank'>digital nomad</a>, staying at various Airbnbs or taking over a few weeks of a lease from a friend
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
  
    
    
    

    <div class="graphs-entry">
      <h3>How does high temperature affect my life?</h3>
      <p class="graph-description">
        On days with a maximum temperature of more than 26 Celsius (78.8 Fahrenheit), the following other factors were affected
      </p>

      <ul>
        
          <li>80% more likely to take a freezing cold shower</li>
        
          <li>37% more likely to hit the gym</li>
        
          <li>26% more daily steps</li>
        
          <li>20% more alcoholic beverages</li>
        
          <li>15% more likely to go out in the evening</li>
        
          <li>13% less likely to take a nap</li>
        
          <li>20% less time in a code editor</li>
        
          <li>21% less likely to be sick</li>
        
          <li>Generally lower stress/anxiety levels</li>
        
          <li>100% less likely to be in a COVID related lockdown</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Visual Crossing historic weather data, Manually
      </span>

      <img src="graphs/screens/weather-temperature-buckets.png" class="image-link" alt="How does high temperature affect my life?" onclick="enlargeImage('graphs/screens/weather-temperature-buckets.png', 'How does high temperature affect my life?')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>How healthy was I over the years?</h3>
      <p class="graph-description">
        Every day I answered the question on how healthy I feel, whereas the yellow color indicates that I felt a little under the weather, not sick per-se. Red means I was sick and had to stay home. Green means I felt energized and healthy
      </p>

      <ul>
        
          <li>During the COVID lockdowns I tend to stay healthier</li>
        
          <li>Usually during excessive traveling I get sick (cold/flu)</li>
        
          <li>Q4 2021 I had bronchitis, however didn't know about it at the time and didn't get proper treatment</li>
        
          <li>Overall I'm quite prone to getting sick (cold/flu)</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/healthy.png" class="image-link" alt="How healthy was I over the years?" onclick="enlargeImage('graphs/screens/healthy.png', 'How healthy was I over the years?')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>How does longer sleep duration affect my day?</h3>
      <p class="graph-description">
        On days where I had a total sleep duration of more than 8.5 hours, the following other factors were affected
      </p>

      <ul>
        
          <li>65% more likely to have cold symptons</li>
        
          <li>60% more likely to have headache</li>
        
          <li>40% more social media usage</li>
        
          <li>30% more likely to be a rainy day</li>
        
          <li>20% more likely to be a weekend</li>
        
          <li>15% more likely to have bad/stressful dreams</li>
        
          <li>12% colder weather on average</li>
        
          <li>20% less likely to hit the gym that day</li>
        
          <li>24% less energy</li>
        
          <li>Overall, it's clear that days with a longer sleep duration tend to be significantly worse days. This is most likely due to the fact that I try to sleep a maximum of 8 hours, and if I actually sleep more than usually because I'm not feeling too well, or even sick</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Withings Scan Watch, Manually
      </span>

      <img src="graphs/screens/sleep-duration-buckets.png" class="image-link" alt="How does longer sleep duration affect my day?" onclick="enlargeImage('graphs/screens/sleep-duration-buckets.png', 'How does longer sleep duration affect my day?')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Days with more than 15,000 steps</h3>
      <p class="graph-description">
        On days where I walked more than 15,000 steps (I walked an average of 9200 steps a day the last 3 years)
      </p>

      <ul>
        
          <li>60% more time spent with friends in real-life</li>
        
          <li>50% warmer temperature that day</li>
        
          <li>40% more likely to socialize with friends before going to sleep</li>
        
          <li>35% more likely to be a weekend day</li>
        
          <li>20% less likely to take a nap that day</li>
        
          <li>30% less likely to correctly track my macros (food)</li>
        
          <li>30% less time spent in work calls/meetings</li>
        
          <li>30% less anxious</li>
        
          <li>40% less likely to meditate</li>
        
          <li>40% less time spent writing code</li>
        
          <li>40% less likely to be a rainy day</li>
        
          <li>50% less time spent watching TV</li>
        
          <li>95% less likely to be a day in lockdown</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Apple Health
      </span>

      <img src="graphs/screens/daily-steps-buckets.png" class="image-link" alt="Days with more than 15,000 steps" onclick="enlargeImage('graphs/screens/daily-steps-buckets.png', 'Days with more than 15,000 steps')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Days where I tracked my mood to be very excited/happy</h3>
      <p class="graph-description">
        On days where I tracked my mood to be very excited/happy, the following other factors were affected
      </p>

      <ul>
        
          <li>Significantly more likely to be a day where I went out of my comfort zone</li>
        
          <li>Significantly more likely to have medidated that day</li>
        
          <li>70% more likely to have taken a freezing cold shower</li>
        
          <li>60% more likely to have worked on interrelated technical challenges</li>
        
          <li>60% more time spent reading or listening to audio books</li>
        
          <li>50% more likely to have learned something new that day</li>
        
          <li>50% more excited about what's ahead in the future</li>
        
          <li>40% more likely to have hit the gym that day</li>
        
          <li>30% more likely to have eaten veggies</li>
        
          <li>25% warmer</li>
        
          <li>20% more computer use</li>
        
          <li>25% less alcoholic beverages</li>
        
          <li>35% less likely to be a weekend</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/happy-mood-entries-buckets.png" class="image-link" alt="Days where I tracked my mood to be very excited/happy" onclick="enlargeImage('graphs/screens/happy-mood-entries-buckets.png', 'Days where I tracked my mood to be very excited/happy')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Days with more than 4 alcoholic drinks</h3>
      <p class="graph-description">
        On days where I had more than 4 alcoholic beverages, the following other factors were affected
      </p>

      <ul>
        
          <li>21x more likely to dance</li>
        
          <li>80% more likely to take a nap</li>
        
          <li>60% more time spent with friends</li>
        
          <li>40% warmer</li>
        
          <li>25% more steps</li>
        
          <li>10% higher sleeping heart rate that night</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/alcoholic-beverages-buckets.png" class="image-link" alt="Days with more than 4 alcoholic drinks" onclick="enlargeImage('graphs/screens/alcoholic-beverages-buckets.png', 'Days with more than 4 alcoholic drinks')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Weight history of 8 years</h3>
      <p class="graph-description">
        Historic weight, clearly showing the various bulks and cuts I've made over the years. Only the last 5 years are rendered in this graph, with the last 3 years having tracked my weight way more frequently.
      </p>

      <ul>
        
          <li>Lowest recorded weight was 69kg/152lbs in 2014 (age 20)</li>
        
          <li>Highest recorded weight was 89.8kg/198lbs in 2021 (age 27)</li>
        
          <li>Meaning, on the same height of 193cm (6"4), I gained 20kg (44lbs) while staying under 12% body fat</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Withings Scale
      </span>

      <img src="graphs/screens/weight-graph-1.png" class="image-link" alt="Weight history of 8 years" onclick="enlargeImage('graphs/screens/weight-graph-1.png', 'Weight history of 8 years')" />

      <span class="graph-date">9 years of data - Last updated on 2022-02-17</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Food tracking - Macros</h3>
      <p class="graph-description">
        On weeks where I have a routine (not traveling), I track most my meals. Whenever I scale my food, I try to guess the weight before to become better at estimating portion sizes.
      </p>

      <ul>
        
          <li>Tracking macros precisely is the best way to lose/gain weight at a controlled and healthy speed</li>
        
          <li>When I first started tracking macros, additionally to already working out regularly, is when I saw by far the best results</li>
        
          <li>It takes a lot of energy to be consistent, but it's worth it, and it will make you feel good (e.g. feeling good about using a spoon to eat plain Nutella if you have the macros left)</li>
        
          <li>Gaining and losing weight is pretty much math, if you track your macros and weight, and you have almost full control over it</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        MyFitnessPal
      </span>

      <img src="graphs/screens/macros.png" class="image-link" alt="Food tracking - Macros" onclick="enlargeImage('graphs/screens/macros.png', 'Food tracking - Macros')" />

      <span class="graph-date">4 years of data - Last updated on 2022-02-17</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Bulk & Cut Phase visualized</h3>
      <p class="graph-description">
        I usually have slow bulk & cut phases, where I gain and lose weight at a controlled speed, combined with tracking my meals.
      </p>

      <ul>
        
          <li>I only track my weight if I didn't drink alcohol the night before, and after getting a full night's sleep, since otherwise the weight fluctuates a lot</li>
        
          <li>Generally, you can pretty much calculate your weight on a certain date, if you consistently track your meals, and correctly calculated your macros</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Withings Scale, weightgrapher.com
      </span>

      <img src="graphs/screens/weight-graph-2.png" class="image-link" alt="Bulk & Cut Phase visualized" onclick="enlargeImage('graphs/screens/weight-graph-2.png', 'Bulk & Cut Phase visualized')" />

      <span class="graph-date">1 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Air Quality in various rooms</h3>
      <p class="graph-description">
        I used the <a href='https://www.getawair.com/products/element' target='_blank'>Awair Element</a> at home in Vienna, in every room over multiple days
      </p>

      <ul>
        
          <li>Overall, the air quality in Vienna is excellent. Just opening the windows for a few minutes is enough to get a 100% air score</li>
        
          <li>The smaller the room, the more difficult it is to keep the CO2 levels low</li>
        
          <li>The only room where I'm still struggling to keep the CO2 levels low is my bedroom, which is small, and doesn't offer any ventilation. Keeping the doors open mostly solves the high CO2 levels, however comes with other downsides like more light</li>
        
          <li>Probably obvious for many, but I didn't realize ACs don't transport any air into the room, but just moves it around</li>
        
          <li>Opening the windows for a longer time in winter will cause low humidity and low temperatures, so it's often not a good option</li>
        
          <li>I didn't learn anything meaningful from the 'Chemicals' and 'PM2.5' graphs</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Awair
      </span>

      <img src="graphs/screens/air-quality.png" class="image-link" alt="Air Quality in various rooms" onclick="enlargeImage('graphs/screens/air-quality.png', 'Air Quality in various rooms')" />

      <span class="graph-date">1 years of data - Last updated on 2022-02-09</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Investment Distribution</h3>
      <p class="graph-description">
        Every second week I track my current investments and cash positions. As part of this project, it tells me how to most efficiently re-balance my investments when they're off, while also minimizing the occuring fees
      </p>

      <ul>
        
          <li>I have a burndown chart, which visualizes how my networth would grow/drop over time in various scenarios</li>
        
          <li>I have a graph that ensures I have the right target distribution of high, medium and low risk positions</li>
        
          <li>Whenever I take on a potential new project/role, I simulate the various outcome scenarios over the next few years</li>
        
          <li>For obvious reasons, I can't include more of the graphs and simulations I have available</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <img src="graphs/screens/money-distribution.png" class="image-link" alt="Investment Distribution" onclick="enlargeImage('graphs/screens/money-distribution.png', 'Investment Distribution')" />

      <span class="graph-date">8 years of data - Last updated on 2022-02-09</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Annual money flow</h3>
      <p class="graph-description">
        Inspired by the Reddit commnunity <a href='https://old.reddit.com/r/PFPorn' target='_blank'>/r/PFPorn</a>, I create an annual money flow chart to clearly see how much money I earn, where I'm spending it, and how much I'm saving. The chart below isn't mine (for privacy reasons), but just an example I created.
      </p>

      <ul>
        
          <li>Not owning an apartment, and [living in Airbnbs as a nomad](/blog/one-year-nomad) I actually spent less money. This was due to not having to buy any furniture, appliances, etc. but also because the number of items I could by for myself was limited, as everything was limited to be able to fit into 2 suitcases.</li>
        
          <li>Misc. subscriptions/expenses are adding up quickly</li>
        
          <li>Having an End-Of-Year summary from your credit card provider, and always using your card when possible, is a great way to get those numbers</li>
        
          <li>Creating this chart is still a lot of work, if you want to also consider getting reimbursed, or expenses you've covered for a group (e.g. booked a larger Airbnb)</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Chase Credit Card Year Summary, sankeymatic.com, Manually
      </span>

      <img src="graphs/screens/money-flow.png" class="image-link" alt="Annual money flow" onclick="enlargeImage('graphs/screens/money-flow.png', 'Annual money flow')" />

      <span class="graph-date">5 years of data - Last updated on 2022-02-09</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>Rescue Time Computer Usage Categories</h3>
      <p class="graph-description">
        Using RescueTime, I tracked my exact computer usage, and the categories of activities in which I spend time with.
      </p>

      <ul>
        
          <li>Over the last 7 years, I went from spending around 10% of my time with communication & scheduling, to around 30%</li>
        
          <li>Over the last 7 years, I went from spending around 33% of my time with software development, to less than 10% (now that I'm not currently full-time employed)</li>
        
          <li>All other categories stayed pretty much on the same ratio over the last 7 years</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        RescueTime
      </span>

      <img src="graphs/screens/rescue-time-usage-categories.png" class="image-link" alt="Rescue Time Computer Usage Categories" onclick="enlargeImage('graphs/screens/rescue-time-usage-categories.png', 'Rescue Time Computer Usage Categories')" />

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>How does Winter affect my life?</h3>
      <p class="graph-description">
        Winter (being from 21st Dec to 20th March) has the following effects on my life:
      </p>

      <ul>
        
          <li>Online shopping time going up by 100%, most likely due to the last Winters having spent in lockdown</li>
        
          <li>Chances of having cold symptons goes up ~45%</li>
        
          <li>35% less likely to take a freezing cold shower</li>
        
          <li>You can generate significantly less solar energy in Winter :joke:</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manual
      </span>

      <img src="graphs/screens/season-winter.png" class="image-link" alt="How does Winter affect my life?" onclick="enlargeImage('graphs/screens/season-winter.png', 'How does Winter affect my life?')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>How does Summer affect my life?</h3>
      <p class="graph-description">
        Summer (being from 21st June to 23rd September) has the following effects on my life:
      </p>

      <ul>
        
          <li>Chances of taking a freezing cold shower goes up by 100%</li>
        
          <li>I walk 33% more steps in Summer</li>
        
          <li>30% more likely to hit the gym</li>
        
          <li>23% more alcoholic beverages</li>
        
          <li>20% less time spent reading news & opinions (as per RescueTime classifications)</li>
        
          <li>40% less likely to be sick</li>
        
          <li>40% less time spent on Entertainment on my computer (as per RescueTime classifications)</li>
        
          <li>30% less likely to have bad dreams</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manual
      </span>

      <img src="graphs/screens/season-summer.png" class="image-link" alt="How does Summer affect my life?" onclick="enlargeImage('graphs/screens/season-summer.png', 'How does Summer affect my life?')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry">
      <h3>What are weekends like?</h3>
      <p class="graph-description">
        Weekends for me naturally involve less work time, more going out, and social interactions, as well as visiting family memebers outside the city
      </p>

      <ul>
        
          <li>150% more computer time spent on "Entertainment", which is mostly coming from occasionally playing Factorio or Age Of Empires with friends at LAN-Party gatherings</li>
        
          <li>74% more time spent watching TV</li>
        
          <li>60% more time spent with friends IRL</li>
        
          <li>55% more dancing, when going out</li>
        
          <li>45% more likely to have a headache, due to drinking alcohol the night before</li>
        
          <li>25% less gym visits, mostly due to family gatherings and not being in the city</li>
        
          <li>45% less likely to properly track my macros/meals, mostly due to family gatherings and going out</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manual
      </span>

      <img src="graphs/screens/day-is-weekend.png" class="image-link" alt="What are weekends like?" onclick="enlargeImage('graphs/screens/day-is-weekend.png', 'What are weekends like?')" />

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
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
  .highlighted {
    font-weight: normal;
    background-color: rgba(255, 255, 0, 0.35);
    padding: 5px;
    margin-left: -5px;
  }
  #food-container {
    margin-bottom: 40px;
    margin-top: -20px;
  }
  #feels-h {
    margin-top: -10px;
    margin-bottom: 20px;
  }
  hr {
    border: 0;
    height: 1px;
    background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(40, 40, 40, 0.3), rgba(0, 0, 0, 0));
    margin-bottom: 35px;
    background-color: transparent !important;
  }
  .ago-subtle {
    color: #666;
    font-size: 14px;
  }
  #real-time-table {
    border: none;
  }
  #real-time-table > * > tr > td:first-child {
    text-align: right;
  }
  #table-container { 
    margin-top: 20px; 
    margin-left: auto; 
    margin-right: auto; 
    text-align: left; 
    width: 450px;
  }
  .git-footnote {
    text-align: center;
    margin-bottom: -6px;
    margin-top: -10px;
    color: #666;
    font-size: 14px;
  }
  #git-repo-link {
    text-decoration: none !important;
  }
  #git-header {
    margin-top: 10px;
    font-size: 25px;
    margin-bottom: 20px;
  }
  #git-header > a {
    color: #333 !important;
    font-weight: 400 !important;
    font-size: 90%;
  }
  @media screen and (max-width: 800px) {
    #current-weight-time {
      display: none;
    }
    #real-time-table > * > tr > td:first-child {
      width: 115px;
    }
  }
  @media screen and (max-width: 450px) {
    #real-time-table {
      max-width: 80%;
    }
  }
  .food-overview {
    line-height: 60px;
  }
  .food-overview > div {
    margin: 0 30px;
    display: inline;
    position: relative;
    text-align: center;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .macro-bar-outer {
    width: 110px;
    background-color: rgba(205, 205, 205, 0.5);
    height: 8px;
    border-radius: 5px;
    position: absolute;
    margin-top: 55px;
    margin-left: auto;
    margin-right: auto;
    left: 0;
    right: 0;
    text-align: center;
  }
  .macro-bar-inner {
    width: 0px;
    background-color: rgba(0, 220, 0, 1);
    height: 8px;
    border-radius: 5px;
  }
  #foodEntries {
    margin-top: 30px;
    width: 100%;
    text-align: center;
  }
  #foodEntriesTable {
    border: none;
    width: 430px;
    max-width: 100%;
    margin-left: auto;
    margin-right: auto;
    white-space: nowrap;
  }
  #foodEntriesTable > tr {
    background-color: rgba(255, 255, 255, 0.9) !important;
    font-size: 90%;
    line-height: 1.35;
  }
  #foodEntriesTable > tr > td {
    color: #669;
    padding: 9px 0 0;
    border: none;
    text-overflow: ellipsis;
    overflow: hidden;
  }
  #foodEntriesTable > tr > td:first-child {
    max-width: 270px;
  }
  #foodEntriesTable > tr > td:last-child {
    max-width: 80px;
    width: 80px;
  }
  .hidden-food {
    display: none;
  }
  #show-all-food-a {
    font-weight: bold;
    text-decoration: none;
    cursor: pointer !important;
  }
</style>
