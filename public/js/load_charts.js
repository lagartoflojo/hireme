$(document).ready(function() {

   $('.lang-stats').each( function() {
      new Highcharts.Chart({
         chart: {
            renderTo: $(this).attr("id"),
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
         },
         title: {
            text: ''
         },
         tooltip: {
            enabled: false,
            formatter: function() {
               return '<b>'+ this.point.name +'</b>: '+ this.percentage +' %';
            }
         },
         
         plotOptions: {
            pie: {
               allowPointSelect: true,
               cursor: 'pointer',
               dataLabels: {
                  enabled: true,
                  formatter: function() {
                     return '<b>'+ this.point.name +'</b>: '+ Highcharts.numberFormat(this.percentage,2) +' %';
                  }
               }
            }
         },
          series: [{
            type: 'pie',
            name: 'Language Share',
            data: $.parseJSON($(this).attr("data-lang-stats"))
         }]
      });

   });


   
});