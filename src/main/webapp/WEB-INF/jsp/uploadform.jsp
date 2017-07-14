<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>INTERACTIVE MAPS</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/adda_ico.png" />

<link
	href="${pageContext.request.contextPath}/resources/css/responsive.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/prettyPhoto.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css"
	rel="stylesheet" />
<link
	href="${pageContext.request.contextPath}/resources/css/animate.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/table.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/es6-shim/0.33.3/es6-shim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/systemjs/0.19.20/system-polyfills.js"></script>
<script
	src="https://code.angularjs.org/2.0.0-beta.6/angular2-polyfills.js"></script>
<script src="https://code.angularjs.org/tools/system.js"></script>
<script src="https://code.angularjs.org/tools/typescript.js"></script>
<script src="https://code.angularjs.org/2.0.0-beta.6/Rx.js"></script>
<script src="https://code.angularjs.org/2.0.0-beta.6/angular2.dev.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<style>
.hidden {
	display: none;
}

table td {
	border: 0px;
}
</style>

</head>
<body>
	<jsp:include page="admin_header.jsp" />
	<table style="min-height: 580px">
		<tr>
			<td
				style="background-color: #327a89; width: 30%; vertical-align: top; padding: 0px 25px">
				<div style="color: #fff">
					<!-- <ul style="border-bottom: solid #fff 2px" type="square">
						<li><h2
								style="color: #fff; font-family: 'Rubik', sans-serif;">Description</h2></li>
					</ul> -->
					<p style="text-align: justify; font-family: 'Rubik', sans-serif;">
						<br></br> <br></br>From the Base Year to Option Year 3 Rural Area
						Percentage line plot, we would like to see the change trend of the
						rural area percentage of all combined EPs and GPROs and the
						difference among reporting options (Claim, Registry, EHR, QCDR and
						GPROWI)
					</p>
				</div>
			</td>
			<td style="vertical-align: top; text-align: center;">
				<!-- <div class="container" style="min-height: 600px"> -->
				<div id="updates">
					<h2 class="title" style="font-size:30px">Upload excel data</h2>
					<div class="content">
						<form:form
							action="${pageContext.request.contextPath}/admin/documentupload/"
							modelAttribute="documentFileUpload" enctype="multipart/form-data"
							method="post">
							<c:if test="${not empty documentuploadsuccess}">
								<br />
								<div class="successblock">
									<spring:message code="${documentuploadsuccess}"></spring:message>
								</div>
							</c:if>
							<c:if test="${not empty documentuploaderror}">
								<br />
								<div class="successblock">
									<spring:message code="${documentuploaderror}"></spring:message>
								</div>
							</c:if>
							<form:errors path="*" cssClass="errorblock" element="div" />
							<div>
								<form:select path="providerHypId" id="ddl1"
									onchange="configureDropDownLists(this,document.getElementById('ddl2'))">
									<option value="0">Select</option>
									<c:forEach var="category" items="${dataAnalysisCategories}">
										<option value="${category.id}">${category.dataAnalysisName}</option>
									</c:forEach>
								</form:select>
								<form:select path="providerSubHypId" id="ddl2" class="hidden">
									<!--<option value="0">NA</option>-->
									<!--<c:forEach var="subCategory"
							items="${subDataAnalysisCategories}">
							<option value="${subCategory.id}">${subCategory.subDataAnalysisName}</option>
						</c:forEach>-->
								</form:select>
							</div>
							<br></br>
							<table>
								<tr>
									<td>
										<p>Document Provider :</p>
									</td>
									<td>
										<p>
											<form:input type="file" path="provider" size="40" />
										</p>
									</td>
									<td>
										<div class="btn-group btn-xs">
											<input class="btn btn-primary" type="submit" value="Upload"
												id="provider-upload" /> <input class="btn btn-info"
												type="reset" value="Reset" />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<p>Document Specialty :</p>
									</td>
									<td>
										<p>
											<form:input type="file" path="specialty" size="40" />
										</p>
									</td>
									<td>
										<div class="btn-group btn-xs">
											<input class="btn btn-primary" type="submit" value="Upload" />
											<input class="btn btn-info" type="reset" value="Reset" />
										</div>
									</td>
								</tr>
								<tr>
									<td>
										<p>Document Statewise :</p>
									</td>
									<td>
										<p>
											<form:input type="file" path="statewise" size="40" />
										</p>
									</td>
									<td>
										<div class="btn-group btn-xs">
											<input class="btn btn-primary" type="submit" value="Upload" />
											<input class="btn btn-info" type="reset" value="Reset" />
										</div>
									</td>
								</tr>
							</table>
						</form:form>
					</div>
				</div> <!-- </div> -->

			</td>
		</tr>
	</table>
	<jsp:include page="footer.jsp" />
	<script type="text/javascript">
		function configureDropDownLists(ddl, ddl2) {
			var ele = document.getElementById("ddl1");
			var seleHypoId = ele.options[ele.selectedIndex].value;
			$('#ddl2').empty();
	
			if (seleHypoId === "0") {
				$('#ddl2').addClass('hidden');
				$('#provider-upload').attr("disabled", "disabled");
			} else {
				$.ajax({
					url : "http://localhost:8080/imapservices/api/subdata/hypothesis/" + seleHypoId,
					type : 'GET',
					dataType : 'json',
					success : function(data) {
						if (data.length == 0) {
							$('#ddl2').addClass('hidden');
						} else {
							$('#ddl2').removeClass('hidden');
							for (i = 0; i < data.length; i++) {
								createOption(ddl2, data[i].subDataAnalysisName, data[i].id);
							}
						}
						$('#provider-upload').removeAttr('disabled');
	
					},
					error : function(request, error) {
						alert("Request: " + JSON.stringify(request));
					}
				});
			}
	
		}
	
		function createOption(ddl, text, value) {
			var opt = document.createElement('option');
			opt.value = value;
			opt.text = text;
			ddl.options.add(opt);
		}
	</script>

</body>
</html>
