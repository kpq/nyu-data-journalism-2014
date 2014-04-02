---
layout: class
week: 8
title: Maps and more
---

We'll do a survey of maps and map types, including a lecture that's old but good. Then we'll make sure you know how to make tables look classy, which is a lifelong skill and something that can make you look surprisingly professional.

Finally, we'll do a drive-by on your projects.

##Housekeeping
- [Project timeline.](../../projects/) Are you on track for success?
- Peipei and Ellis are leading a discussion on [XXX]()

##Lecture
Second week in a row of [more lecture](maps-lecture.pdf) than you're used to. It can be quick and painless.

##You Don't Need To Make Maps From Scratch

Your goal is to make a map and table (complete with a readin and headline) of the data we cleaned in a [previous class](http://graphics8.nytimes.com/newsgraphics/2013/01/26/chicago-guns-map/b3d41fc896ad9a786c8a37b11a3caf561477db79/guns-history3.csv) about Chicago guns, both on a map and in a table. You can pick from the menu of maps below, presented roughly in order of difficulty. You might need to do some formatting on your data.

Arrange yourselves by preference.

**State Level**

- You should already know how to use [D3 + Leaflet](http://bl.ocks.org/ansis/9368682874d9e8adda21). These are good when you really want users to be able to have control or find a specific place. Really, for a state level map, this is probably not the best solution.

This might help get started. Save it locally and call it `maps-homework.html`.

```html
<style type="text/css">
	
	/*css goes here*/

	body {
		width:750px;
		margin:20px auto;
		font-family:georgia;
	}

</style>

<h1>This is my homework assignment</h1>

<p class="readout">This will be my readout</p>

<div class="map-section">
<!-- map work to go in here -->
</div>

<div class="table-section">
<!-- map work to go in here -->
</div>

<script type="text/javascript">
	
	// javascript goes here.

</script>
```

- [Stately](http://intridea.github.io/stately/) is really lightweight and great at small maps. Labeling them is a challenge, though, and you don't get a lot of interactivity for free.

- [Paint By Numbers](http://bl.ocks.org/mbostock/9907392) This works great! For a bonus, see if you can get it to use different colors. 

- Kevin really doesn't like [Google fusion tables](http://www.google.com/drive/apps.html#fusiontables), but they are really easy to make.

**County level** (advanced)
- [In case of emergency](http://bl.ocks.org/mbostock/9918809).

- [D3 demo](http://bl.ocks.org/mbostock/4060606)

- [Bubbles](http://bl.ocks.org/mbostock/9943478), if you prefer.


##Table
We'll apply the principles of [this gif](http://i.imgur.com/ZY8dKpA.gif) to the Chicago data. Your goal is to include an HTML table of guns per state in decreasing order that visually highlights Mississippi. The official [spec on tables](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table) may help, and so might [Mr. Data Converter](http://shancarter.github.io/mr-data-converter/). For styling, [here is](https://delicious.com/archietse/table,nyt) a nice list of things you can be inspired by.

##Projects

Before you go, check in with a 30-second update on where you are headed with your project and what you need (or need to learn) to succeed.
