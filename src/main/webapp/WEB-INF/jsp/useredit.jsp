<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>ADDA - Edit User</title>
<link href="${pageContext.request.contextPath}/resources/css/table.css"
	rel="stylesheet" />
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/images/adda_ico.png" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/button.css" />
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

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

</head>
<body>
	<jsp:include page="admin_header.jsp"></jsp:include>
	<table id="mid">
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
						difference among reporting options (Claims, Registry, EHR, QCDR
						and GPROWI)
					</p>
				</div>
			</td>
			<td style="vertical-align: top">

				<div id="updates" class="boxed">

					<div class="content">
						<div class="table-users" style="width: 80%">
							<div class="header">Edit <c:out value='${user.name }'/></div>
							
							<div id="breadcrumb">
							        <a href="${pageContext.request.contextPath}/admin/dashboard">Home</a> 
							        <span> >> </span>
							        <a href="${pageContext.request.contextPath}/admin/users">Users</a> 
							        <span> >> </span>
							        <a href="#" style="text-decoration: none;">Edit User</a>
							</div>
							<div class="content">
							    <div class="grid_container">
							        <div class="grid_12 full_block">
							            <div class="widget_wrap">
							                <div class="widget_top">
							                    <span class="h_icon list"></span>
							                </div>
							                <div class="widget_content">
							                    <form:form modelAttribute="user" class="form_container left_label"
							                               action="../edit-user" method="post">
							                        <legend>User Information</legend>
							                                            <div class="form_grid_12">
							                                                <label for="lastname" class="field_title">Full Name</label>
							                                                <div class="form_input">
							                                                    <form:input type="text" class="mid" id="lastname" name="lastname" path="name" ></form:input>
							                                                    <form:input type="hidden" id="id" name="id" path="id"></form:input>
							                                                </div>
							                                            </div>
							                                            <div class="form_grid_12">
							                                                <label for="username" class="field_title">User Name</label>
							                                                <div class="form_input">
							                                                    <form:input type="text" class="mid" id="username" name="username" path="username" ></form:input>
							                                                </div>
							                                            </div>
							                                            <div class="form_grid_12">
							                                                <label for="password" class="field_title">Password</label>
							                                                <div class="form_input">
							                                                    <form:password showPassword="true" id="password" name="password"
							                                                                   path="password" class="mid"></form:password>
							                                                </div>
							                                            </div>
							                                            <!-- <div class="form_grid_12">
							                                                <label for="passwordConfirm" class="field_title">Confirm Password</label>
							                                                <div class="form_input">
							                                                    <form:password showPassword="true" id="passwordConfirm" name="passwordConfirm"
							                                                                   path="passwordConfirm" class="mid"></form:password>
							                                                </div>
							                                            </div> -->
							                                            <div class="form_grid_12">
							                                                <label for="email" class="field_title">Email Address</label>
							                                                <div class="form_input">
							                                                    <form:input type="text" id="email" class="mid" name="email" path="email" ></form:input>
							                                                </div>
							                                            </div>
							                                  <div class="form_grid_12">
							                                  
														   
														</div>	
														
							                                <div class="form_grid_12">
							                                    <button type="submit" class="btn_small btn_blue"><span>Update</span></button>
							                                    <button type="reset" class="btn_small btn_blue"><span>Reset</span></button>
							                                </div>
							                            
							                    </form:form>
							                </div>
							            </div>
							        </div>
							    </div>
							</div>
						</div>
					</div>
				</div>

			</td>
		</tr>
	</table>
	<jsp:include page="footer.jsp"></jsp:include>
	<script type="text/javascript">
	var h;
	h=screen.height-357;
	document.getElementById('mid').style.minHeight=h+'px';
	$(document).ready(function () {
				 $('.nav > li').eq(2).addClass('active');			 
	});	
	</script>
</body>
</html>
