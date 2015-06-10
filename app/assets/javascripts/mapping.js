var g,
    width  = 900,
    height = 500;

map = d3.select('#map').append('svg')
        .attr('width', width)
        .attr('height', height)
        .append('g');

d3.json("/assets/tokyomap.json", function(json) {
  var projection, path;

  projection = d3.geo.mercator()
                 .scale(45000)
                 .center(d3.geo.centroid(json))
                 .translate([600, 920]);
  
  path = d3.geo.path().projection(projection);
  
  map.selectAll('path')
     .data(json.features)
     .enter()
     .append('path')
     .attr('d', path)
     .attr("fill", function(d){
       return "hsl(147, 28%, 38%)";
     })
     .attr("stroke", "hsl(147, 28%, 38%)")
     .on('mouseover', function(d) {
       console.log("mouseover");
     })
     .on('click', function(d) {
       console.log("click");
     });

  console.log("test");
});
