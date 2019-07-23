// @TODO: YOUR CODE HERE!

// Define SVG area dimensions
var svgWidth = 960;
var svgHeight = 660;

// Define the chart's margins as an object
var chartMargin = {
  top: 30,
  right: 30,
  bottom: 30,
  left: 30
};

// Define dimensions of the chart area
var chartWidth = svgWidth - chartMargin.left - chartMargin.right;
var chartHeight = svgHeight - chartMargin.top - chartMargin.bottom;

// Select body, append SVG area to it, and set the dimensions
var svg = d3
  .select("#scatter")
  .append("svg")
  .attr("height", svgHeight)
  .attr("width", svgWidth)
  .attr("class", "chart");

// Append a group to the SVG area and shift ('translate') it to the right and down to adhere
// to the margins set in the "chartMargin" object.
var chartGroup = svg.append("g")
  .attr("transform", `translate(${chartMargin.left}, ${chartMargin.top})`);


// Load data from hours-of-tv-watched.csv
d3.csv("/assets/data/data.csv").then(function(factData) {

    // Print the factData
    console.log(factData);

    //Healthcare vs Poverty

    //parse the data as numbers
    factData.forEach(function(data) {
        data.poverty = +data.poverty;
        data.healthcare = +data.healthcare;
    });

    //add scales

    var xLinearScale = d3.scaleLinear()
        .range([0, chartWidth])
        .domain([d3.min(factData, data => data.poverty), d3.max(factData, data => data.poverty)])

    var yLinearScale = d3.scaleLinear()
        .range([chartHeight,0])
        .domain([0, d3.max(factData, d => d.healthcare)])

    //create axes

    var bottomAxis = d3.axisBottom(xLinearScale);
    var leftAxis = d3.axisLeft(yLinearScale);
    
    //add axes to page
    chartGroup.append("g")
        //.classed("axis", true)
        .call(leftAxis);

    chartGroup.append("g")
        //.classed("axis", true)
        .attr("transform", "translate(0 "+ chartHeight + ")")
        .call(bottomAxis);
    
    
    //Add dots

    var circlesGroup = chartGroup.selectAll("circle")
        .data(factData)
        .enter()
        .append("circle")
        .attr("cx", data => xLinearScale(data.poverty) )
        .attr("cy", data => yLinearScale(data.healthcare))
        .attr("class", "stateCircle")
        .attr("r", 10);

    circlesGroup.append("text")
        .attr("class", "stateText")
        .attr("font-size", "10")
        .attr("x", d => xLinearScale(d.poverty))
        .attr("y", d=> yLinearScale(d.healthcare)+3)
        .attr("fill", "white")
        .text(d => d.abbr);

    // Create axes labels
    chartGroup.append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 0 - (chartMargin.left)-30)
      .attr("x", 0 - (chartMargin.height))
      .attr("cy", "1em")
      .attr("class", "aText")
      .text("Lacks Healthcare(%)");

    chartGroup.append("text")
      .attr("transform", `translate(${chartMargin.width / 2}, ${chartMargin.height + chartMargin.top + 500})`)
      .attr("class", "aText")
      .text("In Poverty(%)");
});
    


 
