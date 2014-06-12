$(function() {
  var chart;
  
  // Draw chart
  nv.addGraph(function() {
    chart = nv.models.discreteBarChart();

    chart
      // Draws the X axis
      .x(function(d) {
        return d.label;
      })
      // Draws the Y axis
      .y(function(d) {
        return d.value;
      })
      // Show values on chart
      .showValues( true );

    // Get the data via AJAX, clean it, then plot it.
    getData()
      .then( cleanData )
      .then( plotData );

    nv.utils.windowResize( chart.update );

    return chart;
  });

  function getData() {
    return $.ajax({
      dataType: "json",
      type: "get",
      url: "" // NOTE: Need to replace this with a dynamic value
    });
  }

  // Transforms the Alchemy API format to the d3 format
  function cleanData( keywords ) {
    var values = [];
    for ( var i = 0; i < keywords.length; i++ ) {
      var keyword = keywords[i];

      var cleanKeyword = { label: keyword.text,
        value: keyword.sentiment.score || 0
      };

      values.push( cleanKeyword );
    }

    var data = [{
      key: "Keyword Sentiment",
      values: values
    }];

    return data;
  }

  // Plot the data in the element matching the CSS selector "#chart svg"
  function plotData( data ) {
    d3.select( "#chart svg" )
      .datum( data )
      .call( chart );
  }
});