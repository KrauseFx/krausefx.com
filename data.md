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

<h1>My whole life in a single database</h1>

As part of the [FxLifeSheet project](https://github.com/KrauseFx/FxLifeSheet) I've started back in 2019, I started collecting all kinds of metrics about my life.
Every single day for the last 2.5 years I've tracked over 100 different data points of my life.

I haven't yet had the time to analyze all the outcomes, but felt like I already have some very interesting graphs I'd like to share here:

Currently, I have <b>335,000 data points</b>, with the biggest data sources being

- Foursquare Swarm: 125,000
- RescueTime: 120,000
- Manually entered: 63,000
- Manually entered time ranges: 10,000
- Weather API: 16,000
- Apple Health: 1,000

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

      <a href="graphs/screens/jetlovers-stats.png" target="_blank" class="image-link">
        <img src="graphs/screens/jetlovers-stats.png" alt="Flying Stats - General" />
      </a>

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

      <a href="graphs/screens/jetlovers-top.png" target="_blank" class="image-link">
        <img src="graphs/screens/jetlovers-top.png" alt="Flying Stats - Top" />
      </a>

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

      <a href="graphs/screens/swarm-cities-top.png" target="_blank" class="image-link">
        <img src="graphs/screens/swarm-cities-top.png" alt="Top Cities (Checkins)" />
      </a>

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

      <a href="graphs/screens/swarm-cities-top-years.png" target="_blank" class="image-link">
        <img src="graphs/screens/swarm-cities-top-years.png" alt="Top Cities over the years" />
      </a>

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

      <a href="graphs/screens/swarm-categories-top.png" target="_blank" class="image-link">
        <img src="graphs/screens/swarm-categories-top.png" alt="Top Categories of Checkins" />
      </a>

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

      <a href="graphs/screens/weather-temperature-max.png" target="_blank" class="image-link">
        <img src="graphs/screens/weather-temperature-max.png" alt="Maximal temperature each day of the year" />
      </a>

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

      <a href="graphs/screens/manual-alcohol-intake.png" target="_blank" class="image-link">
        <img src="graphs/screens/manual-alcohol-intake.png" alt="Alcoholic Beverages per day" />
      </a>

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

      <a href="graphs/screens/manual-gym-visits.png" target="_blank" class="image-link">
        <img src="graphs/screens/manual-gym-visits.png" alt="Workouts in the gym" />
      </a>

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

      <a href="graphs/screens/manual-living-style-years.png" target="_blank" class="image-link">
        <img src="graphs/screens/manual-living-style-years.png" alt="Living Style" />
      </a>

      <span class="graph-date">7 years of data - Last updated on 2022-01-01</span>
    </div>
  
</div>

<style type="text/css">
  #graphs-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
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
  .image-link > img {
    padding-top: 10px;
  }
</style>