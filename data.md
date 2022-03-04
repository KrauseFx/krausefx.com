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

    // Overview of data sources
    document.getElementById("h-rescuetime").innerHTML = otherFxLifeData["rescue_time"]["value"].toLocaleString()
    document.getElementById("h-swarm").innerHTML = otherFxLifeData["swarm"]["value"].toLocaleString()
    document.getElementById("h-manually").innerHTML = otherFxLifeData["manuallyEntered"]["value"].toLocaleString()
    document.getElementById("h-timeranges").innerHTML = otherFxLifeData["timeRanges"]["value"].toLocaleString()
    document.getElementById("h-weather").innerHTML = otherFxLifeData["weather"]["value"].toLocaleString()
    document.getElementById("h-health").innerHTML = otherFxLifeData["dailySteps"]["value"].toLocaleString()

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
</div>

<h1>My whole life in a single database</h1>

As part of the [FxLifeSheet project](https://github.com/KrauseFx/FxLifeSheet), I created back in 2019, I started collecting all kinds of metrics about my life.
Every single day for the last 2.5 years I tracked over 100 different data types - ranging from fitness & nutrition to social life, computer usage and weather.

Currently, I have <b><span id="data-points" class="highlighed">~380,000</span> data points</b>, with the biggest data sources being:

<table>
  <tr><th>Data Source</th><th>Number of data entries</th><th>Type of data</th></tr>
  <tr><td>RescueTime</td><td><span class="highlighted" id="h-rescuetime">149,466</span></td><td>Daily computer usage (which website, which apps)</td></tr>
  <tr><td>Foursquare Swarm</td><td><span class="highlighted" id="h-swarm">126,285</span></td><td>Location and POI data, places I've visited</td></tr>
  <tr><td>Manually entered</td><td><span class="highlighted" id="h-manually">67,031</span></td><td>Data about fitness, mood, social life, nutrition, energy levels, ...</td></tr>
  <tr><td>Manually entered time ranges</td><td><span class="highlighted" id="h-timeranges">19,273</span></td><td>Occupation, lockdown status, living setup</td></tr>
  <tr><td>Weather API</td><td><span class="highlighted" id="h-weather">15,442</span></td><td>Temperature, rain, sunlight, wind</td></tr>
  <tr><td>Apple Health</td><td><span class="highlighted" id="h-health">3,048</span></td><td>Steps data</td></tr>
</table>

I selected <span class="highlighted">41</span> graphs to show publicly on this page. For privacy reasons, and to prevent any any accidental data leaks, the graphs below are snapshots taken on a given day.



<div id="graphs-container">
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-number-of-entries">
      <h3>Number of data entries over time</h3>
      <p class="graph-description">
        Visualization of the number of data entries in <a href='https://github.com/KrauseFx/FxLifeSheet' target='_blank'>FxLifeSheet</a> over the last 10 years, and where the data came from.
      </p>

      <ul>
        
          <li>Before 2018, the only data used was <a href='https://rescuetime.com' target='_blank'>RescueTime</a> and <a href='https://swarmapp.com' target='_blank'>Swarm</a> location data</li>
        
          <li>Once I started the <a href='https://github.com/KrauseFx/FxLifeSheet' target='_blank'>FxLifeSheet project</a>, I manually tracked around 75 data entries every day, ranging from mood, sleep, to fitness inputs</li>
        
          <li>I was able to retrospectively fetch the historic weather data based on my location on a given day</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        
      </span>

      <div class="image-container">
        <img src="graphs/screens/number-of-entries.png" class="image-link" alt="Number of data entries over time" onclick="enlargeImage(this, 'graphs/screens/number-of-entries.png', 'Number of data entries over time')" />
      </div>

      <span class="graph-date">10 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-happy-mood-entries-buckets">
      <h3>Days where I tracked my mood to be happy & excited</h3>
      <p class="graph-description">
        On days where I tracked my mood to be "happy" & "excited", the following other factors of my life were affected
      </p>

      <ul>
        
          <li>50% more likely to have pushed my comfort zone</li>
        
          <li>44% more likely to have meditated that day</li>
        
          <li>33% more excited about what's ahead in the future</li>
        
          <li>31% more likely to drink alcohol that day (partys, good friends and such)</li>
        
          <li>28% more time spent reading or listening to audio books</li>
        
          <li>26% more likely to have worked on interrelated technical challenges</li>
        
          <li>26% warmer temperature that day</li>
        
          <li>20% more likely to have learned something new that day</li>
        
          <li>14% more likely to have eaten veggies</li>
        
          <li>45% less time spent in video & audio calls that day</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/happy-mood-entries-buckets.png" class="image-link" alt="Days where I tracked my mood to be happy & excited" onclick="enlargeImage(this, 'graphs/screens/happy-mood-entries-buckets.png', 'Days where I tracked my mood to be happy & excited')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-jetlovers-stats">
      <h3>Flying Stats - General</h3>
      <p class="graph-description">
        All flights taken within the last 7 years, tracked using Foursquare Swarm, analyzed by <a href='https://www.jetlovers.com/' target='_blank'>JetLovers</a>.
      </p>

      <ul>
        
          <li>The stats clearly show the impact of COVID starting 2020</li>
        
          <li>Sunday has been my "commute" day, flying between San Francisco, New York City and Vienna</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        JetLovers, Swarm
      </span>

      <div class="image-container">
        <img src="graphs/screens/jetlovers-stats.png" class="image-link" alt="Flying Stats - General" onclick="enlargeImage(this, 'graphs/screens/jetlovers-stats.png', 'Flying Stats - General')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-jetlovers-top">
      <h3>Flying Stats - Top</h3>
      <p class="graph-description">
        All flights taken within the last 7 years, tracked using Foursquare Swarm, analyzed by <a href='https://www.jetlovers.com/' target='_blank'>JetLovers</a>.
      </p>

      <ul>
        
          <li>Frankfurt - Vienna was the flight connecting me with most US airports</li>
        
          <li>Germany is high up on the list due to layovers, even though I didn't spend actually much time there</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        JetLovers, Swarm
      </span>

      <div class="image-container">
        <img src="graphs/screens/jetlovers-top.png" class="image-link" alt="Flying Stats - Top" onclick="enlargeImage(this, 'graphs/screens/jetlovers-top.png', 'Flying Stats - Top')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-life-in-weeks">
      <h3>My life in weeks</h3>
      <p class="graph-description">
        Inspired by <a href='https://waitbutwhy.com/2014/05/life-weeks.html' target='_blank'>Your Life in Weeks by WaitButWhy</a>, I use Google Sheets to visualize every week of my life, with little notes on what city/country I was at, and other life events that have happened.
      </p>

      <ul>
        
          <li>The first 14 years I didn't really get much done</li>
        
          <li>I can highly recommend taking a few weeks (or even months) off between jobs (if you have the possibility)</li>
        
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

      <div class="image-container">
        <img src="graphs/screens/life-in-weeks.png" class="image-link" alt="My life in weeks" onclick="enlargeImage(this, 'graphs/screens/life-in-weeks.png', 'My life in weeks')" />
      </div>

      <span class="graph-date">27.5 years of data - Last updated on 2022-02-24</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-daily-steps">
      <h3>Average daily steps over time</h3>
      <p class="graph-description">
        Average daily steps measured through the iPhone's Apple Health app. I decided against using SmartWatch data for steps, as SmartWatches have changed over the last 8 years.
      </p>

      <ul>
        
          <li>I walked a total of <span class='highlighted'>22,830,860</span> steps over last 8 years</li>
        
          <li>I walk more than twice as much when I'm in New York, compared to any other city</li>
        
          <li>In NYC I had the general rule of thumb to walk instead of taking public transit whenever it's less than 40 minutes. I used that time to call friends & family, or listen to audio books</li>
        
          <li>Although Vienna is very walkable, the excellent public transit system with subway trains coming every 3-5 minutes, has caused me to walk less</li>
        
          <li>San Francisco was always scary to walk</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Apple Health
      </span>

      <div class="image-container">
        <img src="graphs/screens/daily-steps.png" class="image-link" alt="Average daily steps over time" onclick="enlargeImage(this, 'graphs/screens/daily-steps.png', 'Average daily steps over time')" />
      </div>

      <span class="graph-date">8 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-weight-sleeping-hr">
      <h3>Correlation: weight and resting heart rate</h3>
      <p class="graph-description">
        This graph clearly shows the correlation between my body weight and my sleeping/resting heart rate. The resting heart rate is measured by the <a href='https://www.withings.com/us/en/scanwatch' target='_blank'>Withings Scanwatch</a> while sleeping, and indicates how hard your heart has to work while not being active. Generally the lower the resting heart rate, the better.
      </p>

      <ul>
        
          <li>I started my lean bulk (controlled weight gain combined with 5 workouts a week) in August 2020</li>
        
          <li>My resting heart rate went from 58bpm to 67bpm from August 2020 (<span class='highlighted'>+9bpm</span>) to March 2021 with a weight gain of <span class='highlighted'>+8.5kg</span> (+19lbs)</li>
        
          <li>The spike in resting heart rate in July & August 2021 was due to bars and nightclubs opening up again in Austria</li>
        
          <li>After a night of drinking, my resting/sleeping heart rate was about 50% higher than after a night without any alcohol</li>
        
          <li>The spike in resting heart rate in Oct/Nov/Dec 2021 was due to having bronchitis and a cold/flu, not getting correct treatment early enough</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Withings Scanwatch, Withings Scale
      </span>

      <div class="image-container">
        <img src="graphs/screens/weight-sleeping-hr.png" class="image-link" alt="Correlation: weight and resting heart rate" onclick="enlargeImage(this, 'graphs/screens/weight-sleeping-hr.png', 'Correlation: weight and resting heart rate')" />
      </div>

      <span class="graph-date">1.5 years of data - Last updated on 2022-02-09</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-healthy">
      <h3>How healthy was I over the years?</h3>
      <p class="graph-description">
        Every day I answered the question on how healthy I felt. In the graph, the yellow color indicates that I felt a little under the weather, not sick per se. Red means I was sick and had to stay home. Green means I felt energized and healthy.
      </p>

      <ul>
        
          <li>During the COVID lockdowns I tended to stay healthier. This may be due to not going out, no heavy drinking, less close contact with others, etc. which resulted in me having better sleep.</li>
        
          <li>Usually during excessive traveling I get sick (cold/flu)</li>
        
          <li>Q4 2021 I had bronchitis, however, I didn't know about it at the time and didn't get proper treatment</li>
        
          <li>Overall I'm quite prone to getting sick (cold/flu)</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/healthy.png" class="image-link" alt="How healthy was I over the years?" onclick="enlargeImage(this, 'graphs/screens/healthy.png', 'How healthy was I over the years?')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-alcoholic-beverages-buckets">
      <h3>Days with more than 4 alcoholic drinks</h3>
      <p class="graph-description">
        On days where I had more than 4 alcoholic beverages (meaning I was partying), the following other factors were affected
      </p>

      <ul>
        
          <li>21x more likely to dance</li>
        
          <li>80% more likely to take a nap the day of, or the day after</li>
        
          <li>60% more time spent with friends</li>
        
          <li>40% warmer temperatures. There weren't many opportunities for parties in Winter due to lockdowns in the last 2 years. Also, people are more motivated to go out when it's nice outside.</li>
        
          <li>25% more steps</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/alcoholic-beverages-buckets.png" class="image-link" alt="Days with more than 4 alcoholic drinks" onclick="enlargeImage(this, 'graphs/screens/alcoholic-beverages-buckets.png', 'Days with more than 4 alcoholic drinks')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-mood-graph-months">
      <h3>Mood over the years</h3>
      <p class="graph-description">
        My <a href='https://github.com/KrauseFx/FxLifeSheet' target='_blank'>FxLifeSheet bot</a> asks me 4 times a day how I'm feeling at the moment.
      </p>

      <ul>
        
          <li>This graph groups the entries by month, and shows the % of entries for each value (0 - 5) with 5 being very excited, and 0 being worried.</li>
        
          <li>I designed the ranges so that 0 or 5 are not entered as much. 0 is rendered as dark green at the top, whereas 5 is rendered as light green at the bottom.</li>
        
          <li>For privacy reasons I won't get into some of the details on why certain months were worse than others.</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/mood-graph-months.png" class="image-link" alt="Mood over the years" onclick="enlargeImage(this, 'graphs/screens/mood-graph-months.png', 'Mood over the years')" />
      </div>

      <span class="graph-date">4 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-map-world-trip">
      <h3>Location History</h3>
      <p class="graph-description">
        Every <a href='https://swarmapp.com' target='_blank'>Swarm</a> check-in over the last 7 years visualized on a map, including the actual trip (flight, drive, etc.)
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <div class="image-container">
        <img src="graphs/screens/map-world-trip.jpg" class="image-link" alt="Location History" onclick="enlargeImage(this, 'graphs/screens/map-world-trip.jpg', 'Location History')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-map-combined">
      <h3>Location History - Cities</h3>
      <p class="graph-description">
        Every <a href='https://swarmapp.com' target='_blank'>Swarm</a> check-in over the last 7 years visualized, zoomed in
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <div class="image-container">
        <img src="graphs/screens/map-combined.jpg" class="image-link" alt="Location History - Cities" onclick="enlargeImage(this, 'graphs/screens/map-combined.jpg', 'Location History - Cities')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-swarm-cities-top">
      <h3>Most visited POIs, grouped by city</h3>
      <p class="graph-description">
        Each time I checked into a place (e.g. Coffee, Restaurant, Airport, Gym) on <a href='https://swarmapp.com' target='_blank'>Foursquare Swarm</a> at a given city, this is tracked as a single entry.
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <div class="image-container">
        <img src="graphs/screens/swarm-cities-top.png" class="image-link" alt="Most visited POIs, grouped by city" onclick="enlargeImage(this, 'graphs/screens/swarm-cities-top.png', 'Most visited POIs, grouped by city')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-swarm-cities-top-years">
      <h3>Number of check-ins grouped by city</h3>
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

      <div class="image-container">
        <img src="graphs/screens/swarm-cities-top-years.png" class="image-link" alt="Number of check-ins grouped by city" onclick="enlargeImage(this, 'graphs/screens/swarm-cities-top-years.png', 'Number of check-ins grouped by city')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-swarm-categories-top">
      <h3>Top Categories of Checkins</h3>
      <p class="graph-description">
        Each check-in at a given category is tracked, and summed up over the last years
      </p>

      <ul>
        
          <li>In 2020 and 2021, check-ins at Offices went down to zero due to COVID, and a distributed work setup</li>
        
          <li><span class='highlighted'>Airports being the #4 most visited category</span> was a surprise, but is accurate. A total of 403 airport check-ins, whereas a flight with a layover would count as 3 airport checkins</li>
        
          <li>Earlier in my life, I didn't always check into 'commute' places like public transit and super markets</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <div class="image-container">
        <img src="graphs/screens/swarm-categories-top.png" class="image-link" alt="Top Categories of Checkins" onclick="enlargeImage(this, 'graphs/screens/swarm-categories-top.png', 'Top Categories of Checkins')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-swarm-number-of-checkins">
      <h3>Number of <a href='https://swarmapp.com' target='_blank'>Swarm</a> checkins over time</h3>
      <p class="graph-description">
        Number of Swarm checkins on each quarter over the last 10 years. I didn't use Foursquare Swarm as seriously before 2015. Once I moved to San Francisco in Q3 2015 I started my habit of checking into every point of interest (POI) I visit.
      </p>

      <ul>
        
          <li>Q3 2015 I moved to San Francisco, however I couldn't use Swarm yet, since my move was a secret until the official announced at the Twitter Flight conference</li>
        
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

      <div class="image-container">
        <img src="graphs/screens/swarm-number-of-checkins.png" class="image-link" alt="Number of [Swarm](https://swarmapp.com) checkins over time" onclick="enlargeImage(this, 'graphs/screens/swarm-number-of-checkins.png', 'Number of [Swarm](https://swarmapp.com) checkins over time')" />
      </div>

      <span class="graph-date">10 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-map-world-overview">
      <h3>Location History</h3>
      <p class="graph-description">
        Every <a href='https://swarmapp.com' target='_blank'>Swarm</a> check-in visualized on a map. Only areas where I've had multiple check-ins are rendered.
      </p>

      <ul>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      <div class="image-container">
        <img src="graphs/screens/map-world-overview.jpg" class="image-link" alt="Location History" onclick="enlargeImage(this, 'graphs/screens/map-world-overview.jpg', 'Location History')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-lockdown-days">
      <h3>Days in full lockdown</h3>
      <p class="graph-description">
        Number of days per year that I've spent in full lockdown, meaning restaurants, bars and non-essential stores were closed. On the graph below, "1" (blue) is a day where I was in full lockdown
      </p>

      <ul>
        
          <li>I escaped parts of the Austrian lockdown by spending time in the US when I was already vaccinated</li>
        
          <li>Surprisingly 2021 I spent more days in a full lockdown than in 2020, even with vaccines available</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/lockdown-days.png" class="image-link" alt="Days in full lockdown" onclick="enlargeImage(this, 'graphs/screens/lockdown-days.png', 'Days in full lockdown')" />
      </div>

      <span class="graph-date">3 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-manual-alcohol-intake">
      <h3>Alcoholic Beverages per day</h3>
      <p class="graph-description">
        Alcoholic drinks per day. Days with no data are rendered as white
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

      <div class="image-container">
        <img src="graphs/screens/manual-alcohol-intake.png" class="image-link" alt="Alcoholic Beverages per day" onclick="enlargeImage(this, 'graphs/screens/manual-alcohol-intake.png', 'Alcoholic Beverages per day')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-manual-alcohol-intake-months">
      <h3>Alcoholic Beverages per month</h3>
      <p class="graph-description">
        Each bar represents a month, the graph shows the number of alcoholic beverages on a given day, with '5' being 5 or more drinks. 
      </p>

      <ul>
        
          <li>In May 2019, the 0 bar is rendered to be 55%, meaning on 55% days of that month I didn't drink any alcohol</li>
        
          <li>July 2021 Austrian night life was fully open up again, with most COVID restrictions being lifted</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/manual-alcohol-intake-months.png" class="image-link" alt="Alcoholic Beverages per month" onclick="enlargeImage(this, 'graphs/screens/manual-alcohol-intake-months.png', 'Alcoholic Beverages per month')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-manual-gym-visits">
      <h3>Gym workouts</h3>
      <p class="graph-description">
        Each green square represents a strength-workout in the gym, I try my best to purchase day passes at gyms while traveling
      </p>

      <ul>
        
          <li>During the first lockdown in Q2 2020 I didn't have access to a gym, and didn't count home-workouts as gym visits</li>
        
          <li>In 2021 I tended to work out less often on Sunday, the day I visit my family's place</li>
        
          <li>In Q4 2021 I had a cold for a longer time</li>
        
          <li>I went from <span class='highlighted'>~50 workouts per year</span> in 2014/2015 to <span class='highlighted'>~200 per year</span> in 2018 - 2021</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/manual-gym-visits.png" class="image-link" alt="Gym workouts" onclick="enlargeImage(this, 'graphs/screens/manual-gym-visits.png', 'Gym workouts')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-macros">
      <h3>Food tracking - Macros</h3>
      <p class="graph-description">
        On weeks where I have a routine (not traveling), I track most my meals. Whenever I scale my food, I try to guess the weight before to become better at estimating portion sizes.
      </p>

      <ul>
        
          <li>Tracking macros precisely is the best way to lose/gain weight at a controlled and healthy speed</li>
        
          <li>When I first started tracking macros, additionally to already working out regularly, is when I started seeing the best results</li>
        
          <li>It takes a lot of energy to be consistent, but it's worth it, and it will make you feel good (e.g. feeling good about using a spoon to eat plain Nutella if you have the macros left)</li>
        
          <li>Gaining and losing weight is pretty much math, if you track your macros and body weight</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        MyFitnessPal
      </span>

      <div class="image-container">
        <img src="graphs/screens/macros.png" class="image-link" alt="Food tracking - Macros" onclick="enlargeImage(this, 'graphs/screens/macros.png', 'Food tracking - Macros')" />
      </div>

      <span class="graph-date">4 years of data - Last updated on 2022-02-17</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-manual-gym-visits-grouped">
      <h3>Gym workouts grouped by month</h3>
      <p class="graph-description">
        Percantage of days I went to the gym
      </p>

      <ul>
        
          <li>During the first lockdown in Q2 2020 I didn't have access to a gym, and didn't count home-workouts as gym visits</li>
        
          <li>Generally I hit the gym 5 days a week when I'm at home, but as shown on this graph it ends up being less, mostly due to traveling, and occasional colds</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/manual-gym-visits-grouped.png" class="image-link" alt="Gym workouts grouped by month" onclick="enlargeImage(this, 'graphs/screens/manual-gym-visits-grouped.png', 'Gym workouts grouped by month')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-fitness-bulk">
      <h3>Fitness Bulk & Cut season</h3>
      <p class="graph-description">
        I'm following a pretty regular bodybuilding routine, a 3-day workout split, and a normal bulk & cut seasons
      </p>

      <ul>
        
          <li>During times where fitness isn't high up on my priority list, I usually switch to maintainance</li>
        
          <li>During a cut, I have a slight kcal deficit of about 300kcal, to not negatively impact the rest of my life</li>
        
          <li>During the bulk, I aim to gain about 300g of body weight per week</li>
        
          <li>During a cut, I tend to track my meals more precisely than during a bulk or while maintaining</li>
        
          <li>Purple = Cut</li>
        
          <li>Brown = Bulk</li>
        
          <li>Blue = Maintainance</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/fitness-bulk.png" class="image-link" alt="Fitness Bulk & Cut season" onclick="enlargeImage(this, 'graphs/screens/fitness-bulk.png', 'Fitness Bulk & Cut season')" />
      </div>

      <span class="graph-date">4 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-weight-graph-1">
      <h3>Weight history of 8 years</h3>
      <p class="graph-description">
        Historic weight, clearly showing the various bulks and cuts I've made over the years. Only the last 5 years are rendered in this graph, with the last 3 years having tracked my weight way more frequently.
      </p>

      <ul>
        
          <li>Lowest recorded weight was <span class='highlighted'>69kg</span>/152lbs in 2014 (age 20)</li>
        
          <li>Highest recorded weight was <span class='highlighted'>89.8kg</span>/198lbs in 2021 (age 27)</li>
        
          <li>I gained 20kg (44lbs) while staying under 12% body fat on 193cm (6"4)</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Withings Scale
      </span>

      <div class="image-container">
        <img src="graphs/screens/weight-graph-1.png" class="image-link" alt="Weight history of 8 years" onclick="enlargeImage(this, 'graphs/screens/weight-graph-1.png', 'Weight history of 8 years')" />
      </div>

      <span class="graph-date">9 years of data - Last updated on 2022-02-17</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-weight-graph-2">
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

      <div class="image-container">
        <img src="graphs/screens/weight-graph-2.png" class="image-link" alt="Bulk & Cut Phase visualized" onclick="enlargeImage(this, 'graphs/screens/weight-graph-2.png', 'Bulk & Cut Phase visualized')" />
      </div>

      <span class="graph-date">1 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-daily-steps-buckets">
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

      <div class="image-container">
        <img src="graphs/screens/daily-steps-buckets.png" class="image-link" alt="Days with more than 15,000 steps" onclick="enlargeImage(this, 'graphs/screens/daily-steps-buckets.png', 'Days with more than 15,000 steps')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-sleep-duration-buckets">
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
        
          <li>Overall, it's clear that <span class='highlighted'>days with a longer sleep duration tend to be significantly worse days</span>. This is most likely due to the fact that I try to sleep a maximum of 8 hours, and if I actually sleep more than usually because I'm not feeling too well, or even sick</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Withings Scan Watch, Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/sleep-duration-buckets.png" class="image-link" alt="How does longer sleep duration affect my day?" onclick="enlargeImage(this, 'graphs/screens/sleep-duration-buckets.png', 'How does longer sleep duration affect my day?')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-air-quality">
      <h3>Air Quality in various rooms</h3>
      <p class="graph-description">
        I used the <a href='https://www.getawair.com/products/element' target='_blank'>Awair Element</a> at home in Vienna, in every room over multiple days
      </p>

      <ul>
        
          <li>Overall, the air quality in Vienna is excellent. Just opening the windows for a few minutes is enough to get a 100% air score</li>
        
          <li>The smaller the room, the more difficult it is to keep the CO2 levels low</li>
        
          <li>The only room where I'm still struggling to keep the CO2 levels low is my bedroom, which is small, and doesn't offer any ventilation. Keeping the doors open mostly solves the high CO2 levels, however comes with other downsides like more light</li>
        
          <li>Probably obvious for many, but <span class='highlighted'>I didn't realize ACs don't transport any air into the room, but just moves it around</span></li>
        
          <li>Opening the windows for a longer time in winter will cause low humidity and low temperatures, so it's often not a good option</li>
        
          <li>I didn't learn anything from the Chemicals and PM2.5 graphs</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Awair
      </span>

      <div class="image-container">
        <img src="graphs/screens/air-quality.png" class="image-link" alt="Air Quality in various rooms" onclick="enlargeImage(this, 'graphs/screens/air-quality.png', 'Air Quality in various rooms')" />
      </div>

      <span class="graph-date">1 years of data - Last updated on 2022-02-09</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-rescue-time-usage-categories">
      <h3>RescueTime Computer Usage Categories</h3>
      <p class="graph-description">
        Using <a href='https://rescuetime.com' target='_blank'>RescueTime</a>, I tracked my exact computer usage, and the categories of activities in which I spend time with.
      </p>

      <ul>
        
          <li>Over the last 7 years, I went from spending around 10% of my time with communication & scheduling, to around 30%</li>
        
          <li>Over the last 7 years, I went from spending around 33% of my time with software development, to less than 10% (now that I'm not currently full-time employed)</li>
        
          <li>All other categories stayed pretty much on the same ratio over the last 7 years</li>
        
          <li>Total amount spent on my computer went down significantly after having left my job late 2021</li>
        
          <li>Tracking productivity levels automatically is difficult to get right, as it's hard to classify certain activities.</li>
        
          <li>Day to day I'm using <a href='https://timingapp.com/' target='_blank'>Timing App</a> which has a significantly nicer user experience, however I just had many additional years of data on RescueTime</li>
        
          <li><span class='highlighted'>I highly recommend every professional to track their computer usage.</span> It's surprising to see how many hours a day you actually get on your computer, and how much of it is considered productive. <a href='https://timingapp.com/' target='_blank'>Timing App</a> shows the amount of hours of the day on the Mac's status bar, and it's been extremely useful</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        RescueTime
      </span>

      <div class="image-container">
        <img src="graphs/screens/rescue-time-usage-categories.png" class="image-link" alt="RescueTime Computer Usage Categories" onclick="enlargeImage(this, 'graphs/screens/rescue-time-usage-categories.png', 'RescueTime Computer Usage Categories')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-socializing">
      <h3>Happy with my social life?</h3>
      <p class="graph-description">
        Each day I answer the question "Do you feel like you need to socialize more?" with the answers ranging from "No" (5 = light green) to "Feeling isolated" (0 = dark green)
      </p>

      <ul>
        
          <li>Since I'm an Introvert, I tend to feel like I socialize too much, rather than too little</li>
        
          <li><span class='highlighted'>Early COVID lockdown March 2020 was still good, however as the lockdown continued I started feeling more isolated</span>, also partly because I was single, and had just moved to Vienna</li>
        
          <li>End of July 2020 Austria opened up most social venues again, bringing this graph back to an ideal level again</li>
        
          <li>December 2019 I was working remotely from Buenos Aires, however got a pretty bad cold. Being sick in a remote city wasn't the best feeling</li>
        
          <li>Over the last 2.5 years I actually never felt isolated, therefore there is no entry for the value '0'</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/socializing.png" class="image-link" alt="Happy with my social life?" onclick="enlargeImage(this, 'graphs/screens/socializing.png', 'Happy with my social life?')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-season-winter">
      <h3>How does Winter affect my life?</h3>
      <p class="graph-description">
        Winter (being from 21st Dec to 20th March) has the following effects on my life:
      </p>

      <ul>
        
          <li>Online shopping time going up by 100%, most likely due to the last Winters having spent in lockdown</li>
        
          <li><span class='highlighted'>Chances of having cold symptons goes up 45%</span></li>
        
          <li>35% less likely to take a freezing cold shower</li>
        
          <li>Unsurprisingly, I'm exposed to less solar energy in Winter, make sure to get enough Vitamin D</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manual
      </span>

      <div class="image-container">
        <img src="graphs/screens/season-winter.png" class="image-link" alt="How does Winter affect my life?" onclick="enlargeImage(this, 'graphs/screens/season-winter.png', 'How does Winter affect my life?')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-season-summer">
      <h3>How does Summer affect my life?</h3>
      <p class="graph-description">
        Summer (being from 21st June to 23rd September) has the following effects on my life:
      </p>

      <ul>
        
          <li>Chances of taking a freezing cold shower goes up by 100%</li>
        
          <li>I walk 33% more steps in Summer</li>
        
          <li>30% more likely to hit the gym</li>
        
          <li>23% more alcoholic beverages (there were no lockdowns in Summer, also )</li>
        
          <li>20% less time spent reading news & opinions (as per <a href='https://rescuetime.com' target='_blank'>RescueTime</a> classifications)</li>
        
          <li><span class='highlighted'>40% less likely to be sick</span></li>
        
          <li>40% less time spent on Entertainment on my computer (as per <a href='https://rescuetime.com' target='_blank'>RescueTime</a> classifications)</li>
        
          <li>30% less likely to have bad dreams</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manual
      </span>

      <div class="image-container">
        <img src="graphs/screens/season-summer.png" class="image-link" alt="How does Summer affect my life?" onclick="enlargeImage(this, 'graphs/screens/season-summer.png', 'How does Summer affect my life?')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-countries">
      <h3>Days spent in each country</h3>
      <p class="graph-description">
        Percentage of days spent in each country over the last 4 years
      </p>

      <ul>
        
          <li>International travel has slowed down significantly since COVID started</li>
        
          <li>Traveling without a stop home for more than 3 weeks gets exhausting for me, I prefer doing more shorter travels instead</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/countries.png" class="image-link" alt="Days spent in each country" onclick="enlargeImage(this, 'graphs/screens/countries.png', 'Days spent in each country')" />
      </div>

      <span class="graph-date">4 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-manual-living-style-years">
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

      <div class="image-container">
        <img src="graphs/screens/manual-living-style-years.png" class="image-link" alt="Living Style" onclick="enlargeImage(this, 'graphs/screens/manual-living-style-years.png', 'Living Style')" />
      </div>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-weather-temperature-buckets">
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

      <div class="image-container">
        <img src="graphs/screens/weather-temperature-buckets.png" class="image-link" alt="How does high temperature affect my life?" onclick="enlargeImage(this, 'graphs/screens/weather-temperature-buckets.png', 'How does high temperature affect my life?')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-day-is-weekend">
      <h3>What are weekends like?</h3>
      <p class="graph-description">
        Weekends for me naturally involve less working time, more going out, and social interactions, as well as visiting family memebers outside the city
      </p>

      <ul>
        
          <li>150% more computer time spent on "Entertainment", which is mostly coming from occasionally playing <a href='https://www.factorio.com/' target='_blank'>Factorio</a> or Age Of Empires with friends at LAN-Party gatherings</li>
        
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

      <div class="image-container">
        <img src="graphs/screens/day-is-weekend.png" class="image-link" alt="What are weekends like?" onclick="enlargeImage(this, 'graphs/screens/day-is-weekend.png', 'What are weekends like?')" />
      </div>

      <span class="graph-date">2.5 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-weather-temperature-max">
      <h3>Maximal temperature each day of the year</h3>
      <p class="graph-description">
        Historic weather data based on the location I was at on that day based on my Swarm check-ins. Days with no data are rendered as white
      </p>

      <ul>
        
          <li>Turns out, days in Summer are warmer than days in Winter</li>
        
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

      <div class="image-container">
        <img src="graphs/screens/weather-temperature-max.png" class="image-link" alt="Maximal temperature each day of the year" onclick="enlargeImage(this, 'graphs/screens/weather-temperature-max.png', 'Maximal temperature each day of the year')" />
      </div>

      <span class="graph-date">3 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-weather-conditions">
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

      <div class="image-container">
        <img src="graphs/screens/weather-conditions.png" class="image-link" alt="Weather conditions per year" onclick="enlargeImage(this, 'graphs/screens/weather-conditions.png', 'Weather conditions per year')" />
      </div>

      <span class="graph-date">3 years of data - Last updated on 2022-01-01</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-money-distribution">
      <h3>Investment Distribution</h3>
      <p class="graph-description">
        Every second week I track my current investments and cash positions. It shows me how to most efficiently re-balance my investments in case they're off track, while also minimizing the occuring trading fees.
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

      <div class="image-container">
        <img src="graphs/screens/money-distribution.png" class="image-link" alt="Investment Distribution" onclick="enlargeImage(this, 'graphs/screens/money-distribution.png', 'Investment Distribution')" />
      </div>

      <span class="graph-date">8 years of data - Last updated on 2022-02-09</span>
    </div>
  
    
    
    

    <div class="graphs-entry" id="graphs-entry-money-flow">
      <h3>Annual money flow</h3>
      <p class="graph-description">
        Inspired by a <a href='https://old.reddit.com/r/PFPorn' target='_blank'>Reddit finance commnunity</a>, I had been creating annual money flow charts to clearly see how much money I earned, where I spent how much, and how much I saved. The chart below isn't mine (for privacy reasons), but just an example I created.
      </p>

      <ul>
        
          <li><span class='highlighted'>Not owning an apartment, and <a href='/blog/one-year-nomad' target='_blank'>living in Airbnbs as a nomad</a> I actually spent less money.</span> This was due to not having to buy any furniture, appliances, etc. but also because the number of items I could by for myself was limited, as everything was limited to be able to fit into 2 suitcases. Additionaly I didn't have to pay any rent whenever I traveled for my job, or during conferences.</li>
        
          <li>Misc. subscriptions/expenses are adding up quickly</li>
        
          <li>Having an End-Of-Year summary from your credit card provider, and always using your card when possible, is a great way to get those numbers</li>
        
          <li>Creating this chart is still a lot of work, as you have to keep in mind that some expenses are not solely yours, but you might have covered for a group (e.g. booked a larger Airbnb), or got reimbursed</li>
        
      </ul>

      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Chase Credit Card Year Summary, sankeymatic.com, Manually
      </span>

      <div class="image-container">
        <img src="graphs/screens/money-flow.png" class="image-link" alt="Annual money flow" onclick="enlargeImage(this, 'graphs/screens/money-flow.png', 'Annual money flow')" />
      </div>

      <span class="graph-date">5 years of data - Last updated on 2022-02-09</span>
    </div>
  
</div>

<h3 style="margin-top: 15px;">More Information</h3>

This project has 3 separate components:

<b>◦ Database</b>

A timestamp-based key-value database of all data entries powered by Postgres. This allows me to add and remove questions on-the-fly.

<img src="/graphs/assets/fxlifesheet-database.png" />

Each row has a `timestamp`, `key` and `value`. 

- The `timestamp` is the time for which the data was recorded for. This might differ from `imported_at` which contains the timestamp on when this entry was created. Additionally I have a few extra columns like `yearmonth` (e.g. 202010), which makes it easier and faster for some queries and graphs.
- The `key` describes **what** is being recorded (e.g. `"weight"`, `"locationLat"`, `"mood"`). This can be any string, and I can add and remove keys easily on the fly in the [FxLifeSheet configuration file](https://github.com/KrauseFx/FxLifeSheet/blob/master/lifesheet.json) without having to modify the database.
- The `value` is the actual value being recorded. This can be any number, string, boolean, etc. 

<b>◦ Data Inputs</b>

<img src="/graphs/assets/fxlifesheet-questions.png" style="height: 480px; float: right; margin-left: 10px; margin-top: -70px;" />

Multiple times a day, I manually answer questions [FxLifeSheet](https://github.com/KrauseFx/FxLifeSheet) sends me via a Telegram bot, which range from fitness-related questions (e.g. nutrition, exercise, sleep, etc.) to questions about my life (e.g. how I'm feeling, how much time I spend on social media, etc.).

Additionally I can fill-out date ranges with specific values, for example lockdown periods, and bulking/cutting fitness seasons.

<b>◦ Data Visualizations</b>

After having tried various tools available to visualize, I ended up writing my own data analysis layer using Ruby, JavaScript together with [Plotly](https://plotly.com/javascript/). You can find the full source code on [KrauseFx/FxLifeSheet - visual_playground](https://github.com/KrauseFx/FxLifeSheet/tree/master/visual_playground).

<div id="enlargedImageContainer" style="display: none">
  <div id="enlargedImageContainerBackground"></div>
  <a target="_blank" id="enlargedImageLink">
    <img id="enlargedImage" />
  </a>
  <p id="enlargedImageTitle"></p>
</div>

<div id="arrow-left-button" class="arrow-button"></div>
<div id="arrow-right-button" class="arrow-button"></div>

<script type="text/javascript">
  // Subscribe to mouse wheel
  const imageLinks = document.getElementsByClassName("image-link")
  for (let i = 0; i < imageLinks.length; i++) {
    imageLinks[i].addEventListener("mousedown", function(event) {
      if (event.button === 1) { // 1 = center mouse button
        event.preventDefault()
        window.open(this.getAttribute("src"), '_blank');
      }
    })
  }

  let lastNode = null;

  function enlargeImage(node, img, title) {
    // Check if this is a center mouse click (Control or Meta Key)
    if (event.ctrlKey || event.metaKey) {
      window.open(img, '_blank');
      return;
    }

    // Check if it's already been the selected one
    if (lastNode == node.parentElement.parentElement) {
      showFullScreen(img, title);
      return;
    }

    if (lastNode) {
      lastNode.classList.remove("graph-entry-selected");
    }
    node.parentElement.parentElement.classList.add("graph-entry-selected");

    alignArrowKeys(node.parentElement.parentElement);

    node.parentElement.parentElement.scrollIntoView();
    window.scrollBy({ top: -15 });

    // If we have a small screen, we also want to immediately use full-screen mode
    var width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    if (width < 800) {
      showFullScreen(img, title);
    }

    lastNode = node.parentElement.parentElement;
  }

  function alignArrowKeys(node) {
    // Attach the arrows to be next to the `graph-entry-selected`
    const arrowLeft = document.getElementById("arrow-left-button");
    const arrowRight = document.getElementById("arrow-right-button");
    const topPx = (node.offsetTop + 250 - arrowRight.offsetHeight / 2) + "px";

    arrowLeft.style.left = (node.offsetLeft - arrowLeft.offsetWidth - 10) + "px";
    arrowLeft.style.top = topPx;

    arrowRight.style.left = (node.offsetLeft + node.offsetWidth - arrowRight.offsetWidth + 50) + "px";
    arrowRight.style.top = topPx;
  }

  function showFullScreen(img, title) {
    document.getElementById("enlargedImageContainer").style.display = "block";
    document.getElementById("enlargedImage").src = img;
    document.getElementById("enlargedImageLink").href = img;
    document.getElementById("enlargedImageTitle").innerHTML = title;
  }

  function dismissImage() {
    document.getElementById("enlargedImageContainer").style.display = "none";
  }

  function nextGraph() {
    if (lastNode) {
      lastNode.classList.remove("graph-entry-selected");
      lastNode = lastNode.nextElementSibling;
      lastNode.classList.add("graph-entry-selected");

      alignArrowKeys(lastNode)
      lastNode.scrollIntoView();        
      window.scrollBy({ top: -15 });
      clearSelection();
      return false;
    }
    return true;
  }
  function previousGraph() {
    if (lastNode) {
      lastNode.classList.remove("graph-entry-selected");
      lastNode = lastNode.previousElementSibling;
      lastNode.classList.add("graph-entry-selected");

      alignArrowKeys(lastNode)
      lastNode.scrollIntoView();        
      window.scrollBy({ top: -15 });
      clearSelection();
      return false;
    }
    return true;
  }

  function clearSelection() {
    // As sometimes the arrows get selected
    if (window.getSelection) {window.getSelection().removeAllRanges();}
    else if (document.selection) {document.selection.empty();}
  }

  document.getElementById("arrow-left-button").addEventListener("click", previousGraph);
  document.getElementById("arrow-right-button").addEventListener("click", nextGraph);
  document.getElementById("enlargedImageContainerBackground").addEventListener("touchstart", dismissImage); // so that mobile devices don't scroll 
  document.getElementById("enlargedImageContainerBackground").addEventListener("click", dismissImage); // desktop browsers

  window.addEventListener("keyup", function(e) {
    if (e.keyCode == 27) { // ESC
      if (document.getElementsByClassName("graph-entry-selected").length > 0 && document.getElementById("enlargedImageContainer").style.display == "none") {
        clearSelection();
        lastNode.classList.remove("graph-entry-selected");
        lastNode = null;
      }
      dismissImage();
      return true;
    }

    // Use arrow keys
    if (e.keyCode == 37 || e.keyCode == 38) { // Left and up
      return previousGraph();
    }
    if (e.keyCode == 39 || e.keyCode == 40) { // Right and down
      return nextGraph();
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
  #enlargedImageContainerBackground {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.8);
    z-index: -100;
  }
  #enlargedImageContainer {
    position: fixed;
    z-index: 100;
    top: 0;
    cursor: pointer;
    left: 0;
    right: 0;
    bottom: 0;
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
    line-height: 1.2;
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
  .image-container {
    width: 100%;
    text-align: center;
  }
  .image-link {
    padding-top: 10px;
    cursor: pointer;
    max-height: 900px;
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
  .graph-entry-selected {
    max-width: 100%;
    border: 3px solid #00BFFF;
  }
  .arrow-button {
    position: absolute;
    height: 40px;
    top: calc(50% - 10px);
    cursor: pointer;
    top: -100px;
  }
  #arrow-right-button {
    content: url('/graphs/assets/source_icons_arrow-right-circled.svg');
  }
  #arrow-left-button {
    content: url('/graphs/assets/source_icons_arrow-left-circled.svg');
  }
  @media screen and (max-width: 800px) {
    #arrow-right-button {
      display: none;
    }
    #arrow-left-button {
      display: none;
    }
  }
</style>
