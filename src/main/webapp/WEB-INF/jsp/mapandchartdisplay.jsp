<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Hypothesis 1&2</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/Chart.bundle.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/utils.js"></script>
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet"> --%>
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/adda_ico.png">
<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/responsive.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/prettyPhoto.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css"
	rel="stylesheet">

<link
	href="${pageContext.request.contextPath}/resources/css/animate.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/table.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/leaflet@1.0.3/dist/leaflet.css"
	integrity="sha512-07I2e+7D8p6he1SIM+1twR5TIrhUQn9+I6yjqD53JQjFiMf8EtC93ty0/5vJTZGF8aAocvHYNEDJajGdNx1IsQ=="
	crossorigin="" />

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://unpkg.com/leaflet@1.0.3/dist/leaflet.js"
	integrity="sha512-A7vV8IFfih/D732iSSKi20u/ooOfj/AGehOKq0f4vLT1Zr2Y+RX7C+w8A1gaSasGtRUZpF/NZgzSAu4/Gc41Lg=="
	crossorigin=""></script>

<!-- <style>
#map {
	width: 600px;
	height: 400px;
}
</style> -->

<style>
table td {
	border: 0px;
}

#map {
	width: 900px;
	height: 400px;
}

.info {
	padding: 6px 8px;
	font: 14px/16px Arial, Helvetica, sans-serif;
	background: white;
	background: rgba(255, 255, 255, 0.8);
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
	border-radius: 5px;
}

.info h4 {
	margin: 0 0 5px;
	color: #777;
}

.legend {
	text-align: left;
	line-height: 18px;
	color: #555;
}

.legend i {
	width: 18px;
	height: 18px;
	float: left;
	margin-right: 8px;
	opacity: 0.7;
}

select {
	width: 100%;
}

table {
	border-collapse: separate;
	border-spacing: 10px;
}

/* table td:last-child {
	text-align: center;
} */
table td:first-child {
	text-align: right;
}

#loading-gif {
	margin-left: 8cm;
	margin-top: 2cm;
}

#loading-gif img {
	height: 90px;
	width: 90px;
}

#NoData {
	background-color: #FFD42A;
	width: 40%;
	color: #000;
	font-weight: bold;
	text-align: center;
	margin: auto;
	text-align: center;
	font-weight: bold;
	text-align: center;
}

/* #mapIframe{
background: url("${pageContext.request.contextPath}/resources/images/loading3.gif")
} */
</style>
</head>

<body>
	<jsp:include page="admin_header.jsp"></jsp:include>

	<table id="mid">
		<tr>
			<td
				style="background-color: #327a89; vertical-align: top; padding: 0px 25px; width: 30%">
				<div style="color: #fff">
					<!-- <ul style="border-bottom: solid #fff 2px" type="square">
						<li><h2 style="color: #fff;">Description</h2></li>
					</ul> -->
					<p style="text-align: justify;">
						<br> <br>From the Base Year to Option Year 3 Rural Area
						Percentage line plot, we would like to see the change trend of the
						rural area percentage of all combined EPs and GPROs and the
						difference among reporting options (Claims, Registry, EHR, QCDR
						and GPROWI)
					</p>
				</div>
				<div id="onScreenHelpLabelId" style="color: #fff">
					<br>On Screen User Help:
				</div>
				<div style="color: #fff">
					<p style="text-align: justify;">${subDataAnalysis.onScreenHelpText}</p>
				</div>
			</td>
			<td style="vertical-align: top;">
				<h2 style="text-align: center; font-size: 30px;">${subDataAnalysis.subDataAnalysisName}</h2>
				<div class="HypothesisScreen" style="padding: 20px 250px;">
					<table style="border-collapse: separate; border-spacing: 2px;">

						<tr>
							<td><label for="yearLookUpId">Option Year : </label></td>
							<td><select id="yearLookUpId" name="yearLookUpId"
								title="Select one of the option years or ALL where available">
									<option value="">Select</option>
									<c:forEach items="${yearLookups}" var="yearLookUp">
										<option value="${yearLookUp.id}"
											${yearLookUp.id == yearLookUpId ? 'selected="selected"' : ''}>${yearLookUp.yearName}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>

							<td><label for="reportingOptionLookupId">Reporting
									Option : </label></td>
							<td><select id="reportingOptionLookupId"
								name="reportingOptionLookupId"
								title="Select one of the reporting options">
									<option value="">Select</option>
									<c:forEach items="${reportingOptionLookups}"
										var="reportingOptionLookup">
										<option value="${reportingOptionLookup.id}"
											${reportingOptionLookup.id == reportingOptionLookupId ? 'selected="selected"' : ''}>${reportingOptionLookup.reportingOptionName}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td><label for="parameterLookupId">Parameter Name :
							</label></td>
							<td><select id="parameterLookupId" name="parameterLookupId"
								title="Select one of the parameter names">
									<option value="">Select</option>
									<c:forEach items="${parameterLookups}" var="parameterLookup">
										<option value="${parameterLookup.id}"
											${parameterLookup.id == parameterLookupId ? 'selected="selected"' : ''}>${parameterLookup.parameterName}</option>
									</c:forEach>
							</select></td>
						</tr>
						<tr>
							<td><label for="reportTypeId">Report Type :</label></td>
							<td><select id="reportTypeId" name="reportTypeId"
								title="Select one of the Reporting Types, only one reporting type may be displayed at one time">
										<option value="">Select</option>
    									<option value="Bar Chart" ${subDataAnalysis.id == '1' ? '' : 'disabled'}>Bar Chart</option>
    									<option value="Line Chart" ${subDataAnalysis.id == '2' ? '' : 'disabled'}>Line Chart</option>
    									<option value="Map" ${subDataAnalysis.id == '3' ? '' : 'disabled'}>Map</option>   
    							<%-- 		<c:forEach items="${reportTypes}" var="reportType">
										<option value="${reportType}">${reportType}</option>
										</c:forEach>   --%>
							</select></td>
						</tr>

						<tr id="yesOrNoOptionRow" hidden="true">
							<td><label for="yesOrNoOptionId">Yes/No Option :</label></td>
							<td><select id="yesOrNoOptionId" name="yesOrNoOptionId"
								title="Click here to choose YES/NO">
									<option value="">Select</option>
									<option value="0">No</option>
									<option value="1">Yes</option>
							</select></td>
						</tr>
						<tr>
							<td colspan="2" style="padding-top: 10px"><input
								title="Click the button to submit the selections above and view the results"
								class="btn btn-primary btn-sm"
								style="display: block; margin: auto; width: 30%;" type="submit"
								id="displayreport" value="Submit" /></td>
						</tr>
					</table>
				</div>
				<div class="HypothesisScreen" style="max-height: 600px">
					<iframe id='mapIframe' hidden="true" frameborder="0" scrolling="no"
						style="overflow: hidden; width: 100%; height: 550px"
						style="margin:auto"></iframe>
					<div id="messageDisplay"></div>

					<div id="chart-container" style="width: 75%; margin: auto">
						<div id="loading-gif" hidden="true">
							<img
								src="${pageContext.request.contextPath}/resources/images/loading3.gif" />
						</div>
						<canvas id="chart-canvas"></canvas>
					</div>
				</div>

			</td>
		</tr>
	</table>
	<script type="text/javascript">
	var h;
	h=screen.height-357;
	document.getElementById('mid').style.minHeight=h+'px';
/* 	$('mapIframe').ready(function () {
	    $('#loadinggif').css('display', 'none');
	});
	$('mapIframe').load(function () {
	    $('#loadinggif').css('display', 'none');
	}); */
		var btn = document.getElementById("displayreport");
		var barChartData = null;
		var lineChartData = null;
		var serverContextPath = '${pageContext.request.contextPath}';
        //var serverContextPath = 'http://ec2-34-208-54-139.us-west-2.compute.amazonaws.com/imapservices';	
        //var serverContextPath = 'http://localhost/imapservices';
		btn.addEventListener("click", function() {
			$('#loading-gif').show(); 
			$('#chart-canvas').hide();
			var yesOrNoOptionId = $("#yesOrNoOptionId option:selected").text();
			var reportTypeSelectedText = $("#reportTypeId option:selected").text();
	
			var yearId = document.getElementById("yearLookUpId").value;
			var yearSelectedText = $("#yearLookUpId option:selected").text();
			var reportingOptionId = document.getElementById("reportingOptionLookupId").value;
			var reportingOptionSelectedText = $("#reportingOptionLookupId option:selected").text();
			var parameterId = document.getElementById("parameterLookupId").value;
			var parameterSelectedText = $("#parameterLookupId option:selected").text();
	
			if (reportTypeSelectedText == "Bar Chart") {
				var url = serverContextPath + '/api/barChart/dataAnalysisId/${dataAnalysisId}/subDataAnalysisId/${subDataAnalysisId}/yearId/' + yearId + '/reportingOptionId/' + reportingOptionId;
			}
			if (reportTypeSelectedText == "Line Chart") {
				var url = serverContextPath + '/api/lineChart/dataAnalysisId/${dataAnalysisId}/subDataAnalysisId/${subDataAnalysisId}/parameterId/' + parameterId;
			}
			if (reportTypeSelectedText == "Map") {
				//document.getElementById("mapIframe").hidden = false;		
				$('#mapIframe').hide();
				/* $('#loading-gif').show(); */
				var epGpro = '0';
				if (reportingOptionSelectedText == "CLAIMS" || reportingOptionSelectedText == "EHR"
					|| reportingOptionSelectedText == "REGISTRY"
					|| reportingOptionSelectedText == "QCDR") {
					epGpro = '1';
				} else if (reportingOptionSelectedText == "GPROWI" || reportingOptionSelectedText == "GPRO Registry"
					|| reportingOptionSelectedText == "GPRO EHR"
					|| reportingOptionSelectedText == "GPRO WI GROP") {
					epGpro = '2';
				}
				var ruralUrbanId = document.getElementById("parameterLookupId").value;
				var yesNoId = document.getElementById("yesOrNoOptionId").value;
				var yearId = document.getElementById("yearLookUpId").value;
				var reportingOptionId = document.getElementById("reportingOptionLookupId").value;
				var url = serverContextPath + '/maps/epOrGpro/' + epGpro + '/ruralOrUrban/' + ruralUrbanId + '/yesOrNoOption/' + yesNoId + '/yearId/' + yearId + '/reportingOptionId/' + reportingOptionId + '/dataAnalysisId/${dataAnalysisId}/subDataAnalysisId/${subDataAnalysisId}';				
				
				document.getElementById("mapIframe").src = url;
				/* $('#loading-gif').hide(); */
				$('#mapIframe').show();
			}
	
			var ourRequest = new XMLHttpRequest();
			ourRequest.open('GET', url);
			ourRequest.onload = function() {
				$('#loading-gif').hide();
				$('#chart-canvas').show();
				if (reportTypeSelectedText == "Bar Chart") {
					barChartData = JSON.parse(ourRequest.responseText);
					//console.log(barChartData);
					var barChartDataAvail = barChartData.dataAvailable;
					var yesCountValues = barChartData.yesCountValues;
					var noCountValues = barChartData.noCountValues;
					var titleYearTextVal = yearSelectedText;
					if (yearSelectedText == 'ALL') {
						titleYearTextVal = 'Base Year(2012) to Option Year 3(2015)';
					}
	
					<!-- BAR CHART :: JAVA SCRIPT ###### START  -->
					var barChartData = {
						labels : barChartData.parameters,
						datasets : [ {
							label : 'YES',
							backgroundColor : window.chartColors.darkblue,
							borderColor : window.chartColors.darkblue,
							borderWidth : 1,
							data : barChartData.yesPercents
						}, {
							label : 'NO',
							backgroundColor : window.chartColors.orange,
							borderColor : window.chartColors.orange,
							borderWidth : 1,
							data : barChartData.noPercents
						} ]
					};
	
					var optionsInfo = {
						responsive : true,
						title : {
							display : true,
							text : titleYearTextVal + ' ' + reportingOptionSelectedText + ' Reporting Option Eligible Professionals Summary',
							padding : 40
						},
						animation : {
							duration : 1,
							onComplete : function() {
								var chartInstance = this.chart,
									ctx = chartInstance.ctx;
	
								ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
								ctx.textAlign = 'center';
								ctx.textBaseline = 'bottom';
	
								this.data.datasets.forEach(function(dataset, i) {
									var meta = chartInstance.controller.getDatasetMeta(i);
									meta.data.forEach(function(bar, index) {
										//console.log(bar._view.datasetLabel);
										var data = yesCountValues[index];
										if (bar._view.datasetLabel == "NO") {
											data = noCountValues[index];
										}
	
										ctx.fillText(data, bar._model.x, bar._model.y - 5);
									});
								});
							}
						},
						legend : {
							position : 'bottom',
						},
						tooltips : {
							mode : 'index',
							intersect : true,
						},
	
						hover : {
							mode : 'nearest',
							intersect : true,
						},
						scales : {
							xAxes : [ {
								display : true,
								scaleLabel : {
									display : true,
									labelString : 'PARAMETER'
								},
								ticks : {
									display : true,
									beginAtZero : true
								}
							} ],
							yAxes : [ {
								display : true,
								scaleLabel : {
									display : true,
									labelString : 'PERCENT'
								},
								ticks : {
									callback : function(label, index, labels) {
										return label + ' %';
									},
									display : true,
									beginAtZero : true
								}
							} ]
						}
					}
	
					var barconfig = {
						type : 'bar',
						data : barChartData,
						options : optionsInfo
					};
					<!-- BAR CHART :: JAVA SCRIPT ###### END  -->
	
				}  /* Bar Chart If Logic Ends */
	
				if (reportTypeSelectedText == "Line Chart") {
					lineChartData = JSON.parse(ourRequest.responseText);
					//console.log(lineChartData);
	
					<!-- LINE CHART :: JAVA SCRIPT ###### START  -->
					var lineChartDataAvail = lineChartData.dataAvailable;
					var titletext = 'Base Year to Option Year 3 ' + parameterSelectedText + ' Percentage Summary';
					var yaxeslabelstring = 'Percent of EPs & GPROs in ' + parameterSelectedText;
	
					var lineconfig = {
						type : 'line',
						data : {
							labels : lineChartData.uniqueYears,
							datasets : []
						},
						options : {
							responsive : true,
							title : {
								display : true,
								text : titletext
							},
							legend : {
								position : 'bottom',
							},
							tooltips : {
								mode : 'index',
								intersect : false,
							},
							hover : {
								mode : 'nearest',
								intersect : true
							},
							scales : {
								xAxes : [ {
									display : true,
									scaleLabel : {
										display : true,
										labelString : 'YEAR'
									}
								} ],
								yAxes : [ {
									display : true,
									scaleLabel : {
										display : true,
										labelString : yaxeslabelstring
									},
									ticks : {
										callback : function(label, index, labels) {
											return Number(label).toPrecision(3) + ' %';
										},
										display : true
									}
								} ]
							}
						}
					};
					
					function addData(){						
						
						for (var key in lineChartData) {
							  if (lineChartData.hasOwnProperty(key)) {
							    console.log(key + " -> " + lineChartData[key]);
							    
							    switch(key) {
								    case "claimsPercents":		
								    	lineconfig.data.datasets.push({
											label : "CLAIMS",
											fill : false,
											backgroundColor : window.chartColors.purple,
											borderColor : window.chartColors.purple,
											data : lineChartData.claimsPercents,
										});								    	
								    	console.log("claimsPercents: " + key + " -> " + lineChartData[key]);
								        break;
								    case "ehrPercents":
								    	lineconfig.data.datasets.push({
											label : "EHR",
											fill : false,
											backgroundColor : window.chartColors.green,
											borderColor : window.chartColors.green,
											data : lineChartData.ehrPercents,
										});								    	
								    	console.log("ehrPercents: " + key + " -> " + lineChartData[key]);
								        break;
								    case "registryPercents":
								    	lineconfig.data.datasets.push({
											label : "Registry",
											fill : false,
											backgroundColor : window.chartColors.orange,
											borderColor : window.chartColors.orange,
											data : lineChartData.registryPercents,
										});
								    	console.log("registryPercents: " + key + " -> " + lineChartData[key]);
								        break;
								    case "gprowiPercents":
								    	lineconfig.data.datasets.push({
											label : "GPROWI",
											fill : false,
											backgroundColor : window.chartColors.blue,
											borderColor : window.chartColors.blue,
											data : lineChartData.gprowiPercents,
										});
								    	console.log("gprowiPercents: " + key + " -> " + lineChartData[key]);
								        break;
								    case "qcdrPercents":
								    	lineconfig.data.datasets.push({
											label : "QCDR",
											fill : false,
											backgroundColor : window.chartColors.brown,
											borderColor : window.chartColors.brown,
											data : lineChartData.qcdrPercents,
										});
								    	console.log("qcdrPercents: "+ key + " -> " + lineChartData[key]);
								        break;
								    default:
								        break;
								}
							  }
						}
						
						
					}
					addData();
					<!-- LINE CHART :: JAVA SCRIPT ###### END  -->
	
				} <!-- Line Chart If Logic Ends-->
				if (reportTypeSelectedText == "Map") {
					<!-- TODO for Map-->
				}
				<!-- MAP ENDS -->
	
				<!-- Deleting the <canvas> element and then reappending a new <canvas> to the parent container: To Fix the Hover Over Issue   -->
				resetCanvas();
	
				var chartctx = document.getElementById("chart-canvas").getContext("2d");
	
				<!-- Different Chart Display :: START -->
				if (reportTypeSelectedText == "Bar Chart") {
					document.getElementById("mapIframe").hidden = true;
					if (barChartDataAvail == "YES") {
						//document.getElementById('messageDisplay').style.display = 'none';
						document.getElementById("messageDisplay").innerHTML = "";
						$("messageDisplay").attr("disabled", true);
						var myBarChart = new Chart(chartctx, barconfig);
					}
					if (barChartDataAvail == "NO") {
						$("messageDisplay").attr("disabled", false);
						document.getElementById("messageDisplay").innerHTML = "<div id='NoData'>No Data Available For The Selected Options!</div>";
					}
				}
				if (reportTypeSelectedText == "Line Chart") {
					document.getElementById("mapIframe").hidden = true;
					if (lineChartDataAvail == "YES") {
						document.getElementById("messageDisplay").innerHTML = "";
						$("messageDisplay").attr("disabled", true);
						var myLineChart = new Chart(chartctx, lineconfig);
					}
					if (lineChartDataAvail == "NO") {
						$("messageDisplay").attr("disabled", false);
						document.getElementById("messageDisplay").innerHTML = "<div id='NoData'>No Data Available For The Selected Options!</div>";
					}
				}
	
				<!-- Different Chart Display :: END -->
	
			};
	
			ourRequest.send();
	
		});
	
		var resetCanvas = function() {
			$('#chart-canvas').remove(); // this is my <canvas> element
			$('#chart-container').append('<canvas id="chart-canvas"><canvas>');
		};
	
		document.getElementById("reportTypeId").onchange = function() {
			console.log('Inside on change..');
			var x = document.getElementById("reportTypeId").value;
			console.log('value of x:' + x);
	
			if (x == 'Bar Chart') {
				// Set the Parameter as "ALL" for Bar Chart
				$("#parameterLookupId > option").each(function() {
					if (this.text == 'ALL') {
						$('#parameterLookupId').val(this.value);
					}
				});
			}
	
			if (x == 'Line Chart') {
				// Set Option Year as "ALL" for Line Chart
				$("#yearLookUpId > option").each(function() {
					if (this.text == 'ALL') {
						$('#yearLookUpId').val(this.value);
					}
				});
				// Set Reporting Option as "ALL" for Line Chart
				$("#reportingOptionLookupId > option").each(function() {
					if (this.text == 'ALL') {
						$('#reportingOptionLookupId').val(this.value);
					}
				});
			}
			if (x == 'Map') {
				console.log('Map..');
				var x = document.getElementById("yesOrNoOptionRow")
				x.hidden = false;
			} else {
				var x = document.getElementById("yesOrNoOptionRow")
				x.hidden = true;
			}
		};
	</script>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>