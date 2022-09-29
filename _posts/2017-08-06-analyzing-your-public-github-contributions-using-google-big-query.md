---
layout: post
title: Analyzing your public GitHub contributions using Google Big Query
categories: []
tags:
- open source
- github
status: publish
type: post
published: true
meta: {}
---

Do you like those GitHub graphs, but want to know even more about your open source behavior? GitHub has you covered with 
[githubarchive.org](https://www.githubarchive.org/). GitHubArchive offers dumps of all GitHub events of all users and open source projects. New ones are generated every single day, and are instantly accessible. They are very easy to use together with 
[Google Big Query](https://cloud.google.com/bigquery/).

If you have a Google Cloud account & project, click 
[this link](https://bigquery.cloud.google.com/savedquery/900199909722:d0156caf0eb0459981d4d0cd31ba6326) to give it a try. Use the 
Run Query button and wait for about 30 seconds, and you'll get a list of people that comment on any of the 
[fastlane](https://fastlane.tools) repos most often in the year of 2017 (see screenshot below):
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_592b463d44024329b9559389_1496008271573__img.png)
  
To run this query for your own GitHub organization, just replace the "
fastlane/%" with your own GitHub org. You can also easily extend the query to show more columns (see the 
[list of available events](https://developer.github.com/v3/activity/events/types/)).

### Running queries on your own profile


I was wondering of how my GitHub behavior changed over the last few years, now that fastlane is actively being used by tens of thousands of companies, it’s harder to 
[keep the innovation you had in the beginning](https://krausefx.com/blog/scaling-open-source-communities).

The last 3 years I published a total of

* 16,000 comments
* 5,550 Pull Requests
* 907 releases

across a high number of different open source projects, mostly 
[fastlane](https://github.com/fastlane/fastlane), 
[TSMessages](https://github.com/KrauseFx/TSMessages), 
[danger](http://danger.system) and lots of other projects.

**Below you can see the last 5 years of open source code contributions:**
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_598682c8bebafb164ee70efb_1501987676418__img.png)

Over the last 3 years, on average I did the following 
**every single week**

* Post **77 comments** on GitHub Issues
* Submit **28 Pull Requests**(the first year of fastlane, I didn't submit PRs on my own repos)
* Posted **16 comments** on GitHub Pull Requests
* Published **5 fastlane releases**

### Wrapping up

You can extend those queries to show you more information that’s relevant to you. I initially wanted to use this to see which of our contributors are the most active, and make sure we promote them to be [Core Contributors](https://github.com/fastlane/fastlane/blob/master/CORE_CONTRIBUTOR.md).

There has been quite some discussion around the GitHub graph (e.g. [isaacs/github#627](https://github.com/isaacs/github/issues/627)), as many engineers took it far too seriously and tried to have a long streak without any interruptions. GitHub reacted to the feedback and removed the streak count from all profiles, and added an option to show private contributions on the graphs.

Special thanks to [@sebmasterkde](https://twitter.com/sebmasterkde) for coming up with the initial queries.

Note: The data shown above is from May, as that’s when I wrote this blog post, but was kind of distracted with more important things (life and such) and finally found the time to publish this post.

```sql
/* GitHub query to get the number of comments, PR, releases, etc. for a given GH org */

WITH 
  ProjectData AS (SELECT * FROM `githubarchive.day.2017*` WHERE repo.name LIKE 'fastlane/%'),
  Actors AS (SELECT DISTINCT(actor.login) AS login FROM ProjectData)

SELECT * FROM (
  SELECT 
    actors.login,
    (SELECT COUNT(*) FROM ProjectData WHERE type = 'IssueCommentEvent' AND actor.login = actors.login) AS Comments,
    (SELECT COUNT(*) FROM ProjectData WHERE type = 'PullRequestEvent' AND actor.login = actors.login) AS PRs,
    (SELECT COUNT(*) FROM ProjectData WHERE type = 'PullRequestReviewCommentEvent' AND actor.login = actors.login) AS ReviewComments,
    (SELECT COUNT(*) FROM ProjectData WHERE type = 'ReleaseEvent' AND actor.login = actors.login) AS Releases,
    (SELECT COUNT(*) FROM ProjectData WHERE type = 'IssuesEvent' AND actor.login = actors.login) AS ClosedRenamedAndLabeledIssues
  FROM Actors as actors
)
WHERE PRs > 0 OR Comments > 0
ORDER BY PRs DESC, Comments DESC;
```
