var margin = {top: 20, right: 80, bottom: 30, left: 50},
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
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom + 50)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var data = [{"date":"20111001","tschuy":63.4,"kennric":62.7,"iCHAIT":72.2},{"date":"20111002","tschuy":58,"kennric":59.9,"iCHAIT":67.7},{"date":"20111003","tschuy":53.3,"kennric":59.1,"iCHAIT":69.4},{"date":"20111004","tschuy":55.7,"kennric":58.8,"iCHAIT":68},{"date":"20111005","tschuy":64.2,"kennric":58.7,"iCHAIT":72.4},{"date":"20111006","tschuy":58.8,"kennric":57,"iCHAIT":77},{"date":"20111007","tschuy":57.9,"kennric":56.7,"iCHAIT":82.3},{"date":"20111008","tschuy":61.8,"kennric":56.8,"iCHAIT":78.9},{"date":"20111009","tschuy":69.3,"kennric":56.7,"iCHAIT":68.8},{"date":"20111010","tschuy":71.2,"kennric":60.1,"iCHAIT":68.7},{"date":"20111011","tschuy":68.7,"kennric":61.1,"iCHAIT":70.3},{"date":"20111012","tschuy":61.8,"kennric":61.5,"iCHAIT":75.3},{"date":"20111013","tschuy":63,"kennric":64.3,"iCHAIT":76.6},{"date":"20111014","tschuy":66.9,"kennric":67.1,"iCHAIT":66.6},{"date":"20111015","tschuy":61.7,"kennric":64.6,"iCHAIT":68},{"date":"20111016","tschuy":61.8,"kennric":61.6,"iCHAIT":70.6},{"date":"20111017","tschuy":62.8,"kennric":61.1,"iCHAIT":71}];

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
      .text("Days/Months")
      .style("font-size","25px");;

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("Time Spent")
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