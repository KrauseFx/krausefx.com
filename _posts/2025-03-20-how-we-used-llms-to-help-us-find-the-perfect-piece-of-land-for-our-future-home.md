---
layout: post
title: 'How we used LLMs to help us find the perfect piece of land for our home'
categories: []
tags:
- ai
- llms
- api
- airtable
- bot
- automation
status: publish
type: post
published: true
meta: {}
image: /assets/posts/immo/routexl.png
---

<p style="text-align: center;">
  <img src="/assets/posts/immo/routexl.png" width="500" />
</p>

## Background

My fiancée and I were on the lookout for a piece of land to build our future home. We had some criteria in mind, such as the distance to certain places and family members, a minimum and a maximum size, and a few other things.


## How we started the search

<img align="right" src="/assets/posts/immo/EmailNewsletter.png" alt="Email Newsletter of willhaben.at" width="400px" />

Each country has their own real estate platforms. In the US, the listing's metadata is usually public and well-structured, allowing for more advanced searches, and more transparency in general.

In Austria, we mainly have willhaben.at, immowelt.at, immobilienscout24.at, all of which have no publicly available API.

The first step was to setup email alerts on each platform, with our search criteria. Each day, we got emails with all the new listings


<br />

## The problems

Using the above approach we quickly got overwhelmed with keeping track of the listings, and finding the relevant information. Below are the main problems we encountered:

### Remembering which listings we've already seen

Many listings were posted on multiple platforms as duplicates, and we had to remember which ones we've already looked at. Once we investigated a listing, there was no good way to add notes.

### Marketing fluff from real estate agents

Most listings had a lot of unnecessary text, and it took a lot of time to find the relevant information. 

> [DE] Eine Kindheit wie im Bilderbuch. Am Wochenende aufs Radl schwingen und direkt von zu Hause die Natur entdecken, alte Donau, Lobau, Donauinsel, alles ums Eck. Blumig auch die Straßennamen: Zinienweg, Fuchsienweg, Palargonienweg, Oleanderweg, Azaleengasse, Ginsterweg und AGAVENWEG …. duftiger geht’s wohl nicht.

Which loosely translates to:

> [EN] Experience a picture-perfect childhood! Imagine weekends spent effortlessly hopping on your bike to explore nature's wonders right from your doorstep. With the enchanting Old Danube just a stone's throw away, adventure is always within reach. Even the street names are a floral delight: Zinienweg, Fuchsienweg, Oleanderweg, Azaleengasse, Ginsterweg, and the exquisite AGAVENWEG... can you imagine a more fragrant and idyllic setting

Although the real estate agent's poetic flair is impressive, we're more interested in practical details such as building regulations, noise level and how steep the lot is.

### Calculating the distances to POIs

In Austria, the listings usually show you the distances like this:

> **Children / Schools**
> - Kindergarten <500 m
> - School <1,500 m
> 
> **Local Amenities**
> - Supermarket <1,000 m
> - Bakery <2,500 m

However I personally get very limited information from this. Instead, we have our own list of POIs that we care about, for example the distance to relatives and to our workplace. Also, just showing the air distance is not helpful, as it's really about how long it takes to get somewhere by car, bike, public transit, or by foot.

### Finding the address

99% of the listings in Austria don't have any address information available, not even the street name. You can imagine, within a village, being on the main street will be a huge difference when it comes to noise levels and traffic compared to being on a side street. Based on the full listing, it's impossible to find that information.

The reason for this is that the real estate agents want you to first sign a contract with them, before they give you the address. This is a common practice in Austria, and it's a way for them to make sure they get their commission.

### Visiting the lots

Living in Vienna but searching for plots about 45 minutes away made scheduling viewings a challenge. Even if we clustered appointments, the process was still time-intensive and stressful. In many cases, just seeing the village was often enough to eliminate a lot: highway noise, noticeable power lines, or a steep slope could instantly rule it out. 

Additionally, real estate agents tend to have limited information on empty lots—especially compared to houses or condos—so arranging and driving to each appointment wasn’t efficient. We needed a way to explore and filter potential locations before committing to in-person visits.

## The solution

It became clear that we needed a way to properly automate and manage this process

### A structured way to manage the listings

I wanted a system that allows me to keep track of all the listings we're interested in a flexible manner:

- Support different views: Excel View, Kanban View, Map View
- Have structured data to filter and sort by, and to do basic calculations on
- Be able to attach images and PDFs
- Be able to add notes to each listing
- Be able to manage the status of each listing (Seen, Interested, Visited, etc.)
- Have it be shareable with my fiancée
- Have it be accessible on the go (for the passenger seat)

We quickly found [Airtable](https://airtable.com/) to check all the boxes (Map View is a paid feature):

<img src="/assets/posts/immo/AirtableOverview.png" alt="Airtable" />

### A simple Telegram bot

Whenever we received new listings per email, we manually went through each one and do a first check on overall vibe, price and village location. Only if we were genuinely interested, we wanted to add it to our Airtable.

So I wrote a simple Telegram bot to which we could send a link to a listing and it'd process it for us.

### A way to store a copy of the listings and its images

The simplest and most straightforward way to keep a copy of the listings was to use a headless browser to access the listing’s description and its images.. For that, I simply used the [ferrum](https://github.com/rubycdp/ferrum) Ruby gem, but any similar tech would work. First, we open the page and prepare the website for a screenshot:

<!--more-->

```ruby
browser = Ferrum::Browser.new
browser.goto("https://immowelt.at/expose/123456789") # Open the listing

# Prepare the website: Depending on the page, you might want to remove some elements to see the full content
if browser.current_url.include?("immowelt.at")
  browser.execute("document.getElementById('usercentrics-root').remove()") rescue nil
  browser.execute("document.querySelectorAll('.link--read-more').forEach(function(el) { el.click() })") # Press all links with the class ".link--read-more", trigger via js as it doesn't work with the driver
elsif browser.current_url.include?("immobilienscout24.at")
  browser.execute("document.querySelectorAll('button').forEach(function(el) { if (el.innerText.includes('Beschreibung lesen')) { el.click() } })")
end
```

Once the website is ready, we just took a screenshot of the full page, and save the HTML to have access to it later:

```ruby
# Take a screenshot of the full page
browser.screenshot(path: screenshot_path, full: true)

# Save the HTML to have access later
File.write("listing.html", browser.body)

# Find all images referenced on the page
all_images = image_links = browser.css("img").map do |img| 
  { name: img["alt"], src: img["src"] }
end

# The above `all_images` will contain a lot of non-relevant images, such as logos, etc.
# Below some messy code to get rid of the majority
image_links = image_links.select do |node|
  node[:src].start_with?("http") && !node[:src].include?(".svg") && !node[:src].include?("facebook.com")
end
```

**Important Note:** All data processing was done manually on a case-by-case basis for listings we were genuinely interested in. We processed a total of 55 listings over several months across 3 different websites, never engaging in automated scraping or violating any platforms' terms of service.

### A way to extract the relevant info from a listing

One of the main problems with the listings was the amount of irrelevant text, and being able to find the information you care about, like noise levels, building regulations, etc.

Hence, we simply prepared a list of questions we'll ask AI to answer for us, based on the listing's description:

```ruby
generic_context = "You are helping a customer search for a property. The customer has shown you a listing for a property they want to buy. You want to help them find the most important information about this property. For each bullet point, please use the specified JSON key. Please answer the following questions:"

prompts = [
  "title: The title of the listing",
  "price: How much does this property cost? Please only provide the number, without any currency or other symbols.",
  "size: The total plot area (Gesamtgrundfläche) of the property in m². If multiple areas are provided, please specify '-1'.",
  "building_size: The buildable area or developable area—or the building site—in m². If percentages for buildability are mentioned, please provide those. If no information is available, please provide '-1'.",
  "address: The address, or the street + locality. Please format it in the customary Austrian way. If no exact street or street number is available, please only provide the locality.",
  "other_fees: Any additional fees or costs (excluding broker’s fees) that arise either upon purchase or afterward. Please answer in text form. If no information is available, please respond with an empty string ''.",
  "connected: Is the property already connected (for example, electricity, water, road)? If no information is available, please respond with an empty string ''.",
  "noise: Please describe how quiet or how loud the property is. Additionally, please mention if the property is located on a cul-de-sac. If no details are provided, please use an empty string ''. Please use the exact wording from the advertisement.",
  "accessible: Please reproduce, word-for-word, how the listing describes the accessibility of the property. Include information on how well public facilities can be reached, whether by public transport, by car, or on foot. If available, please include the distance to the nearest bus or train station.",
  "nature: Please describe whether the property is near nature—whether there is a forest or green space nearby, or if it is located in a development, etc. If no information is available, respond with an empty string ''.",
  "orientation: Please describe the orientation of the property. Is it facing south, north, east, west, or a combination? If no information is available, respond with an empty string ''.",
  "slope: Please describe whether the property is situated on a slope or is flat. If it is on a slope, please include details on how steep it is. If no information is available, respond with an empty string ''.",
  "existingBuilding: Please describe whether there is an existing old building on the property. If there is, please include details. If no information is available, respond with an empty string ''.",
  "summary: A summary of this property’s advertisement in bullet points. Please include all important and relevant information that would help a buyer make a decision, specifically regarding price, other costs, zoning, building restrictions, any old building, a location description, public transport accessibility, proximity to Vienna, neighborhood information, advantages or special features, and other standout aspects. Do not mention any brokerage commission or broker’s fee. Provide the information as a bullet-point list. If there is no information about a specific topic, please omit that bullet point entirely. Never say 'not specified' or 'not mentioned' or anything similar. Please do not use Markdown."
]
```

Now we need the full text of the listing. The `ferrum` gem does a good amount of magic to easily access the text without the need to parse the HTML yourself.

```ruby
full_text = browser.at_css("body").text
```

All that's left is to actually access the OpenAI API (or similar) to get the answers to the questions:

```ruby
ai_responses = ai.ask(prompts: prompts, context: full_text)
```

To upload the resulting listing to Airtable I used the [airrecord](https://github.com/sirupsen/airrecord) gem.

```ruby
create_hash = {
  "Title" => ai_responses["title"],
  "Price" => ai_responses["price"].to_i,
  "Noise" => ai_responses["noise"],
  "URL" => browser.url,
  "Summary" => ("- " + Array(ai_responses["summary"]).join("\n- "))
}
new_entry = MyEntry.create(create_hash)
```

For the screenshots, you'll need some additionaly boilerplate code to first download, and then upload the images to a temporary S3 bucket, and then to Airtable using the Airtable API.

Below you can see the beautifully structured data in Airtable (in German), already including the public transit times:

<img src="/assets/posts/immo/AirtableEntry.png" height="500" alt="Airtable Entry" style="border: 1px solid #ccc; margin: 10px;" />

### A way to find the address

The real estate agents usually actively blur any street names or other indicators if there is a map in the listing. There is likely no good automated way to do this. Since this project was aimed at only actually parsing the listings I was already interested in, I only had a total of 55 listings to manually find the address for. 

Turns out, for around 80% for the listings I was able to find the exact address using one of the following approaches: 

**Variant A: Using [geoland.at](https://www.geoland.at/)**

This is approach is Austria specific, but I could imagine other countries will have similar systems in place. I noticed many listings had a map that looks like this:

<img src="/assets/posts/immo/map1.webp" width="400" />

There are no street names, street numbers or river names. But you can see some numbers printed on each lot. Turns out, those are the "Grundstücksnummern" (lot numbers). The number tied together with the village name is unique, so you'll be able to find that area of the village within a minute.

**Variant B: By analysing the angles of the roads and rivers**

<img src="/assets/posts/immo/map2.jpeg" width="350" />

The above map was a tricky one: It's zoomed in so much that you can't really see any surroundings. Also, the real estate agent hides the lot numbers, and switched to a terrain view.

The only orientation I had was the river. This village had a few rivers, but only 2 of them went in roughly the direction shown. So I went through those rivers manually to see where the form of the river matches the map, together with the light green background in the center, and the gray outsides. After around 30mins, I was able to find the exact spot (left: listing, right: my map)

<img src="/assets/posts/immo/map2-solved.jpeg" />

**Variant C: Requesting the address from the real estate agent**

As the last resort, we contacted the real estate agent and ask for the address.

I want to emphasize: this system isn't about avoiding real estate agents, but optimizing our search efficiency (like getting critical details same-day, and not having to jump on a call). For any property that passed our vetting, we contacted the agent and went through the purchase process as usual.

### A way to calculate the distances to POIs

Once the address was manually entered, the Ruby script would pick up that info, and calculate the commute times to a pre-defined list of places using the Google Maps API. This part of the code is mostly boilerplate to interact with the API, and parse its responses.

For each destination we were interested in, we calculated the commute time by car, bike, public transit, and by foot. 

One key aspect that I was able to solve was the "getting to the train station" part. In most cases, we want to be able to take public transit, but with Google Maps it's an "all or nothing", as in, you either use public transit for the whole route, or you don't.

<img src="/assets/posts/immo/commute-time.png" />

More realistically, we wanted to drive to the train station (either by bike or car), and then take the train from there. 

The code below shows a simple way I was able to achieve this. I'm well aware that this may not work for all the cases, but it worked well for all the 55 places I used it for.

```ruby
if mode == "transit"
  # For all routes calculated for public transit, first extract the "walking to the train station" part
  # In the above screenshot, this would be 30mins and 2.3km
  res[:walking_to_closest_station_time_seconds] = data["routes"][0]["legs"][0]["steps"][0]["duration"]["value"]
  res[:walking_to_closest_station_distance_meters] = data["routes"][0]["legs"][0]["steps"][0]["distance"]["value"]

  # Get the start and end location of the walking part
  start_location = data["routes"][0]["legs"][0]["steps"][0]["start_location"]
  end_location = data["routes"][0]["legs"][0]["steps"][0]["end_location"]

  # Now calculate the driving distance to the nearest station
  res[:drive_to_nearest_station_duration_seconds] = self.calculate_commute_duration(
    from: "#{start_location["lat"]},#{start_location["lng"]}", 
    to: "#{end_location["lat"]},#{end_location["lng"]}", 
    mode: "driving")[:total_duration_seconds] 
end
```

### A way to visit the lots without an appointment

Once we had a list of around 15 lots we were interested in, we planned a day to visit them all. Because we have the exact address, there was no need for an appointment.

To find the most efficient route I used the [RouteXL](https://www.routexl.com/). You can upload a list of addresses you need to visit, and define precise rules, and it will calculate the most (fuel & time) efficient route, which you can directly import to Google Maps for navigation.

<img src="/assets/posts/immo/routexl.png" />

While driving to the next stop, my fiancée read the summary notes from the Airtable app, so we already knew the price, description, size and other characteristics of the lot by the time we arrive.

This approach was a huge time saver for us. Around 75% of the lots we could immediately rule out as we arrived. Sometimes there was a loud road, a steep slope, a power line, a noisy factory nearby, or most importantly: it just didn't feel right. There were huge differences in *vibes* when you stand in front of a lot.

We always respected property boundaries - it was completely sufficient to stand in front of the lot, and walk around the area a bit to get a very clear picture.

## Conclusion

After viewing 42 lots in-person on 3 full-day driving trips, we found the perfect one for us and contacted the real estate agent to do a proper viewing. We immediately knew it was the right one, met the owner, and signed the contract a few weeks later.

The system we built was a huge time saver for us, and allowed us to smoothly integrate the search process into our daily lives. I loved being able to easily access all the information we needed, and take notes on the go, while exploring the different villages of the Austrian countryside.

If you're interested in getting access to the code, please reach out to me. I'm happy to share more info, but I want to make sure it's used responsibly and in a way that doesn't violate any terms of service of the platforms we used. Also, it's quite specific to our use case, so it may need some adjustments to work for you.
