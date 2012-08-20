# README

_Eprayim_ is a simple & sometimes naive markup languange which inspired by Markdown, txt2tags and so on. It reads markups and coverts them into HTML. 

In the beginning when I was a young boy whom had never heard Markdown, it's a nightmare for me to write documents. So when I decided to start a translation project, I reinvented the wheel. It's quick and dirty, but works for myself. After years, when I wanna review my documents, my wheel kicked my ass.

So the wheel is re-reinvented.

## Installation

```
gem i eprayim
```

## Usage

```ruby
require 'eprayim'

doc = Eprayim::Doc.new('hello _world_')
doc.to_html # => 'hello <em>world</em>'
```

## Grammar

### Inline Elements

+ `*bold*`: **bold**
+ `**strong**`: **strong**
+ `_italic_`: *italic*
+ `~deleted~`: <del>deleted</del>
+ \`inline code\`: `inline code`

And you may use backslash escapes for the following characters:

    \ ` * + _ ~ 

**Links**

    [http://google.com] 
    [Github http://github.com]
    [Github Flavored Markdown http://github.github.com/github-flavored-markdown/]

**Images**

    [!http://fleurer-lee.com/lyah/img/splash.png]
    [!image with alt http://fleurer-lee.com/lyah/img/splash.png]
    [^http://fleurer-lee.com/lyah/img/splash.png] # image floats in left
    [$http://fleurer-lee.com/lyah/img/splash.png] # image floats in right

### Block Elements 

**Headings**

    = H1 
    == H2
    === H3
    ==== H4
    ===== H5
    ====== H6

You can specify an anchor to each heading, it will be referenced by links when generating TOC. Just like:

    == 第一章 飞拉圣经 #the-ramen-bible
    === 第一节 莫西八戒 #the-eight

**Paragraph**

A paragraph is simply one or more consecutive lines of text, separated by one or more blank lines. 

**Quotes**

Quotes is just the same as Markdown: 

    > I'd really rather you didn't act like a sanctimonious holier-than
    > -thou ass when describing my noodly goodness. If some people  
    > don't believe in me, that's okay. Really, I'm not that vain.  
    > Besides, this isn't about them so don't change the subject. 

**Codes**

    ```
    def hello():
        'world'
    end
    ```

**Ordered List**

    + I'd really rather you didn't act like a sanctimonious holier-than-thou ass when describing my noodly goodness. 
      If some people don't believe in me, that's okay.
    + I'd really rather you didn't use my existence as a means to oppress, subjugate, punish, eviscerate, and/or, you know, be mean to others. 
      I don't require sacrifices, and purity is for drinking water, not people. 

The nested list is not supported yet :(

**Unordered List**

    * I'd really rather you didn't challenge the bigoted, misogynistic, hateful ideas of others on an empty stomach. Eat, then go after the bastards. 
    * I'd really rather you didn't go around telling people I talk to you. You're not that interesting. Get over yourself. And I told you to love your fellow man, can't you take a hint? 
