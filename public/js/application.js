$(function(){return $(".pie-chart").each(function(){return new Highcharts.Chart({chart:{renderTo:$(this).attr("id"),plotBackgroundColor:null,plotBorderWidth:null,plotShadow:!1},title:{text:""},tooltip:{enabled:!1},plotOptions:{pie:{allowPointSelect:!0,cursor:"pointer",dataLabels:{enabled:!0,formatter:function(){return"<b>"+this.point.name+"</b>: "+Highcharts.numberFormat(this.percentage,0)+"%"}}}},series:[{type:"pie",name:$(this).attr("data-series-name"),data:$.parseJSON($(this).attr("data-pie-chart-data"))}]})})}),$(function(){return $("#search").submit(function(a){return a.preventDefault(),window.location="/"+$("#github-username").val()})});