var margin = {top: 20, right: 20, bottom: 30, left: 200},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var y = d3.scale.linear()
    .range([height, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(10);

var svg = d3.select("#chart").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom + 50)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  var data = [];

  // Parse each JSON string into data
  for (var i = 0; i <= raw_data.length - 1; i++) {
    data.push(JSON.parse(raw_data[i]));
  }

  x.domain(data.map(function(d) { return d.user; }));
  y.domain([0, d3.max(data, function(d) { return d.hours; })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height +")")
      .call(xAxis).append("text")
      .attr("x", 50)
      .attr("dy", "3em")
      .attr("dx", "10em")
      .text("Users")
      .style("font-size","25px");

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("y", 6)
      .attr("dy", "9em")
      .attr("dx", "-3em")
      .style("text-anchor", "end")
      .text("Hours")
      .style("font-size","25px");

  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.user); })
      .attr("width", x.rangeBand())
      .attr("y", function(d) { return y(d.hours); })
      .attr("height", function(d) { return height - y(d.hours); });

function type(d) {
  d.hours = +d.hours;
  return d;
}