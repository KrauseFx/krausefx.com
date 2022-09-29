---
layout: post
title: Writing automated tests for your documentation
categories: []
tags:
- fastlane
- tests
- automated
- docs
status: publish
type: post
published: true
meta: {}
---

The 2 favourite topics of every engineer are usually unit tests and documentation. The last few weeks I've put some thoughts in how to combine those two things for the ultimate developer joy.

Why should I write tests for my documentation? 

* You might forget to update parts of the documentation when you update your API or interface
* Spelling mistakes happen in code samples
* You want to make sure you don't introduce any regressions with a new release

With the launch of the new [docs.fastlane.tools](https://docs.fastlane.tools) website, we took the time to set up a proper documentation system based on markdown files, converted to a static HTML page using [MkDocs](http://www.mkdocs.org/). By having full control over the generated HTML code, and going 100% open source on GitHub, you can do powerful things:

* Fail the build when a page got removed from the index using [danger](http://danger.systems) (see [Dangerfile](https://github.com/fastlane/docs/blob/master/Dangerfile))
* Generate redirects when a page got moved (see [generate_redirects.rb](https://github.com/fastlane/docs/blob/master/scripts/ci/generate_redirects.rb) and [available_redirects.rb](https://github.com/fastlane/docs/blob/master/scripts/ci/available_redirects.rb))
* Make sure the repo is in a valid states, and all documentation follows the convention
* Write tests for your documentation

## Tests for documentation, what does this even mean?

Just like with your actual code base, you want to be sure that your repository is in a valid state. The same applies for your documentation. Is your latest documentation up to date, and does it work as expected? Does it work with your latest release?

The first time I thought about running tests for documentation I thought only about the code samples. However you can write tests for a lot of more things. For example you want to ensure that all your assets are in the right sub-directory, that all referenced images and markdown files are available and follow your naming scheme.

Some examples of what you can do:

### Validate file names

Ensure that all file names follow your convention - this is especially important if the file names are visible in the URL.

```ruby
private_lane :ensure_filenames do
  UI.message "🕗  Making sure file names are all lowercase..."
  Dir["docs/**/*.md"].each do |current_file|
    if current_file =~ /[A-Z]/
      UI.user_error!(".md files must not be upper case, use a dash instead (file '#{current_file}')")
    end
  end
  UI.success "✅  All doc files are properly named to not be camel case"
end
```

### Ensure every page has a header

[fastlane docs](https://docs.fastlane.tools) require a title on each page to be consistent.

```ruby
private_lane :ensure_headers do
  UI.message "🕗  Investigating all docs files and their headers..."
  exceptions = ["docs/index.md"]

  Dir["docs/**/*.md"].each do |current_file|
    next if exceptions.include?(current_file)
    unless File.read(current_file).start_with?("#"))
      UI.user_error!("File '#{current_file}' doesn't start with #"
    end
  end
  UI.success "✅  All doc files start with a header"
end
```

### Ensure all image assets are available and in the correct folder

Automatically verify all referenced image assets are available and stored in the right folder, find the source 
[here](https://github.com/fastlane/docs/blob/c1a551d345756d3b2023c4ca629bb2f7ac9d1406/fastlane/Fastfile#L67-L113).

### Ensure spelling of certain words

Recently we switched from `fastlane` to _fastlane_ in markdown files, so we want to ensure all new docs use the new way of spelling.

```ruby
private_lane :ensure_tool_name_formatting do
  UI.message "🕗  Verifying tool name formatting..."
  require 'fastlane/tools'

  Dir["docs/**/*.md"].each do |path|
    content = File.read(path)
    Fastlane::TOOLS.each do |tool|
      if content.include?("`#{tool}`")
        UI.user_error!("Use _#{tool}_ instead of `#{tool}` to mention a tool in the docs in '#{path}'")
      end

      if content.include?("_#{tool.to_s.capitalize}_") || content.include?("`#{tool.to_s.capitalize}`")
        UI.user_error!("fastlane tools have to be formatted in lower case: #{tool} in '#{path}'")
      end
    end
  end
  UI.success "✅  fastlane formatting is correct"
end
```

## Verify code samples

How many times have you copied a code sample to try it out, just to find out it doesn't work with the latest release? There are various reasons for this, and without tests there is almost no way to avoid this. The error can be as simple as a spelling mistake.

By having full control over your documentation, you can easily iterate over all your code samples, and make sure they work as expected.

For [fastlane](https://fastlane.tools) we found 28 errors just in the [actions documentation](https://docs.fastlane.tools/actions/), most commonly syntax errors or just simple spelling mistakes in parameter names.

For all the checks mentioned below, the source is on the [fastlane docs repo](https://github.com/fastlane/docs/blob/master/fastlane/actions/test_sample_code.rb).
      
### Catch syntax errors in code samples

![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5817c1e42994ca082108fc0d_1477951976150__img.png)


Nothing is more frustrating than copying a code sample and having to fix the syntax to make it work. Most users won't spend the time to look into how they can contribute to your docs to fix the error.

### Catch unavailable actions or methods

![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5817c285197aea1a94bcc18f_1477952138871__img.png)

For fastlane most code samples call certain actions or integrations. Using tests we ensure that this action is available and correctly spelled.      

### Verify action parameters

![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5817c33b893fc0c77e1ed440_1477952319091__img.png)

Most fastlane actions allow passing of named parameters. We now automatically verify that all parameters are available to use.


### Verify parameter types

![](/squarespace_images/static_545299aae4b0e9514fe30c95_54529a29e4b025a90f45cc50_5817c493b8a79b7befea0fdf_1477952663470__img.png)

Every fastlane parameter has a type defined, which fastlane validates on run-time. It's easy to get a type wrong in the documentation, so we now validate those too.
 

## When to run tests for your docs?


There are 2 points where you want to verify your docs are valid and up to date:

* When you push a new release of your software ([deploy script of your software](https://github.com/fastlane/fastlane/blob/07baac7d27aab54a622d6d01942066b008e40c5f/fastlane/fastlane/Fastfile#L231-L232))
* When you update your documentation ([CI test script of your docs](https://github.com/fastlane/docs/blob/a1b3792d7bbc8a38524790b1f2e3e18bf7de6dc2/fastlane/Fastfile#L10))

So whatever introduced a regression, the build will be failing and you can't merge the change into master.

## Where to go next

These are just some things you can do with tests for your documentation, however I'm sure there are so many things you can automatically test and verify every time your code changes. Let me know if you have any ideas on what other crazy things you can do.
