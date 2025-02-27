<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- <%@taglib uri="spring.tld" prefix="spring"%> --%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String servletPath = (String)request.getAttribute("javax.servlet.forward.servlet_path");
String[] list = servletPath.split("\\/");
request.setAttribute("role",list[1]);
request.setAttribute("topMenuId",list[2]);
request.setAttribute("leftMenuId",list[3]);
%>

<!DOCTYPE html>
<html>
  <head>
    	<base href="<%=basePath%>">

    	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta charset="utf-8"><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>培训管理</title>
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="keywords" content="">
		<link rel="shortcut icon" href="<%=basePath%>resources/images/favicon.ico" />
		<link href="resources/bootstrap/css/bootstrap-huan.css" rel="stylesheet">
		<link href="resources/font-awesome/css/font-awesome.min.css" rel="stylesheet">
		<link href="resources/css/style.css" rel="stylesheet">

		<link href="resources/css/exam.css" rel="stylesheet">
		<link href="resources/chart/morris.css" rel="stylesheet">
		<style type="text/css">

			a.btn{
				    margin-top: 0px;
			}
			.section-navi-item {
			    display: inline-block;
			    height: 24px;
			    background: rgb(239,237,237);
			     padding:0 10px;
			    margin: 3px;
			    font-family: arial;
			    text-align: center;
			    line-height: 24px;
			    color: #428bca;
			    font-size: 12px;
			    cursor: pointer;
			}
		</style>
	</head>
	<body>
		<header>
			<span style="display:none;" id="rule-role-val"><%=list[1]%></span>
			<div class="container">
				<div class="row">
					<div class="col-xs-5">
						<div class="logo">
							<h1><a href="#">网站管理系统</a></h1>
							<div class="hmeta">
								专注互联网在线考试解决方案
							</div>
						</div>
					</div>
					<div class="col-xs-7" id="login-info">
						<c:choose>
							<c:when test="${not empty sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}">
								<div id="login-info-user">

									<a href="user-detail/${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}" id="system-info-account" target="_blank">${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.username}</a>
									<span>|</span>
									<a href="j_spring_security_logout"><i class="fa fa-sign-out"></i> 退出</a>
								</div>
							</c:when>
							<c:otherwise>
								<a class="btn btn-primary" href="user-register">用户注册</a>
								<a class="btn btn-success" href="user-login-page">登录</a>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
		</header>
		<!-- Navigation bar starts -->

		<div class="navbar bs-docs-nav" role="banner">
			<div class="container">
				<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
					<c:import url="/common-page/top-menu?topMenuId=${topMenuId}&leftMenuId=${leftMenuId}" charEncoding="UTF-8" />
				</nav>
			</div>
		</div>

		<!-- Navigation bar ends -->

		<!-- Slider starts -->

		<div>
			<!-- Slider (Flex Slider) -->

			<div class="container" style="min-height:500px;">

				<div class="row">
					<div class="col-xs-2" id="left-menu">
						<c:import url="/common-page/left-menu?topMenuId=${topMenuId}&leftMenuId=${leftMenuId}" charEncoding="UTF-8" />

					</div>
					<div class="col-xs-9">
						<div class="page-header">
							<h1> <i class="fa fa-bar-chart-o"></i> 培训进度</h1>
						</div>
						<div class="page-content">
							<div class="row">
								<div class="col-xs-12">
									<input type="hidden" id="training-id-hidden" value="${trainingId }">
									<div id="exampaper-list">
									<div class="table-search table-controller-item"	style="float: left; width: 200px;margin-top:10px;">
										<div class="input-group search-form">
											<input type="text" class="form-control" placeholder="搜索学员" value="${searchStr }"
											id="txt-search">
											<span class="input-group-btn">
												<button class="btn btn-sm btn-default" type="button"
												id="btn-search" >
													<i class="fa fa-search"></i>搜索
												</button> </span>
										</div>
									</div>
									<table class=" table" id="training-table">
										<thead>
											<tr>
												<td>学员ID</td><td>学员姓名</td><td>部门</td><td>学习进度</td>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${userTrainingList }" var="item">
												<tr>
													<td>${item.userName }</td>
													<td>${item.trueName }</td>
													<td>${item.depName }</td>
													<td>
														<div>
															<c:forEach items="${processMap[item.userId] }" var="processItem">
																<c:choose>
																	<c:when test="${processItem.process == 1 }">
																		<a class="section-navi-item navi-item-success">${processItem.sectionName }</a>
																	</c:when>
																	<c:otherwise>
																		<a class="section-navi-item">${processItem.sectionName }</a>
																	</c:otherwise>
																</c:choose>

															</c:forEach>

														</div>
													</td>

												</tr>
											</c:forEach>

										</tbody><tfoot></tfoot>
									</table>
								</div>
							</div>

							<div id="page-link-content">

								<ul class="pagination pagination-sm">
									${pageStr}
								</ul>
							</div>




						</div>
					</div>
				</div>
			</div>

		</div>
		<%--<footer>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copy">
							<p>
								ExamStack Copyright © <a href="http://www.examstack.com/" target="_blank">ExamStack</a> - <a href="." target="_blank">主页</a> | <a href="http://www.examstack.com/" target="_blank">关于我们</a> | <a href="http://www.examstack.com/" target="_blank">FAQ</a> | <a href="http://www.examstack.com/" target="_blank">联系我们</a>
							</p>
						</div>
					</div>
				</div>

			</div>

		</footer>--%>

		<!-- Slider Ends -->

		<!-- Javascript files -->
		<!-- jQuery -->
		<script type="text/javascript" src="resources/js/jquery/jquery-1.9.0.min.js"></script>
		<!-- Bootstrap JS -->
		<script type="text/javascript" src="resources/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="resources/chart/raphael-min.js"></script>
		<script type="text/javascript" src="resources/js/all.js"></script>
		<script type="text/javascript" src="resources/js/training-process-list.js"></script>

	</body>
</html>
