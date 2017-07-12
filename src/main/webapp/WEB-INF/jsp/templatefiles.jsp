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
<link href="${pageContext.request.contextPath}/resources/css/table.css"
	rel="stylesheet" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/adda_ico.png"/>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<%-- <link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/docfile.css" /> --%>
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



</head>
<body>
	<jsp:include page="admin_header.jsp"></jsp:include>
	<div class="container">
		<div id="updates" class="boxed">

			<div class="content">
				<div class="table-users">
					<div class="header">Download excel screen</div>
					<table>
						<tbody>
							<tr>
								<th>Name</th>
								<th>Description</th>
								<th>Action</th>
							</tr>
							<c:forEach var="template" items="${templateFiles}">
								<tr>
									<td>
										<p>${template.uploadedFileName}</p>
									</td>
									<td style="text-align: center">
										<p>${template.uploadedDescription}</p>
									</td>
									<td style="text-align: right">
										<!-- <input type=button href="/admin/download-document/${document.id}"  value='Download'> -->
										<a href="${pageContext.request.contextPath}/admin/download-template/${template.id}"><button
												class="btn btn-default">Download</button></a> <!--<input type=button onClick="http://localhost:8484/admin/files/delete-document/${document.id}"  value='Delete'>-->
										<a href="${pageContext.request.contextPath}/admin/delete-template/${template.id}"><button
												class="btn btn-default">Delete</button></a>

									</td>
								</tr>
							</c:forEach>
							<!-- <tr>
						<td >
							<p>Hypothesis2: <a href="http://www.archsystemsinc.com/">Hypothesis2</a></p>
						</td>
						<td>						     
						</td>
						<td>
						    <input type=button onClick="location.href='file:///C:/Suganthi/Test/ornamental1/index1.html'"  value='Download'>		
						</td>
					</tr> -->

							<tr>
								<td></td>
								<td></td>
								<td style="text-align: right"><a
									href="${pageContext.request.contextPath}/admin/download-templates"><button
											class="btn btn-default">Download All</button></a> <a
									href="${pageContext.request.contextPath}/admin/delete-templates"><button
											class="btn btn-default">Delete All</button></a> <!-- <input type=button onClick="location.href='file:///C:/Suganthi/Test/ornamental1/index1.html'"  value='Download All'> -->
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="container" style="margin:1em auto">
					<form:form action="${pageContext.request.contextPath}/admin/new-template/"
						modelAttribute="templateFile" enctype="multipart/form-data"
						method="post">
						<p>
							Description:<br />
							<form:input type="text" path="uploadedDescription" size="30" />
						</p>
						<p>
							Please specify a file, or a set of files:<br />
							<form:input type="file" path="uploadedFile"/>
						</p>
						<div>
							<input class="btn btn-default" type="submit" value="Send" />
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
