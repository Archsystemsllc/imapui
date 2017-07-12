<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Hypothesis</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />

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
	<jsp:include page="admin_header.jsp"></jsp:include>
	<table style="min-height:600px">
		<tr>
			<td width="30%"
				style="background-color: #1B2631; vertical-align: top; padding: 0px 25px">
				<div style="color: #fff">
					<ul style="border-bottom: solid #fff 2px" type="square">
						<li><h2 style="color: #fff;font-family: 'Rubik', sans-serif;">Description</h2></li>
					</ul>
					<p style="text-align: justify;font-family: 'Rubik', sans-serif;">From the Base Year to Option
						Year 3 Rural Area Percentage line plot, we would like to see the
						change trend of the rural area percentage of all combined EPs and
						GPROs and the difference among reporting options (Claim, Registry,
						EHR, QCDR and GPROWI)</p>
				</div>
			</td>
			<td style="padding: 10px 105px;vertical-align:top">
				<div class="DataAnalysisScreen">

					<script type="text/javascript">console.log("justprint")
					</script>
					<div class="table-users">
						<div class="header">Data Analysis</div>

						<table id="dataAnalysisTableId" class="display">
							<thead style="font-weight: bold">
								<tr>
									<th align="center">Data Analysis Name</th>
									<th align="center">Description</th>
									<th align="center">Action</th>
								</tr>
							</thead>

							<tbody>

								<c:forEach items="${dataAnalysisList}" var="dataAnalysis">
									<tr>
										<td><a
											href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/0">${dataAnalysis.dataAnalysisName}</a>
										</td>

										<td style="text-align: center">${dataAnalysis.dataAnalysisDescription}</td>

										<td style="text-align: center"><a
											href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/0"><button
													class="button search" id="view" value="View">View</button></a>
											<button class="button arrow" id="download" value="Download">Download</button>
										</td>

									</tr>

									<c:forEach items="${dataAnalysis.subDataAnalysis}"
										var="subDataAnalysis">

										<c:if
											test="${subDataAnalysis.subDataAnalysisName ne 'Not Applicable'}">

											<tr>
												<td>
													<ul>
														<li><a
															href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/${subDataAnalysis.id}">${subDataAnalysis.subDataAnalysisName}</a>
														</li>
													</ul>
												</td>

												<td style="text-align: center">${subDataAnalysis.subDataAnalysisDescription}</td>

												<td style="text-align: center"><a
													href="${pageContext.request.contextPath}/mapandchartdisplay/dataAnalysisId/${dataAnalysis.id}/subDataAnalysisId/${subDataAnalysis.id}"><button
															class="button search" id="view" value="View">View</button></a>
													<button class="button arrow" id="download" value="Download">Download</button></td>

											</tr>

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
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
