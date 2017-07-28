<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>INTERACTIVE MAPS</title>
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
	color: #000; font-weight : bold; text-align : center;
	margin: auto;
	text-align: center;
	font-weight: bold;
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
				<h2 style="text-align: center; font-size: 50px;">ADDA</h2>
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
							<td><label for="reportTypeId">Report Type :</label></td>
							<td><select id="reportTypeId" name="reportTypeId"
								title="Select one of the Reporting Types, only one reporting type may be displayed at one time">
									<option value="">Select</option>
									<c:forEach items="${reportTypes}" var="reportType">
										<option value="${reportType}">${reportType}</option>
									</c:forEach>
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
		//var serverContextPath = '${pageContext.request.contextPath}';
		//var serverContextPath = 'http://localhost:8080/imapservices';
		var serverContextPath = 'http://ec2-34-208-54-139.us-west-2.compute.amazonaws.com/imapservices';
		
	
		btn.addEventListener("click", function() {
			$('#loading-gif').show(); 
			$('#chart-canvas').hide();
			//var yesOrNoOptionId = $("#yesOrNoOptionId option:selected").text();
			var reportTypeSelectedText = $("#reportTypeId option:selected").text();
	
			var yearId = document.getElementById("yearLookUpId").value;
			var yearSelectedText = $("#yearLookUpId option:selected").text();
			var reportingOptionId = document.getElementById("reportingOptionLookupId").value;
			var reportingOptionSelectedText = $("#reportingOptionLookupId option:selected").text();
			//var parameterId = document.getElementById("parameterLookupId").value;
			//var parameterSelectedText = $("#parameterLookupId option:selected").text();
	
			
			if (reportTypeSelectedText == "Line Chart") {
				//var url = serverContextPath + '/api/lineChart/dataAnalysisId/${dataAnalysisId}/subDataAnalysisId/${subDataAnalysisId}/parameterId/' + parameterId;
				var url = serverContextPath + '/api/h3/lineChart/dataAnalysisId/${dataAnalysisId}/subDataAnalysisId/${subDataAnalysisId}';
			}			
	
			var ourRequest = new XMLHttpRequest();
			ourRequest.open('GET', url);
			ourRequest.onload = function() {
				$('#loading-gif').hide();
				$('#chart-canvas').show();				
	
				if (reportTypeSelectedText == "Line Chart") {
					lineChartData = JSON.parse(ourRequest.responseText);
					//console.log(lineChartData);
	
					<!-- LINE CHART :: JAVA SCRIPT ###### START  -->
					var lineChartDataAvail = lineChartData.dataAvailable;
					//var titletext = 'Base Year to Option Year 3 ' + parameterSelectedText + ' Percentage Summary';
					//var yaxeslabelstring = 'Percent of EPs & GPROs in ' + parameterSelectedText;
					
					var titletext = 'Base Year to Option Year 3 Exclusion Rate Summary';
					var yaxeslabelstring = 'yaxeslabelstring';
	
					var lineconfig = {
						type : 'line',
						data : {
							labels : lineChartData.uniqueYears,
							datasets : [ {
								label : "CLAIMS",
								fill : false,
								backgroundColor : window.chartColors.yellow,
								borderColor : window.chartColors.yellow,
								data : lineChartData.claimsPercents,
							}, {
								label : "EHR",
								fill : false,
								backgroundColor : window.chartColors.green,
								borderColor : window.chartColors.green,
								data : lineChartData.ehrPercents,
							}, {
								label : "Registry",
								fill : false,
								backgroundColor : window.chartColors.orange,
								borderColor : window.chartColors.orange,
								data : lineChartData.registryPercents,
							}, {
								label : "GPROWI",
								fill : false,
								backgroundColor : window.chartColors.darkblue,
								borderColor : window.chartColors.darkblue,
								data : lineChartData.gprowiPercents,
							}, {
								label : "QCDR",
								fill : false,
								backgroundColor : window.chartColors.brown,
								borderColor : window.chartColors.brown,
								data : lineChartData.qcdrPercents,
							} ]
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
											return label + ' %';
										},
										display : true
									}
								} ]
							}
						}
					};
					<!-- LINE CHART :: JAVA SCRIPT ###### END  -->
	
				} <!-- Line Chart If Logic Ends-->
				
				<!-- Deleting the <canvas> element and then reappending a new <canvas> to the parent container: To Fix the Hover Over Issue   -->
				resetCanvas();
	
				var chartctx = document.getElementById("chart-canvas").getContext("2d");	
				
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
			
		};
	</script>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>