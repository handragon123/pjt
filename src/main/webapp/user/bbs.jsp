<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<title>JSP 게시판 웹 사이트 </title>
</head>
<body>
	<%
		String user_id = null;
		if(session.getAttribute("user_id") != null) {
			user_id = (String) session.getAttribute("user_id");
		}
	%>
	<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
		aria-expanded="false">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="main.jsp">JSP게시판 웹 사이트 </a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인 </a></li>
			<li class="active"><a href="free_board.jsp">게시판 </a></li>
		</ul>
		<%
			if(user_id == null ){
		%>		
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기 <span class="caret">로그인 </span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인 </a></li>
					<li><a href="join.jsp">회원가입 </a></li>
				</ul>	
			</li>
		</ul>
		<% 		
			} else {
		%>		
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리 <span class="caret">로그인 </span></a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp">로그아웃 </a></li>
				</ul>	
			</li>
		</ul>
		<%		
			}
		%>
	    </div>
	</nav>
	<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #ddddd">
			<thead>
				<tr>
					<th style="background-color: #eeeee; text-align: center;">번호 </th>
					<th style="background-color: #eeeee; text-align: center;">제목 </th>
					<th style="background-color: #eeeee; text-align: center;">작성자 </th>
					<th style="background-color: #eeeee; text-align: center;">작성일 </th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td>안녕하세요?. </td>
					<td>김민주 </td>
					<td>2024-05-07 </td>
				</tr>
			</tbody>
		</table>
		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기 </a>
		</div>
	</div>
	
	
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>