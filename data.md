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
      <h3>Categories of places visited</h3>
      <p class="graph-description">
        Each Swarm check-in comes with a place-category associated. This graph shows the number of check-ins per category.
      </p>
      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      
      <a href="graphs/screens/swarm-places-categories.png" target="_blank">
        <img src="graphs/screens/swarm-places-categories.png" alt="Categories of places visited" />
      </a>

      <span class="graph-date">Last updated on 2021-12-11</span>
    </div>
  
    <div class="graphs-entry">
      <h3>Airport Visits</h3>
      <p class="graph-description">
        Visualization of when I visited an airport. This clearly shows the effect of COVID starting March 2020
      </p>
      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Swarm
      </span>

      
      <a href="graphs/screens/swarm-airport-checkins.png" target="_blank">
        <img src="graphs/screens/swarm-airport-checkins.png" alt="Airport Visits" />
      </a>

      <span class="graph-date">Last updated on 2021-12-11</span>
    </div>
  
    <div class="graphs-entry">
      <h3>Mood</h3>
      <p class="graph-description">
        How I felt on average, grouped by month. Filled out the question four times a day
      </p>
      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manual
      </span>

      
      <a href="graphs/screens/mood.png" target="_blank">
        <img src="graphs/screens/mood.png" alt="Mood" />
      </a>

      <span class="graph-date">Last updated on 2021-12-11</span>
    </div>
  
    <div class="graphs-entry">
      <h3>Lockdown days per year</h3>
      <p class="graph-description">
        Number of days I spent in a full lockdown. Those days all happened in Austria, however I escaped the lockdowns a few times by spending time in the US
      </p>
      <span class="graph-sources">
        <span class="graph-sources-header">
          Sources: 
        </span>
        Manual
      </span>

      
      <a href="graphs/screens/graphs.png" target="_blank">
        <img src="graphs/screens/graphs.png" alt="Lockdown days per year" />
      </a>

      <span class="graph-date">Last updated on 2021-12-11</span>
    </div>
  
</div>

<style type="text/css">
  #graphs-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-around;
  }
  .graphs-entry {
    width: 400px;
    margin: 10px;
    border: 2px solid #e4e7ef;
    border-radius: 9px;
    padding: 20px;
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
  }
</style>