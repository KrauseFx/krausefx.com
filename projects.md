---
layout: page
title: Projects
categories: []
tags: []
status: publish
type: page
published: true
meta: {}
---

# Projects

All the major projects I've worked on in the last few years. Unless otherwise noted, I'm the sole-founder of each of the projects.

{% for project in site.data.projects %}
  <div class="fx-project">
    <div class="title">
      <h3><a href="{{ project.url }}" target="_blank">{{ project.title }}</a></h3>
    </div>
    <div class="subtitle">
      {{ project.subtitle }}
    </div>
    <div class="metadata">
      {{ project.metadata }}
    </div>
  </div>
{% endfor %}

<br />

For more details check out my [about page](/about).

<style type="text/css">
  .fx-project {
    border: 1px solid #d1d5da;
    margin-bottom: 16px;
    margin-right: 10px;
    padding: 20px;
    width: calc(50% - 40px - 20px);
    height: 130px;
    display: inline-block;
    border-radius: 3px;
    vertical-align: top;
    position: relative;
  }

  @media screen and (max-width: 800px) {
    .fx-project {
      width: calc(100% - 40px);
      height: 180px;
    }
  }

  .fx-project > .title {

  }
  .fx-project > .title > h3 > a {
    text-decoration: none;
  }
  .fx-project > .subtitle {
    color: #586069;
    font-size: 14px;
  }
  .fx-project > .metadata {
    font-size: 14px;
    color: #777;
    border: 1px solid #d1d5da;
    border-right: 0;
    border-bottom: 0;
    max-width: 80%;
    
    padding: 5px;
    padding-left: 15px;
    padding-right: 15px;
    position: absolute;
    bottom: 0px;
    right: 0px;
    border-radius: 3px 0 0 0;
  }
</style>
