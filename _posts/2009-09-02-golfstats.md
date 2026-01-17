---
layout: post
title: Golfstats
categories:
- Projects
tags: []
status: publish
type: post
published: true
meta:
  structured_content: '{"oembed":{},"overlay":true}'
  _thumbnail_id: '73'
---

In 2009 I wrote some scripts that automatically download all results of golf competitions in Austria and saved it in a database.

After downloading the data, I developed various statistics and analyzed the results to help golfers figure out where to play to get a better handicap in specific regions. The platform aggregated data from 169 golf clubs across Austria, processing 3,958,830 tournament results and tracking 8,177 tournaments.

The tech stack used in 2009:

- Python: Scraping the golf.at golf tournament results pages
- MySQL: Storing the data in a normalized database
- PHP: Processing the data and generating statistics
- HTML, CSS, JavaScript, AJAX, jQuery: Building the front-end website

The idea was to help golfers find the best golf clubs and tournaments to improve their handicaps based on historical data for their handicap range. Since each golf club has their own handicap rating to account for each difficulty, there must be some level of inaccuracy in how they're set. 

With this project, I showed that some clubs consistently yield better or worse results than others for players of specific handicap ranges.

## The Platform

<a href="/assets/posts/golfstats/homepage-recommendations.png" target="_blank"><img src="/assets/posts/golfstats/homepage-recommendations.png" /></a>


<a href="/assets/posts/golfstats/clubs-ranking.png" target="_blank"><img src="/assets/posts/golfstats/clubs-ranking.png" /></a>


<a href="/assets/posts/golfstats/bundesland-ranking.png" target="_blank"><img src="/assets/posts/golfstats/bundesland-ranking.png" /></a>


<a href="/assets/posts/golfstats/netto-scores-by-state.png" target="_blank"><img src="/assets/posts/golfstats/netto-scores-by-state.png" /></a>


<a href="/assets/posts/golfstats/club-detail-page.png" target="_blank"><img src="/assets/posts/golfstats/club-detail-page.png" /></a>


<a href="/assets/posts/golfstats/search-results.png" target="_blank"><img src="/assets/posts/golfstats/search-results.png" /></a>


<a href="/assets/posts/golfstats/data-query-page.png" target="_blank"><img src="/assets/posts/golfstats/data-query-page.png" /></a>


<a href="/assets/posts/golfstats/contact-page.png" target="_blank"><img src="/assets/posts/golfstats/contact-page.png" /></a>


<a href="/assets/posts/golfstats/about-page.png" target="_blank"><img src="/assets/posts/golfstats/about-page.png" /></a>

