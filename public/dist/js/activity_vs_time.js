var margin = {top: 20, right: 20, bottom: 30, left: 300},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;

var x0 = d3.scale.ordinal()
    .rangeRoundBands([0, width], .1);

var x1 = d3.scale.ordinal();

var y = d3.scale.linear()
    .range([height, 0]);

var color = d3.scale.ordinal()
     .range(["black", "darkblue","#ff7232", "#ffcb00"]);

var xAxis = d3.svg.axis()
    .scale(x0)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left");
    // .tickFormat(d3.format(".2s"));

var svg = d3.select("#chart").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom + 50)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

var data = [
  {
    "Project": "what's fresh",
    "Testing": 8,
    "Coding": 14,
    "Code-Review": 2,
    "Documentation": 7
  },
  {
    "Project": "pgd",
    "Testing": 7,
    "Coding": 13,
    "Code-Review": 1,
    "Documentation": 7
  },
  {
    "Project": "timesync-node",
    "Testing": 6,
    "Coding": 15,
    "Code-Review": 2,
    "Documentation": 7
  },
  {
    "Project": "fenestra",
    "Testing": 9,
    "Coding": 13,
    "Code-Review": 1,
    "Documentation": 7
  },
  {
    "Project": "pymesync",
    "Testing": 8,
    "Coding": 10,
    "Code-Review": 2,
    "Documentation": 7
  }
];


  var activities = d3.keys(data[0]).filter(function(key) { return key !== "Project"; });

  data.forEach(function(d) {
    d.ages = activities.map(function(name) { return {name: name, value: +d[name]}; });
  });

  x0.domain(data.map(function(d) { return d.Project; }));
  x1.domain(activities).rangeRoundBands([0, x0.rangeBand()]);
  y.domain([0, d3.max(data, function(d) { return d3.max(d.ages, function(d) { return d.value; }); })]);

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis).append("text")
      .attr("x", 50)
      .attr("dy", "3em")
      .attr("dx", "9em")
      .text("Projects")
      .style("font-size","25px");

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("y", 6)
      .attr("dy", "9em")
      .attr("dx", "-3em")
      .style("text-anchor", "end")
      .text("Hours Spent").style("font-size","25px");

  var Project = svg.selectAll(".Project")
      .data(data)
    .enter().append("g")
      .attr("class", "Project")
      .attr("transform", function(d) { return "translate(" + x0(d.Project) + ",0)"; });

  Project.selectAll("rect")
      .data(function(d) { return d.ages; })
    .enter().append("rect")
      .attr("width", x1.rangeBand())
      .attr("x", function(d) { return x1(d.name); })
      .attr("y", function(d) { return y(d.value); })
      .attr("height", function(d) { return height - y(d.value); })
      .style("fill", function(d) { return color(d.name); });

  var legend = svg.selectAll(".legend")
      .data(activities.slice().reverse())
    .enter().append("g")
      .attr("class", "legend")
      .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

  legend.append("rect")
      .attr("x", width - 18)
      .attr("width", 18)
      .attr("height", 18)
      .style("fill", color);

  legend.append("text")
      .attr("x", width - 24)
      .attr("y", 9)
      .attr("dy", ".35em")
      .style("text-anchor", "end")
      .text(function(d) { return d; });