<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css?family=Rubik" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet" />
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
	href="${pageContext.request.contextPath}/resources/css/font-awesome.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/animate.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css"
	rel="stylesheet">
<%-- <link href="${pageContext.request.contextPath}/resources/css/login.css"
	rel="stylesheet"> --%>
<link href="https://fonts.googleapis.com/css?family=Architects+Daughter"
	rel="stylesheet">
<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- [if lt IE 9] -->
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<!--     [endif] -->
</head>
<body>
	<header id="header">
	<div class="top-bar">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-xs-4">
					<div class="top-number">
						<p>
							<i class="fa fa-phone"></i> +1 (410) 277-9781
						</p>
					</div>
				</div>
				<div class="col-sm-6 col-xs-8">
					<div class="social">
					Welcome ${pageContext.request.userPrincipal.name} | <a href="${pageContext.request.contextPath}">Logout</a>
						<!-- <ul class="social-share"> -->
					<!-- 		<li><a title="facebook" target="_blank"
								href="https://www.facebook.com/archsystemsllc"><i
									class="fa fa-facebook"></i></a></li>
							<li><a title="twitter" target="_blank"
								href="https://twitter.com/ArchsystemsMD"><i
									class="fa fa-twitter"></i></a></li>
							<li><a title="linkedin" target="_blank"
								href="https://www.linkedin.com/company/arch-systems-llc"><i
									class="fa fa-linkedin"></i></a></li>
							<li><a title="youtube" target="_blank"
								href="https://www.youtube.com/channel/UCCuPoi5quC8DaAoYc2_nq9A"><i
									class="fa fa-youtube"></i></a></li>
							<li><a title="google+" target="_blank"
								href="https://plus.google.com/107095612689266148490"><i
									class="fa fa-google-plus"></i></a></li> -->
							<!-- <li><a href="#"><i class="fa fa-dribbble"></i></a></li> -->
							<!--   <li><a href="#"><i class="fa fa-skype"></i></a></li> -->
				<!-- 		</ul> -->
						<%--     <div class="search">
                                <form role="form">
                                    <input type="text" class="search-form" autocomplete="off" placeholder="Search">
                                    <i class="fa fa-search"></i>
                                </form>
                           </div> --%>
					</div>
				</div>
			</div>
		</div>
		<!--/.container-->
	</div>
	<!--/.top-bar--> <nav class="navbar navbar-inverse" role="banner">
	<div class="container">
		<table height="110px" >
			<tr >
				<td style="padding-bottom: 0px; border:0px; vertical-align: top">
					<div class="navbar-header">
						<!-- <button type="button" class="navbar-toggle" data-toggle="collapse"
							data-target=".navbar-collapse">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button> -->

						<div class="navbar-brand" style="display:inline">
							<!--<a class="navbar-brand" href="page0.html">-->
							<img
								src="${pageContext.request.contextPath}/resources/images/logo.png"
								alt="logo" height="100px" style="float:left;width: 40%">
							<img
								src="${pageContext.request.contextPath}/resources/images/ADDA.png"
								alt="logo" height="100px" style="float:right;width: 45%;">
						</div>

					</div>
				</td>
				<td width="51%" style="vertical-align: bottom;border:0px; padding: 0px">
					<div class="collapse navbar-collapse navbar-right">
						<ul class="nav navbar-nav">
							<li class="active" style="margin-left:0px"><a
								href="${pageContext.request.contextPath}/login">Home</a></li>
							<li><a
								href="${pageContext.request.contextPath}/admin/dashboard">Hypothesis</a></li>
							<li><a
								href="${pageContext.request.contextPath}/admin/documentupload">Upload</a></li>
							<li><a
								href="${pageContext.request.contextPath}/admin/templates">Download</a></li>
							<li><a href="#">Contact Us</a></li>
						</ul>
					</div>
				</td>
			</tr>
		</table>
	</div>
	<!--/.container--> </nav> <!--/nav--> </header>
</body>
</html>