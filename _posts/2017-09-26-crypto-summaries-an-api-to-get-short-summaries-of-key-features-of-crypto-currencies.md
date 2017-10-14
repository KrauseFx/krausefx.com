---
layout: post
title: 'Crypto-Summaries: An API to get short summaries of key features of crypto
  currencies'
categories: []
tags: []
status: publish
type: post
published: true
meta: {}
---

While working on crypto currency automation over the last weeks, I noticed that one of the best known websites 
[coinmarketcap.com](https://coinmarketcap.com/) lists all the coins and some basic information, but not a description or tags of what each coin does.

One of my cryptocurrency bots will send me summaries of its trading activities every day, with a list of coins and the amounts invested, however I usually was interested what those coins do, and why they exist.

I'm not sure how many developers face this issue, but I decided to build and publish a side project of my side project, it's called Crypto-Summaries and it's available on 
[GitHub](https://github.com/KrauseFx/crypto-summaries).

Here are some examples of how to use the API (for the most up to date docs, please 
[open the GitHub repo](https://github.com/KrauseFx/crypto-summaries))

### Access the summary of Bitcoin:


***1 line summary**
: 
[https://krausefx.github.io/crypto-summaries/coins/btc-1.txt](https://krausefx.github.io/crypto-summaries/coins/btc-1.txt)


***3 lines summary**
: 
[https://krausefx.github.io/crypto-summaries/coins/btc-3.txt](https://krausefx.github.io/crypto-summaries/coins/btc-3.txt)


***5 lines summary**
: 
[https://krausefx.github.io/crypto-summaries/coins/btc-5.txt](https://krausefx.github.io/crypto-summaries/coins/btc-5.txt)

Alternatively you can also use the name of the coin instead of symbol

***3 lines summary**
: 
[https://krausefx.github.io/crypto-summaries/coins/bitcoin-3.txt](https://krausefx.github.io/crypto-summaries/coins/bitcoin-3.txt)

The goal is to have a community maintained description of crypto currencies, maybe one day even support for tags, so you could filter for e.g. gaming coins. 
