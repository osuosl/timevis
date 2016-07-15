
var margin = {top: 20, right: 80, bottom: 30, left: 80},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var parseDate = d3.time.format("%Y%m%d").parse;

var x = d3.time.scale()
    .range([0, width]);

var y = d3.scale.linear()
    .range([height, 0]);

var color = d3.scale.category10();

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");

var line = d3.svg.line()
    .interpolate("basis")
    .x(function(d) { return x(d.date); })
    .y(function(d) { return y(d.temperature); });

var svg = d3.select("#chart").append("svg")
    .attr("width", width + margin.left + margin.right+100)
    .attr("height", height + margin.top + margin.bottom + 50)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var data = [{"date":"20111001","Testing":63.4,"Coding":52.7,"Code-Review":72.2,"Documentation":55.3},{"date":"20111002","Testing":58,"Coding":59.9,"Code-Review":67.7,"Documentation":55.3},{"date":"20111003","Testing":53.3,"Coding":59.1,"Code-Review":69.4,"Documentation":35.3},{"date":"20111004","Testing":55.7,"Coding":58.8,"Code-Review":68,"Documentation":25.3},{"date":"20111005","Testing":64.2,"Coding":58.7,"Code-Review":72.4,"Documentation":75.3},{"date":"20111006","Testing":58.8,"Coding":57,"Code-Review":77,"Documentation":50.3},{"date":"20111007","Testing":57.9,"Coding":56.7,"Code-Review":82.3,"Documentation":15.3},{"date":"20111008","Testing":61.8,"Coding":56.8,"Code-Review":78.9,"Documentation":48.3},{"date":"20111009","Testing":69.3,"Coding":56.7,"Code-Review":68.8,"Documentation":55.3},{"date":"20111010","Testing":71.2,"Coding":60.1,"Code-Review":68.7,"Documentation":54.3},{"date":"20111011","Testing":68.7,"Coding":61.1,"Code-Review":70.3,"Documentation":40.3},{"date":"20111012","Testing":61.8,"Coding":61.5,"Code-Review":75.3,"Documentation":99.3},{"date":"20111013","Testing":63,"Coding":64.3,"Code-Review":76.6,"Documentation":42.3},{"date":"20111014","Testing":66.9,"Coding":67.1,"Code-Review":66.6,"Documentation":50.3},{"date":"20111015","Testing":61.7,"Coding":64.6,"Code-Review":68,"Documentation":55.3},{"date":"20111016","Testing":61.8,"Coding":61.6,"Code-Review":70.6,"Documentation":35.3},{"date":"20111017","Testing":32.8,"Coding":61.1,"Code-Review":71,"Documentation":55.3}];

  color.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));

  data.forEach(function(d) {
    d.date = parseDate(d.date);
  });

  var cities = color.domain().map(function(name) {
    return {
      name: name,
      values: data.map(function(d) {
        return {date: d.date, temperature: +d[name]};
      })
    };
  });

  x.domain(d3.extent(data, function(d) { return d.date; }));

  y.domain([
    d3.min(cities, function(c) { return d3.min(c.values, function(v) { return v.temperature; }); }),
    d3.max(cities, function(c) { return d3.max(c.values, function(v) { return v.temperature; }); })
  ]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)
      .append("text")
      .attr("x", 50)
      .attr("dy", "3em")
      .attr("dx", "10em")
      .text("Months")
      .style("font-size","25px");

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dx", "-2em")
      .attr("dy", "-1.6em")
      .style("text-anchor", "end")
      .text("Time Submitted for each activity")
      .style("font-size","25px");

  var city = svg.selectAll(".city")
      .data(cities)
    .enter().append("g")
      .attr("class", "city");

  city.append("path")
      .attr("class", "line")
      .attr("d", function(d) { return line(d.values); })
      .style("stroke", function(d) { return color(d.name); });

  city.append("text")
      .datum(function(d) { return {name: d.name, value: d.values[d.values.length - 1]}; })
      .attr("transform", function(d) { return "translate(" + x(d.value.date) + "," + y(d.value.temperature) + ")"; })
      .attr("x", 3)
      .attr("dy", ".35em")
      .text(function(d) { return d.name; });