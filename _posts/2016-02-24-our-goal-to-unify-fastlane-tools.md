---
layout: post
title: Our goal to unify fastlane tools
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

I’ve been working as an iOS developer for over 5 years for various companies around the world. During that time it became clear there was lots of room for improvements around mobile developer tools, and in particular, the deployment of apps. Because of that, I started implementing little tools to help me automate tedious tasks like uploading metadata for release builds or generating screenshots. Each of those tools had no connection with each other and ran as standalone commands. About 4 months after the initial release of [deliver](https://github.com/fastlane/deliver), [snapshot](https://github.com/fastlane/snapshot) and [frameit](https://github.com/fastlane/frameit), I noticed one common theme: All users of those tools developed their own shell scripts to trigger different deployment steps, pass on information, and ensure every step was successful.

I wanted to help developers connect all the tools they use into one simple workflow. **That’s why I created fastlane.**

But as the community grew and the architecture became more complex, I needed to think about how we could best build the foundation of fastlane to continue to be a tool you love to use. 

In its current setup, we ran into these problems:

* When releasing a spaceship bugfix, it required us to do at least five releases just to roll out the change to all users
* fastlane has its own repo just to manage the other repos called "[countdown](https://github.com/fastlane/countdown)"
* The fastlane organization has over 30 GitHub repositories
* I added 360 commits whose only purpose was to update internal dependencies between fastlane tools
* We ended up with a lot of duplicate issues across multiple repos
* Having 20 different travis builds to keep green, instead of just one


* Working on a new feature or big change required us to switch to a separate branch on three different repos, which all depended on each other. Not only is it very time consuming to work on three different repo’s feature branches, but also the release takes longer: You have to merge the first PR, then do a release, before you can update the dependency of the other tool, to turn the build green and merge the next one.


* It’s hard to decide when to release an update for each of the tools, so we built a script to show which tool has the highest number of outstanding changes to be released. Switching to a mono repo allows us to switch to a more regular release cycle

## Our goal to unify fastlane tools


To solve a lot of these problems, our team decided to move all fastlane tools into one main repository. Each tool will be in a subfolder enabling you easy access to its source code.
  

![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_56cdf5d407eaa0c7455e43cf_1456338400441_Screenshot+2016-02-24+12.21.45.png.45.png)

I wanted to make this change as seamless and hassle-free as possible for everyone. With this migration, you can still use all tools directly, so your setup will continue to work as normal. 

**This should not break any existing setups and doesn’t require any action from your side. **

Unifying fastlane means having one place for everything you need. Now, there will be one place to submit and search for issues on GitHub, one place for the documentation, one place to contribute to fastlane, and one tool to install :)

We’ll be making this move within the next couple of weeks.

## Technical Details

I’d like to share some more technical information on how the switch will work and the challenges I faced.

### The requirements:


* All individual tools (like deliver, snapshot, etc.) have to be moved into the main fastlane repo
* We want to preserve the complete history, meaning all commits across all repositories
* All existing issues on the repositories need to be migrated to the main repo, both open and closed ones
* I wanted to be sure that every person who contributed to fastlane in the past shows up in the Contribution Graph. fastlane wouldn’t be possible without the great community around it.

To implement all this I created a new repo (ironically) that contains all the scripts used to make the switch. You can find all the source code on [fastlane/monorepo](https://github.com/fastlane/monorepo).

### Moving the tools to the main repo


To move all source code to the main repo and still preserve the history with all commits, we used standard git features. You can check out the full source code on [GitHub](https://github.com/fastlane/monorepo). Using this technique, all previous commits are still available, and the 
[Contribution Graph](https://github.com/fastlane/fastlane/graphs/contributors) shows all developers who ever contributed to fastlane.

### Copying the GitHub issues to the main repo


![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_56cdf682b09f9568dea6ebd5_1456338570156__img.png)
  


There is no built-in way to migrate or merge issues to another repo. GitHub provides a great API which we used to copy over all existing issues. However the newly copied issues are not created by the original author, but by our fastlane bot instead. On the newly created issue we always mention the original authors, resulting in them being subscribed to the new issue. 

You can check out the full source code on 
[GitHub](https://github.com/fastlane/monorepo/blob/master/migrate_issues.rb). With this we worked on a lot of little tricks to make sure users are subscribed to the newly migrated issue and the original author is still visible. The GitHub API doesn’t allow us to post issues as the original author (for good reasons), so we solved this problem by posting the user’s information right inside the actual issue.

### Ruby Gems

There are no changes with the way you install fastlane, you can still install tools e.g. using 
gem install deliver.

### What happens to the other GitHub repositories


For SEO reasons we will keep the other repositories around, however the long term plan is to remove them and have everything in the main repo. The old repos will link to the new mono repo, therefore all issues and pull requests will be closed and moved over to the fastlane main repo.

# Upgrading fastlane support to the next level 🚀


We took this opportunity to also improve the way we handle issues as a team. Our goal is to be faster and better at responding to all incoming GitHub issues and reviewing pull requests. 

Up until a few months ago, I was managing everything alone, resulting in my not responding to everyone in a timely matter. Thanks to Twitter & Fabric, the fastlane team has grown tremendously in the last few weeks, allowing us to offer world-class help for our thriving community. We want to treat support as a first class citizen and provide the best experience possible.
  

![We’re just getting started: being part of Fabric means a passionate dedicated team to offer the best support & future experience for fastlane customers.](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_56cdf7131d07c013a8455aee_1456338728792__img.jpg_) We’re just getting started: being part of Fabric means a passionate dedicated team to offer the best support & future experience for fastlane customers. 
  

With that in mind, we have a lot of inactive issues and pull requests spanning the last year when I was still working on this project in my free-time. Out of the 829 open issues across all repos, 273 issues haven’t had any activity within the last 3 months. 

After the migration, we will be constantly looking at all issues to make sure the process is improving. We’ll also be commenting on those inactive issues to see if the problem is still happening for those of you who submitted pull requests. This enables us to be much more responsive to new issues and have a better overview on what to focus our time on. 

## The Future
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_56cdf76f20c6473581b7985d_1456338809031__img.jpg_)

This is one of the most impactful changes to fastlane yet. While there’s a lot of information, it’s very important to the entire team to communicate what we are up to. This migration shows our commitment to innovation and creating the future of fastlane.

I’m confident that this change will make yours and our lives much easier and will save us all a ton of time in the future. We’d love your feedback on this, Tweet at us at any time! :) 
