var colors = d3.scale.category20b(),
     headline = d3.select("h1"),
     letters = headline.text().split("");

headline.text("");

var rainbowLetters = headline.selectAll("span")
    .data(letters)
  .enter().append("span")
    .text(function(d) { return d; })
    .style("position", "relative")

// d3.timer(function(t) {

  t = 1000;
  rainbowLetters
      .style("color", function(d, i) { return colors(Math.floor(t / 50 + i)); })
      .style("top", function(d, i) { return Math.sin(i / 2 + t / 50) * 8 + "px"; })
      .style("left", function(d, i) { return Math.random() * 5 + "px"; })
// });
