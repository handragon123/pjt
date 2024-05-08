<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
    /* Navbar 스타일 */
    .navbar {
        background-color: #ffffe0;
        border: 1px solid #ddd;
        border-radius: 4px;
    }
    
    .navbar-header {
        padding: 15px;
    }
    
    .navbar-brand {
        font-size: 20px;
        color: #333;
        text-decoration: none;
    }
    
    .navbar-nav {
        padding: 10px;
    }
    
    .navbar-nav li {
        display: inline-block;
        margin-right: 15px;
    }
    
    .navbar-nav li a {
        font-size: 16px;
        color: #333;
        text-decoration: none;
    }
    
    /* Dropdown 스타일 */
    .dropdown {
        position: relative;
        display: inline-block;
    }
    
    .dropdown-menu {
        display: none;
        position: absolute;
        background-color: #fff;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1;
    }
    
    .dropdown-menu a {
        color: #333;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
    }
    
    .dropdown-menu a:hover {
        background-color: #f1f1f1;
    }
    
    .dropdown:hover .dropdown-menu {
        display: block;
    }
</style>
<title>JSP 게시판 웹 사이트 </title>
</head>
<body>
	<%
		String user_id = null;
		if(session.getAttribute("user_id") != null) {
			user_id = (String)session.getAttribute("user_id");
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
			<li class="active"><a href="main.jsp">메인 </a></li>
			<li><a href="../mbboard/bbs.jsp">게시판 </a></li>
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
					<li><a href="logout.jsp">로그아웃 </a></li>
				</ul>	
			</li>
		</ul>
		<%		
			}
		%>
	    </div>
	</nav>
		
</body>
</html>