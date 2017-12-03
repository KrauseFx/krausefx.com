---
layout: post
title: How to get started contributing to open source projects
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

Submitting code to an open source project can be a very scary feeling. When I submitted my first pull request I was scared. Scared that I’m doing something wrong. Scared that my patch wasn’t useful. Scared that other developers would make fun of me. 

I slowly worked my way up, from submitting smaller contributions to random open source projects, to then publishing my first open source library [TSMessages](https://github.com/krausefx/tsmessages), to finally building and releasing [fastlane](https://fastlane.tools), an open source project that is now being used by tens of thousands of companies.

I want to encourage more people to get started contributing to open source projects, this blog post will show you how important open source software is in today's world, and how it can help you grow as an engineer.

## Why developers and companies use open source software


### 👴 Project stays alive much longer


How often did you use a proprietary software solution, only to discover that the service is discontinued a few months after you’re fully ramped up?

Open source projects can be more robust in regards of maintenance, because there isn’t a single company that can decide to stop working on the project. Instead you have a group of maintainers that invest time and resources into a given software. Even if nobody has access to the code repository, developers can fork the project, and push it forward. This is something that I’ve done myself multiple times for dependencies we have in fastlane.

### 🔧 Independence: you can fix problems yourself


What happens if you use a commercial software and you run into a blocking issue with it? You’ll have to reach out to the support team, and hope they take your problem seriously and provide a fix for you. If the product was shut down, you’ll probably have no chance of getting any help at all.

With open source projects you are in full control over the software you run: You can dive into the source code, make changes and run those changes in your code base directly, without the original author’s approval. Even if a project is not being maintained any more, you can still not only use the open source software, but also fix issues and extend its feature sets.

### 🤝 Trust


What closed source binaries do you include in your mobile app? Each of them adds a risk for your app and your users, as it adds multiple attack surfaces. You cannot tell what the binary does, it could be malicious, it could collect data you don’t want to track, it could call home without you knowing, it might have bugs causing other areas of the app to be slowed down or even crash, a [man-in-the-middle attack](https://en.wikipedia.org/wiki/Man-in-the-middle_attack) might modify the binary while you download it, or the download server gets hacked as it happened with [XcodeGhost](https://en.wikipedia.org/wiki/XcodeGhost) just last year. A closed source binary as part of your build phase might even go as far as uploading your app’s source code, secret keys and other data from your local machine. Some of these problems also apply to open source projects, however you do have more control over them. You can fork the project, audit the code, and then periodically merge it with the upstream repository after auditing the changes.

There are multiple approaches to fix man-in-the-middle attacks and future XcodeGhosts, like checking the code signing of the app and comparing the hashes, however you’ll never be able to tell what the binary does under the hood.

### 📖 Knowledge sharing


Open source code enables every person on the planet with access to a computer and internet to read your code and learn from it. This is extremely powerful and isn’t done in a lot of areas. For example when studying physics, you’ll soon notice how many papers and critical information are hidden behind paywalls or kept secret by the author.

Artsy is a great example: [their apps are open source](https://github.com/artsy), so when someone asks one of the engineers how they do X, they can just link to the source code.

### 🛠 Open source build tools


Since I’m working on developer tooling most of the time, I’m thinking a lot about how essential they are for a team to be productive. If they don’t work, you can’t ship to your users. Being in control of your most important infrastructure pieces is crucial to making sure you’re not dependent on third parties when :poo: hits the fan.

No matter if you work on mobile apps or something else, very often there are services that promise to take all the heavy lifting for you by providing a proprietary, hosted software solution. This is great if you are starting out, however, by relying on this kind of solution you accumulate technical debt that you will have to fix in the future.

With your business critical infrastructure pieces (which includes build and deploy tools) you’ll want to have the knowledge of how they work, and ideally the opportunity to fix problems and customize the setup to fit your needs. If something doesn’t work you can dive into the code base, analyze the error, and fix the problem. This might not be as relevant for indie developers, but for bigger companies with dozens or hundred of engineers depending on the build and release process, it is important to be able to fix systems as soon as they break.

## Why contribute to open source projects?

Using open source software is awesome, but why would you care about working on one? 

### 📈 Scale of impact


It’s hard to imagine the impact you can have on developers all around the world when working on open source projects. 

You can have this kind of impact, either by working on an existing open source project, or also by open sourcing some code you wrote. Who knows, it might be the next big thing :)

#### 🤔 How did I get started with open source?


The first time I got into open source, is actually when I open sourced my first project called "TSMessages". When I was showing my little app to [Matthias](https://twitter.com/myell0w) at CocoaHeads in Vienna, he asked me if I can open source the custom notification bars I built. I didn’t know a lot about open source back then, but Matthias was kind enough to help me with the process.

At the time of release [TSMessages](https://cocoapods.org/pods/TSMessages) had 2 classes and less than 400 lines of code. Within the next months more and more people started using it, resulting in a total of over a million downloads. Currently the project is actively being used by [13,000 apps](https://cocoapods.org/pods/TSMessages).

Without me having to put in extra work, I didn’t only use TSMessages for all my personal apps, but helped 13,000 other companies to show better notifications in their apps.

#### Impact with fastlane


[fastlane](https://fastlane.tools) started as my [Bachelor project](https://github.com/krausefx/evaluation_report), where I put the code on GitHub after completing the first tool deliver. One tool led to another, resulting in the fastlane umbrella tool, containing 17 standalone tools, 170 built-in actions, and 180 third party plugins. Today fastlane has saved over 9,000,000 developer hours and is used by tens of thousands of companies around the world.

I never expected the project to grow this big. It started by only solving the problems I had as an iOS developer. No matter how small you think a script or tool is, it will probably help other developers out there who face the same challenges. Only 9 months after releasing the first version, fastlane joined Twitter, and I helped build a team around fastlane. Today, fastlane is a 6 person team based in San Francisco and Boston and is moving faster than ever.

### 👩‍💻 Career & Jobs


2 years ago, I didn’t know a single person working at one of the big tech companies. All the tech giants were a closed bubble for me coming from Europe, I couldn’t ask someone how it is to work there, I didn’t have anyone to refer me, I didn’t know how the companies are structured. After moving to San Francisco, working for Twitter, and now Google I have a much better sense of how things work. 

If you’re in the same position I was 2 years ago, and you’re thinking about working at Google, Facebook, or similar, one of the best ways to get in touch with someone there is to contribute to one of the company’s open source projects.

Larger companies that own open source projects, not always have the necessary resources to maintain all aspects of them. The organizations are happy about external maintainers, and depending on the team behind it, you might receive an email sooner or later :) 

### 📃 Resume

Listing open source contributions in your CV is powerful. It shows engagement in the developer community, and that you’re potentially familiar with established tooling and frameworks in your field. Depending on your contribution, it demonstrates that you can navigate around in an existing code base, identify an issue, debug and fix problems, or extend the project’s feature set. The majority of engineers use open source software for their projects, however only a small percentage also contribute. It’s definitely a great plus point for every resume.

### 👍 To sum up

* Learn new technology
* Improve a project you use
* Pimp your resume
* Collaborate with people you would otherwise never work with
* Your code could end up being used by millions of users (literally)
* Internet points: the maintainers might tweet about your contributions
* Many projects attribute their contributors on their website, or changelog - this has the nice side effect of boosting your personal search engine visibility also, especially if your name is common

## How to get started with open source

Hopefully I got you interested in contributing to open source software, so the next question is, how do you best get started?

### 📢 Subscribe to a repo you’re interested in

By subscribing to notifications of an open source repo, you’ll get a good sense of what the community is like, what problems the contributors are facing, and where you can jump in to help. After a few weeks of being active, you’ll get a good sense of what the community is working on and how you can help.

### 🤠 Don't be discouraged, try contributing, people will help you


It’s scary submitting your first pull request to a new project. Some projects might not be looking for new contributors, so it’s a good idea to subscribe to a project before starting to contribute, so you get a feel on what the community is like. 

With 
[fastlane](https://fastlane.tools), we welcome all new contributors, mention every single one 
[in the release notes](https://github.com/fastlane/fastlane/releases/tag/2.54.1) by name, and after successfully getting multiple PRs merged and helping other people, we promote them to 
[core contributors](https://github.com/fastlane/fastlane/blob/master/CORE_CONTRIBUTOR.md). 

### 🚌 Contribute to projects that are widely used, but have a low bus factor


There is a lot of open source software that’s being used by hundreds of thousands of projects, but only have a single maintainer. Often those projects are so foundational of everything in an ecosystem, that people forget it exists. This is your chance to go through the 
[list of projects](https://libraries.io/bus-factor) with the worst bus factor and jump in and help.

> The "bus factor" is the minimum number of team members that have to suddenly disappear from a project before the project stalls due to lack of knowledgeable.

[Source: Wikipedia](https://en.wikipedia.org/wiki/Bus_factor)

One example of where things went really wrong was the left-pad project, a tiny JavaScript library that was maintained by a single person, that 
[broke thousands of projects](https://www.theregister.co.uk/2016/03/23/npm_left_pad_chaos/).

### 👪 How to join the development team of open source projects


Becoming a core contributor of a project very much depends on the size of the project:

* Hyper-scale open source projects (e.g. Swift, React Native): It’s going to be pretty difficult to stand out, as there are hundreds of active maintainers, and it’s hard to tell how actively the owners of the repo monitor the activity of contributors. Very often, those kinds of projects have mailing lists you can join.
* Projects that are popular and the go-to solution in its field (e.g. devise, CocoaPods, fastlane): Those projects are a great opportunity to have extremely high impact on other developers, while still having a rather small core development team. 
* Low bus factor projects (see bus factor list): It’s rather easy and informal to join the development team. It’s usually enough to ping the current maintainer and ask about the plans for the project, and how you can help.

For many developers, the most interesting category is the second one: You can have a lot of impact within a short amount of time, get visibility and you have the chance to join a welcoming community and it’s a great opportunity to learn from fellow developers.

### 🚀 Getting started


Sometimes it’s not so clear on how to get started, so here are some tips on what you can do in no specific order

* Helping out with an open source project is usually rather informal, often it’s enough to submit a smaller pull request
* Look at some older issues and pull requests, and see if you can help get them resolved
* See if there is a Slack group, Gitter or email group you can join to see what the core team talks about
* Read through the documentation and guides to see if there are parts that aren’t clear and need updating
* Most projects at this size will have a [CONTRIBUTING.md file](https://github.com/fastlane/fastlane/blob/master/CONTRIBUTING.md) that explains how to get started with contributing code, and helping users
* There might be additional documentation on how the project is structured and where to get started
* Many projects will have outdated documentation, it’s a great chance for you to get some "internet points" by improving those
* Adding more tests to existing projects gives you great visibility on how the project works, while at the same time making the maintainers very happy. Unit tests are often self-contained, making it easy for you to add them.
* Subscribe to the repo to see how the community members interact with each other, and get a sense of what problems the project is facing
* Some projects have a "[you-can-do-this](https://github.com/fastlane/fastlane/labels/complexity%3A%20you%20can%20do%20this)", "help-wanted" or "beginner-friendly" GitHub labels, that are usually simpler fixes with some instructions provided by the maintainers.
* There might be monthly video calls to align the whole development team
* Onboard the project from a new user’s perspective, and see if there are any rough edges you could improve
* The core team might be active on social networks like Twitter, make use of them
* If you have an idea on how you can improve the project, submit an issue first to get feedback from the core team before spending time on building it. This is especially important if it’s a new feature that will need to be maintained in the future. Don’t forget to look if an issue for this specific idea was already created.

The most important piece is to get out there and submit pull requests, the rest will happen automatically.

## 🎁 Wrapping up

Developers and companies become more and more aware of how important it is for their dependencies to be in open source, not only to see what’s happening under the hood, but also to be able to fix problems themselves or even run their own fork if needed. This is especially relevant for build and deployment tools, but also third party SDKs you ship with your app. 

It has never been easier to get started contributing to open source, all it takes is a computer with internet access. As an engineer, it’s a great move for your career to get involved in open source communities: You have great impact outside of your usual work scope and have the chance to work with people you’d never otherwise work with!

If you’re still unsure, and need help getting started with your first contribution, please send me a private message on 
[Twitter (@KrauseFx)](https://twitter.com/KrauseFx), I’m more than happy to help wherever I can 👍

****

Shoutout to my friends who helped me with this blog post: [@orta](https://twitter.com/orta), [@hemal](https://twitter.com/hemal), [@schukin](https://twitter.com/schukin), [@_caro_n](https://twitter.com/_caro_n), [@acrooow](https://twitter.com/acrooow), [@sebmasterkde](https://twitter.com/sebmasterkde) and [@domysee](https://twitter.com/domysee).
