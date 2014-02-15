---
layout: class
week: 4
title: Putting the Pieces Together + Some Journalism
---

We'll try to form something closer a coherent whole out of what we've done so far. And then practice interviewing spreadsheets.

## Housekeeping
- Sign up for a critique date, in twos or threes on the [wiki](https://github.com/kpq/nyu-data-journalism-2014/wiki/Critique-Schedule)


## Critique: 
Lilah and Erin are critiquing [tk](http://link.com).

## Discussion: 
- The reading you did.
- The Data Journalism Handbook includes a nice list of [types of data journalism stories.](http://datajournalismhandbook.org/1.0/en/understanding_data_5.html)


## Putting the pieces together

<img src="child-care.png" style="width:80%; margin-left:10%">

Here is some data on <a href = "child-care-costs.xlsx">child care costs</a>. Let’s pretend we want to make a map to help with our analysis.

- Format the data to be ready for analyis, and possible merging with other datasets. This means the first row has headers, ideally without any spaces or special characters, and the state names are as normal as possible. A hint: you may want to google something like "replace asterisks in excel." 

- Remember [this guy](http://bl.ocks.org/ansis/9368682874d9e8adda21)? Copy the code to your text editor, and reaqquaint yourself with how the colors get assigned.

- On the first line of the getStyle function add the following: <code>console.log(feature.properties)</code>

- Turn your data into JSON properties with [Mr. Data Converter](http://shancarter.github.io/mr-data-converter/). 

- In your code, add <br><code>var childCare = </code> and the result from Mr. Data Converter. 

- After that, add <br><code>var childCareDict  = {};</code><br> and <br><code>
childCare.forEach( function(row) { childCareDict[row.state] = row.child });</code><br>
where you use whatever header name you used in row.child. 

- Adjust your colors and fix your rollover, and your key. [ColorBrewer](http://colorbrewer2.org/) is a good resource for map palettes. Here's [a good place](http://www.macwright.org/2013/02/18/literate-jenks.html) to start when thinking about breaks.

- Push your map to your github account, and add a link from your index page. Let's make sure we're all using the tab key in Sublime Text and terminal to our advatange.


##Looking at data
The standard graduation rates reported for colleges are broken. 


- Let's come up with a gameplan. This is a real project.



##Homework

- Project pitches should be on the internet before next week's class.

