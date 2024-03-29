<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="../resources/js/chart/Chart.min.js"></script>  

<script>
		var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
		var months = ["January","February","March","April","May","June","July", "August", "September", "October", "November", "December"];
		var radarChart = null;
		var radarChartData = {
			labels : ["January","February","March","April","May","June","July"],
			datasets: [
				{
					label: "My First dataset",
					fillColor: "rgba(220,220,220,0.2)",
					strokeColor: "rgba(220,220,220,1)",
					pointColor: "rgba(220,220,220,1)",
					pointStrokeColor: "#fff",
					pointHighlightFill: "#fff",
					pointHighlightStroke: "rgba(220,220,220,1)",
					data: [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
				},
				{
					label: "My Second dataset",
					fillColor: "rgba(151,187,205,0.2)",
					strokeColor: "rgba(151,187,205,1)",
					pointColor: "rgba(151,187,205,1)",
					pointStrokeColor: "#fff",
					pointHighlightFill: "#fff",
					pointHighlightStroke: "rgba(151,187,205,1)",
					data: [randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor(),randomScalingFactor()]
				}
			]
		};

		$(function() {
			var ctx = document.getElementById("canvas").getContext("2d");
			radarChart = new Chart(ctx).Radar(radarChartData, {
				//Boolean - Whether to show lines for each scale point
				scaleShowLine : true,
				//Boolean - Whether we show the angle lines out of the radar
				angleShowLineOut : true,
				//Boolean - Whether to show labels on the scale
				scaleShowLabels : false,
				// Boolean - Whether the scale should begin at zero
				scaleBeginAtZero : true,
				//String - Colour of the angle line
				angleLineColor : "rgba(0,0,0,0.1)",
				//Number - Pixel width of the angle line
				angleLineWidth : 1,
				//String - Point label font declaration
				pointLabelFontFamily : "'Arial'",
				//String - Point label font weight
				pointLabelFontStyle : "normal",
				//Number - Point label font size in pixels
				pointLabelFontSize : 10,
				//String - Point label font colour
				pointLabelFontColor : "#666",
				//Boolean - Whether to show a dot for each point
				pointDot : true,
				//Number - Radius of each point dot in pixels
				pointDotRadius : 3,
				//Number - Pixel width of point dot stroke
				pointDotStrokeWidth : 1,
				//Number - amount extra to add to the radius to cater for hit detection outside the drawn point
				pointHitDetectionRadius : 20,
				//Boolean - Whether to show a stroke for datasets
				datasetStroke : true,
				//Number - Pixel width of dataset stroke
				datasetStrokeWidth : 2,
				//Boolean - Whether to fill the dataset with a colour
				datasetFill : false,
				onAnimationProgress: function() {
					console.log("onAnimationProgress");
				},
				onAnimationComplete: function() {
					console.log("onAnimationComplete");
				}
			});
		});

		$("input#btnAdd").on("click", function() {
			radarChart.addData(
				[randomScalingFactor(),randomScalingFactor()], 
				months[(radarChart.datasets[0].points.length)%12]
			);
		});

		$("canvas").on("click", function(e) {
			var activePoints = radarChart.getPointsAtEvent(e);
			console.log(activePoints);

			for(var i in activePoints) {
				console.log(activePoints[i].value);
			}
		});

</script>

<!-- 손님선택 -->
<div style="width: 60%">
	<canvas id="canvas" height="450" width="600"></canvas>
</div>
<input type="button" id="btnAdd" value="add data">
<!-- 손님선택 -->

