<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Hypothesis</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/adda_ico.png">
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet"> --%>
<link href="${pageContext.request.contextPath}/resources/css/table.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/button.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>

<body>
	<sec:authorize
		access="hasAuthority('Report Viewer')">
		<jsp:include page="header.jsp"></jsp:include>
	</sec:authorize>

	<table style="min-height: 600px">
		<tr>
			<td
				style="background-color: #327a89; vertical-align: top; padding: 0px 25px">
				<div style="color: #fff">
					<!-- <ul style="border-bottom: solid #fff 2px" type="square">
							<li><h2 style="color: #fff;">Description</h2></li>
						</ul> -->
					<p style="font-family: 'Rubik', sans-serif; text-align: justify;"><br><br>From
						the Base Year to Option Year 3 Rural Area Percentage line plot, we
						would like to see the change trend of the rural area percentage of
						all combined EPs and GPROs and the difference among reporting
						options (Claim, Registry, EHR, QCDR and GPROWI)</p>
				</div>
			</td>
			<td style="padding: 10px 105px; vertical-align: top">
				<div class="DataAnalysisScreen">

					<script type="text/javascript">console.log("justprint")
						</script>
					<div class="table-users">
						<div class="header">Data Analysis</div>

						<table id="dataAnalysisTableId" class="display">
							<thead style="font-weight: bold">
								<tr>
									<th align="center">Data Analysis Name</th>
									<th align="center">Action</th>
								</tr>
							</thead>

							<tbody>

								<c:forEach items="${dataAnalysisList}" var="dataAnalysis">								    
									<tr>
										<td><a title = "${dataAnalysis.dataAnalysisDescription}"
											href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/0">${dataAnalysis.dataAnalysisName}</a>
										</td>

										<td style="text-align: center"><a
											href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/0"><button
													title = "Select view to see the results of the Analysis" class="button search" id="view" value="View">View</button></a>
											<button title = "Select to download the report for the Hypothesis selected" class="button arrow" id="download" value="Download">Download</button>
										</td>

									</tr>

									<c:forEach items="${dataAnalysis.subDataAnalysis}"
										var="subDataAnalysis">

										<c:if
											test="${subDataAnalysis.subDataAnalysisName ne 'Not Applicable'}">
                                           <c:choose>
											    <c:when test="${dataAnalysis.id =='3'}">
											       <tr>
														<td>
															<ul>
																<li><a title = "${subDataAnalysis.subDataAnalysisDescription}"
																	href="${pageContext.request.contextPath}/measures/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/${subDataAnalysis.id}">${subDataAnalysis.subDataAnalysisName}</a>
																</li>
															</ul>
														</td>
		
														<td style="text-align: center"><a
															href="${pageContext.request.contextPath}/measures/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/${subDataAnalysis.id}"><button
																	title = "Select view to see the results of the Analysis" class="button search" id="view" value="View">View</button></a>
															<button title = "Select to download the report for the Hypothesis selected" class="button arrow" id="download" value="Download">Download</button>
														</td>
													</tr>
											    </c:when>    
											    <c:otherwise>
											       <tr>
														<td>
															<ul>
																<li><a title = "${subDataAnalysis.subDataAnalysisDescription}"
																	href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/${subDataAnalysis.id}">${subDataAnalysis.subDataAnalysisName}</a>
																</li>
															</ul>
														</td>
		
														<td style="text-align: center"><a
															href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/${subDataAnalysis.id}"><button
																	title = "Select view to see the results of the Analysis" class="button search" id="view" value="View">View</button></a>
															<button title = "Select to download the report for the Hypothesis selected" class="button arrow" id="download" value="Download">Download</button>
														</td>
													</tr>
											    </c:otherwise>
											</c:choose>
										</c:if>

									</c:forEach>

								</c:forEach>

							</tbody>

						</table>

						<!-- 	
<script type="text/javascript">
	$(document).ready(function() {
	    $('#dataAnalysisTableId').DataTable();
	} );
</script>

 -->
					</div>
				</div>
			</td>
		</tr>
	</table>
	<jsp:include page="footer.jsp"></jsp:include></body>
</html>
