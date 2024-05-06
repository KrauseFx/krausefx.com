---
layout: post
title: 'How to train your first machine learning model and run it inside your iOS app via CoreML'
categories: []
tags:
- ios
- context
- sdk
- swift
- coreml
- machine learning
- sklearn
- mlmodel
status: publish
type: post
published: true
meta: {}
image: /assets/posts/ios-ml/header-1.jpg
---

<img src="/assets/posts/ios-ml/header-1.jpg">

**Note:** This is a cross-post of the original publication on [contextsdk.com](https://contextsdk.com/blog/how-to-train-your-first-machine-learning-model-and-run-it-inside-your-ios-app-via-coreml).

## Introduction

Machine Learning (ML) in the context of mobile apps is a wide topic,
with different types of implementations and requirements. On the highest
levels, you can distinguish between:

1.  Running ML models on server infrastructure and accessing it from
    your app through API requests
2.  Running ML models on-device within your app (we will focus on this)
3.  Fine-tuning pre-trained ML models on-device based on user behavior
4.  Training new ML models on-device

As part of this blog series, we will be talking about variant 2: We
start out by training a new ML model on your server infrastructure based
on real-life data, and then distributing and using that model within
your app. Thanks to Apple’s CoreML technology, this process has become
extremely efficient & streamlined.

We wrote this guide for all developers, even if you don’t have any prior
data science or backend experience.

## Step 1: Collecting the data to train your first ML model

To train your first machine learning model, you’ll need some data you
want to train the model on. In our example, we want to optimize when to
show certain prompts or messages in iOS apps.

Let’s assume we have your data in the following format:

<img src="/assets/posts/ios-ml/image2.png" />

- **Outcome** describes the result of the user interaction, in this
  case, if they purchased an optional premium upgrade
- **Battery Level** is the user’s current battery level as a float
- **Phone Charging** defines if the phone is currently plugged in as a
  boolean

In the above example, the “label” of the dataset is the **outcome**. In
machine learning, a label for training data refers to the output or
answer for a specific instance in a dataset. The label is used to train
a supervised model, guiding it to understand how to classify new, unseen
examples or predict outcomes.

How you get the data to train your model is up to you. In our case, we’d
collect non-PII data just like the above example, to train models based
on real-life user behavior. For that we’ve built out our own backend
infrastructure, which we’ve already covered in our Blog:

- [Building the Infrastructure to Ingest 40m Context Events per
  Day](https://contextsdk.com/blog/building-the-infrastructure-to-ingest-40m-context-events-per-day)
- [Unifying Data Models Across a Heterogeneous
  Stack](https://contextsdk.com/blog/unifying-data-models-across-a-heterogeneous-stack)

## Step 2: Load and prepare your data

There are different technologies available to train your ML model. In
our case, we chose Python, together with pandas and sklearn.

Load the recorded data into a pandas DataFrame:

```python
import pandas as pd

rows = [
    ['Dismissed', 0.90, False],
    ['Dismissed', 0.10, False],
    ['Purchased', 0.24, True],
    ['Dismissed', 0.13, True]
]
data = pd.DataFrame(rows, columns=['Outcome', 'Battery Level', 'Phone Charging?'])
print(data)
```

Instead of hard-coded data like above, you’d access your database with
the real-world data you’ve already collected.

## Step 3: Split the data between training and test data

To train a machine learning model, you need to split your data into a
training set and a test set. We won’t go into detail about why that’s
needed, since there are many great resources out there that explain the
reasoning, like this excellent [CGP Video](https://www.youtube.com/watch?v=R9OHn5ZF4Uo).

```python
from sklearn.model_selection import train_test_split

X = data.drop("Outcome", axis=1)
Y = data["Outcome"]

X_train, X_test, Y_train, Y_test = train_test_split(X, Y, test_size=0.2, shuffle=True)
```

The code above splits your data by a ratio of 0.2 (⅕) and separates the
X and the Y axis, which means separating the label ("Outcome") from the
data (all remaining columns).

## Step 4: Start Model Training

As part of this step, you’ll need to decide on what classifier you want
to use. In our example, we will go with a basic RandomForest classifier:

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report

classifier = RandomForestClassifier()
classifier.fit(X_train, Y_train)
Y_pred = classifier.predict(X_test)
print(classification_report(Y_test, Y_pred, zero_division=1))
```

The output of the above training will give you a classification report. In simplified words, it will tell you more of how accurate the trained
model is.

<img src="/assets/posts/ios-ml/image3.png" />

In the screenshot above, we’re only using test data as part of this blog
series. If you’re interested in how to interpret and evaluate the
classification report, check [out this guide](https://medium.com/@chanakapinfo/classification-report-explained-precision-recall-accuracy-macro-average-and-weighted-average-8cd358ee2f8a)).

## Step 5: Export your model into a CoreML file

Apple’s official [CoreMLTools](https://apple.github.io/coremltools/docs-guides/)
make it extremely easy to export the classifier (in this case, our
Random Forest) into a .mlmodel (CoreML) file, which we can run on
Apple’s native ML chips. CoreMLTools support a variety of classifiers,
however not all of them, so be sure to verify its support first.

```python
import coremltools

coreml_model = coremltools.converters.sklearn.convert(classifier, input_features="input")
coreml_model.short_description = "My first model"
coreml_model.save("MyModel.mlmodel")
```

### Step 6: Bundle the CoreML file with your app

For now, we will simply drag & drop the CoreML file into our Xcode
project. In a future blog post we will go into detail on how to deploy
new ML models over-the-air.

<img src="/assets/posts/ios-ml/image1.png" style="width: 300px" />

Once added to your project, you can inspect the inputs, labels, and
other model information right within Xcode.

<img src="/assets/posts/ios-ml/image5.png" />

<img src="/assets/posts/ios-ml/image4.png"/>

## Step 7: Executing your Machine Learning model on-device

Xcode will automatically generate a new Swift class based on your
mlmodel file, including the details about the inputs, and outputs.

```swift
let batteryLevel = UIDevice.current.batteryLevel
let batteryCharging = UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
do {
    let modelInput = MyModelInput(input: [
       Double(batteryLevel),
       Double(batteryCharging ? 1.0 : 0.0)
    ])
    let result = try MyModel(configuration: MLModelConfiguration()).prediction(input: modelInput)
    let classProbabilities = result.featureValue(for: "classProbability")?.dictionaryValue
    let upsellProbability = classProbabilities?["Purchased"]?.doubleValue ?? -1

    print("Chances of Upsell: \(upsellProbability)")
} catch {
    print("Error running CoreML file: \(error)")
}
```

In the above code you can see that we pass in the parameters of the
battery level, and charging status, using an array of inputs, only
identified by the index. This has the downside of not being mapped by an
exact string, but the advantage of faster performance if you have
hundreds of inputs.

Alternatively, during model training and export, you can switch to using
a String-based input for your CoreML file if preferred.

We will talk more about how to best set up your iOS app to get the best
of both worlds, while also supporting over-the-air updates, dynamic
inputs based on new models, and how to properly handle errors, process
the response, manage complex AB tests, safe rollouts, and more.

### Conclusion

In this guide we went from collecting the data to feed into your Machine
Learning model, to training the model, to running it on-device to make
decisions within your app. As you can see, Python and its libraries,
including Apple’s CoreMLTools, make it very easy to get started with
your first ML model. Thanks to native support of CoreML files in Xcode,
and executing them on-device, we have all the advantages of the Apple
development platform, like inspecting model details within Xcode, strong
types and safe error handling.

In your organization, you’ll likely have a Data Scientist who will be in
charge of training, fine-tuning and providing the model. The above guide
shows a simple example - with ContextSDK we take more than 180 different
signals into account, of different types, patterns, and sources,
allowing us to achieve the best results, while keeping the resulting
models small and efficient.

Within the next few weeks, we will be publishing a second post on that
topic, showcasing how you can deploy new CoreML files to Millions of iOS
devices over-the-air within seconds, in a safe & cost-efficient manner,
managing complicated AB tests, dynamic input parameters, and more.

**Note:** This is a cross-post of the original publication on [contextsdk.com](https://contextsdk.com/blog/how-to-train-your-first-machine-learning-model-and-run-it-inside-your-ios-app-via-coreml).
