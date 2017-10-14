---
layout: post
title: Run Xcode 7 UI Tests from the command line
categories: []
tags:
- UI Tests
- User
- Interface
- Xcode
- '7'
- iOS 9
status: publish
type: post
published: true
meta: {}
---

### Get started with UI Tests to automate User Interface tests in iOS 9


Apple announced a new technology called 
UI Tests, which allows us to implement User Interface tests using Swift or Objective C code. Up until now the best way to achieve this was to use UI Automation. With 
UI Tests it's possible to properly debug issues using Xcode and use Swift or Objective C without having to deal with JavaScript code.

First, you'll have to create a new target for the UI Tests:
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5582724de4b043e244cee6da_1434612307903__img.png_)
  


Under the 
Test section, select the 
Cocoa Touch UI Testing Bundle:
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_55827527e4b0472245d306c9_1434613037861__img.png_)
  


Now open the newly created 
Project_UI_Tests.swift file in your 
Project UI Tests folder. On the bottom you have an empty method called 
testExample. Focus the cursor there and click on the red record button on the bottom.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5582755ae4b0a5db48a7ae52_1434613085131__img.png_)
  


This will launch your app. You can now tap around and interact with your application. When you're finished, click the red button again. 
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_558275f7e4b0be63c47a3823_1434613247689__img.png_)
  


The generated code will look similar to this. I already added some example 
XCTAsserts between the generated lines. You can now already run the tests in Xcode using 
CMD+
U. This will run both your unit tests and your UI Tests.

You could now already run the tests using the CLI without any further modification, but we want to have the UI Tests in a separate scheme. Click on your scheme and select 
New Scheme.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_55827650e4b043e244cef13d_1434613331340__img.png_)
  


Select the newly created UI Test target and confirm.
  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_558276a3e4b0f09e120af58f_1434613414825__img.png_)
  


If you plan on executing the tests on a CI-server, make sure the newly created scheme has the 
Shared option enabled. Click on your scheme and choose 
Manage Schemes to open the dialog.

## Launch the tests from the CLI


It's important to also define the version of Xcode to use, in our case that's the latest beta:


export DEVELOPER_DIR="/Applications/Xcode-beta.app"


You can even make the beta version your new default by running


sudo xcode-select --switch "/Applications/Xcode-beta.app"

Example output when running UI Tests from the terminal:

# Generating Screenshots


No extra work needed, you get screenshots for free. By appending the 
derivedDataPath option to your command, you tell Xcode where to store the test results including the generated screenshots.


  
      
![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_55828e88e4b0dd959fce10f8_1434619538440__img.png_)
  


Xcode will automatically generate screenshots for each test action. For more information about the generated data, take a look at 
[this writeup by Michele](http://michele.io/test-logs-in-xcode).

## Next Steps


To create screenshots in all languages and in all device types, you need a tool like 
[snapshot](https://fastlane.tools/snapshot). snapshot still uses UI Automation, which is 
[now deprecated](https://twitter.com/3lvis/status/609333789874106368).

I'm currently working on a new version of 
[snapshot](https://fastlane.tools/snapshot) to make use of the new UI Tests features. This enables snapshot to show even more detailed results and error messages if something goes wrong. I'm really excited about this change 👍

**Update: **
[snapshot](https://fastlane.tools/snapshot) now uses UI Tests to generate screenshots and the HTML summary for all languages and devices.
