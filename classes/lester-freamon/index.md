---
layout: class
week: 1
title: Doing the dirty work
---

The big 4 – sorting, filtering, aggregating and merging – are enough to help you answer 99 percent of data questions. But most of the time, your data doesn't come ready to party. Today we'll clean messy data as it comes in the real world and then embark on Stage 2 of our class data gathering project.

##Housekeeping

- General thoughts on project pitches: think small + manageable
- Project requirements and [a look forward](../projects/)
- Sarah, Cayleigh, & Kristin are leading a discussion on [TKTKTKT](http://www.google.com)
- When things are [broken](http://jigsaw.w3.org/css-validator/).

##Part 1: Data in the real world

Unfortunately, data doesn't always come formatted the way we like. Let's take a recent example from last year with some data about successful gun traces out of Chicago. (A [gun trace](http://www.atf.gov/publications/factsheets/factsheet-national-tracing-center.html) is where they find out where a gun found in a crime was purchased.) After some phone calls, you get your hands on some source data. Go ahead and [download it](county-data.txt) and open it in a spreadsheet.

1. Take a look at the data. What does one row look like? What does our dream data set look like? Do the things we always do: know dimensions, make a copy, give the columns names.

1. Let's think of questions we might ask of our dream data set instead of this data set. What are some headlines we wish we could be able to write? Add a couple of your own in [this Google Doc](https://docs.google.com/document/d/19bZ5tU5acdgRGX45qU_MPYHaCMNaP1cQap094SkXs6o/edit?usp=sharing). This is a 'hat-on' exercise, so don't be shy.

3. Name the sheet `traces`. How sad does this data make us? 

4. Make columns called `county_clean` and `state_clean` that has just have counties and states only. 

5. How useful would a pivot table of county_clean be? Do a filter in `clean_county` for "Washington". 

6. It's pretty clear that we need some data that has unique values for each county. Google "US county fips codes" and see what the Census has to offer (though any of them are probably fine, we should stick to government data). Save the file locally and enter it as a second sheet in your main Excel file. Call the sheet `FIPS`. <a class="hidden" href="https://www.census.gov/geo/reference/codes/files/national_county.txt">BLAMO</a> and clean it up, doing the normal things we do.

8. Be happy if your sheet looks like this:
  <img src="Screenshot 2014-03-02 16.42.54.png">

10. Make a new column for the 5-digit county FIPS code for each county. Call it ```5_digit_fips```. There are lots of ways to do this.

11. How are we going to join our data?

11. Remove the word "county" from ```county_name``` in a new field called ```county2```.

11. *In both sheets*, make a new column called `joinfield` that pastes the county name and state together, separated by a hyphen. You might need to do this in steps.

14. We're ready to make a crude attempt a vlookup. Try to get a column called "county_fips" in your traces sheet.

15. Which ones didn't match? Why?

16. Make a new field called is_error that gives you a 1 if there is an error and a zero if there is not.

17. Sort your traces data by is_error and then count, both decreasing. This will let you prioritize your targets and quantitatively answer how good our merge was. How many do we need to fix? 

18. Seek and destroy! There's no wrong way to do this, but some ways are righter than others. Keep going until you have matched *98 percent of guns and are not missing any counties with more than 30 guns traced*. (Protip: a pivot table of `is_error` and sum of `count` will be helpful.)

27. With the FIPS codes, what can we do that we couldn't before?

28. Can we answer this question the way we did this join? "What percent of counties had at least one gun traced to Chicago?"

29. One stats program called R would let us map these without too much trouble. What questions might these maps lead you to ask? Where might you go to get answers?
  <img src="http://kpq.github.io/r-tutorials/assets/images/chicago-map-10.png">
  <img src="http://kpq.github.io/r-tutorials/assets/images/chicago-map-12.png">

30. Here's the <a href="http://www.nytimes.com/interactive/2013/01/29/us/where-50000-guns-in-chicago-came-from.html?ref=us">NYT take</a> and <a href="http://www.nytimes.com/2013/01/30/us/strict-chicago-gun-laws-cant-stem-fatal-shots.html?pagewanted=all">story</a>.

## Where we left off.
The typical graduation rates reported for colleges are broken, in part because transfer students are counted in the same way as drop-outs. How could you fix this? 

- Some schools voluntarily give their progress data to a group called [College Portraits](http://www.collegeportraits.org/). Here is a [sample report](http://www.collegeportraits.org/SC/USC-Upstate/tracker). But even friendly people associated with that project don't know they have the data in a database. I suspect they do, but I'm not sure. I have scraped the data, and done some work to standardize it for you [here](college-grad-and-transfer-rates.xlsx). For the extra curious, here is some [horrible code](collegeportraits.r).

- Note that there are some small difference between the [2013 reports](http://www.collegeportraits.org/AL/AU/tracker) and the [2012 ones](http://www.collegeportraits.org/AL/JSU/tracker).

- Take 20 minutes to explore the data, generating a list of questions, facts, and weirdness you uncover [here](https://docs.google.com/document/d/1QVt45d0JfwLfa0RQtjULr68jZeWFKqEN6Ij4RU5sGVY/edit#). Your goal is questions that are both answerable and could turn into interesting ledes. 

- Let's come up with a gameplan for collecting the data for the biggest schools. What do we need? 

- Let's practice aggregating to see how far we have to go. Here's [something](list-of-schools.csv) for that. 

- In the doc with your questions, let's draft a request for data from a school.

- Don't try to be too complicated at the beginning. Start with very easy questions - think averages, top 10 lists, outliers. After you have those answers, then you can add fanciness.
- We are looking for things that we don't expect. [Washington Monthly's rankings](http://www.washingtonmonthly.com/college_guide/rankings_2013/national_university_rank.php) are based on the same idea.
- Find two schools that with similar characteristics, but very different graduation rates.

## Expanding our college graduation sample. If we were to try, how far would we have to go?

Here's [a list of schools](../pieces-together-interviewing-data/list-of-schools.csv) for that. How many schools would we have to contact if we wanted to cover, say, half of the nation's undergraduates? 75%? How else could we restrict our sample?

## Write our letter.

Let's do it together [here](https://docs.google.com/document/d/1QVt45d0JfwLfa0RQtjULr68jZeWFKqEN6Ij4RU5sGVY/edit#).

##Homework
You have two choices. You may fill out 40 rows with contact information in [this document](https://docs.google.com/spreadsheet/ccc?key=0AvKWOz9eYW7ydGxfNnRGWnI4Vm9mT0thRnc2U2dSYWc#gid=0). Or you may embark on your own data collection project of a similar scale. If you choose the later, please push it to your github page.