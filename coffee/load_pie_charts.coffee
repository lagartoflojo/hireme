$ ->
   $('.pie-chart').each ->
      new Highcharts.Chart
         chart:
            renderTo: $(this).attr("id")
            plotBackgroundColor: null
            plotBorderWidth: null
            plotShadow: false
         title:
            text: ''
         tooltip:
            enabled: false
         plotOptions:
            pie:
               allowPointSelect: true
               cursor: 'pointer'
               dataLabels:
                  enabled: true
                  formatter: ->
                     "<b>#{this.point.name}</b>: #{Highcharts.numberFormat(this.percentage,0)}%"
          series: [
            type: 'pie'
            name: $(this).attr("data-series-name")
            data: $.parseJSON $(this).attr("data-pie-chart-data")
         ]