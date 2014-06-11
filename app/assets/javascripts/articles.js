$(function() {
  var chart;
  
  nv.addGraph(function() {
    chart = nv.models.discreteBarChart();

    chart
      .x(function(d) {
        return d.label;
      })
      .y(function(d) {
        return d.value;
      })
      .showValues( true );

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
      url: "/articles/1/sentiments?url=http://www.nytimes.com/2014/06/12/us/politics/after-eric-cantor-primary-defeat-house-republicans-take-stock.html"
    });
  }

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

  function plotData( data ) {
    d3.select( "#chart svg" )
      .datum( data )
      .call( chart );
  }
});