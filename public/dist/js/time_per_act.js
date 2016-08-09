var width = 960,
    height = 500,
    radius = Math.min(width, height) / 2;

// add a distinct color code if number of distinct activities in API increases (currently 18)
var color = d3.scale.ordinal()
    .range(["#1ABC9C", "darkblue","#ff7232", "#ffcb00", "#800080", "#FF00FF", "#000080", "#0000FF", "#008080",
            "#00FFFF", "#008000", "#00FF00", "#808000", "#800000", "#FF0000", "#808080", "#C0C0C0", "#CD5C5C"]);

var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(0);

var labelArc = d3.svg.arc()
    .outerRadius(radius - 40)
    .innerRadius(radius - 40);

var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.hours; });

var svg = d3.select("#chart").append("svg")
    .attr("width", width)
    .attr("height", height)
    .append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");


var tooltip = d3.select("#chart")
    .append("div")
    .style("position", "absolute")
    .style("visibility", "hidden")
    .text("a simple tooltip");

var data = [];

// Parse each JSON string into data
for (var i = 0; i <= raw_data.length - 1; i++) {
  data.push(JSON.parse(raw_data[i]));
}

var g = svg.selectAll(".arc")
        .data(pie(data))
        .enter().append("g")
        .attr("class", "arc")
        .on("mouseover", function(d){return tooltip.style("visibility", "visible") && tooltip.text(d.data.activity);})
        .on("mouseout", function(){return tooltip.style("visibility", "hidden");});;

g.append("path")
    .attr("d", arc)
    .style("fill", function(d) { return color(d.data.hours); });

g.append("text")
    .attr("transform", function(d) { return "translate(" + labelArc.centroid(d) + ")"; })
    .attr("dy", ".35em")
    .text(function(d) { return d.data.hours; });


function type(d) {
  d.hours = +d.hours;
  return d;
}