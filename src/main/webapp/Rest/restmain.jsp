<%@page import="mpjt.dto.RestDTO"%>
<%@page import="java.util.List"%>
<%@page import="mpjt.dao.RestDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");

Map<String, String> map = new HashMap<>();
map.put("searchField", searchField);
map.put("searchWord", searchWord);


RestDAO dao = new RestDAO();

List<RestDTO> restLists = dao.selectList(map);
int totalCount = dao.selectCount(map);
%>

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
		<a class="navbar-brand" href="../user/main.jsp">JSP게시판 웹 사이트 </a>
	</div>
	</nav>
	<div class="container">
	<div class="row">
		<h2>Board List</h2>
<form method="get">
<table border="1" width="90%">
	<tr>	
	<td>
		<select name="searchField">
			<option value="rs_name">이름</option>
			<option value="rs_addr">주소</option>
		</select>
		<input type="text" name="searchWord">
		<input type="submit" value="Search">
	</td>
	</tr>
</table>
</form>
<table border="1" width="90%">
<tr><td colspan="5">&nbsp;<b>전체 : <%=totalCount %></b></td></tr>
	<tr>
		<th width="10%">번호</th>
		<th width="10%">이름</th>
		<th width="10%">주소</th>
		<th width="10%">전화번호</th>
		<th width="20%">영업시간</th>
		<th width="10%">조회수</th>
		<th width="10%">종류</th>
		<th width="20%">리뷰</th>
	</tr>
<%if(restLists.isEmpty()) {%>	
	<tr><td colspan="5">&nbsp;<b>Data Not Found!!</b></td></tr>
<%}else{ %>
	<%for(RestDTO rest : restLists){ %>	
		<tr align="center">
			<td width="10%"><%=rest.getRs_idx() %></td>
			<td><a href="view.jsp?num=<%=rest.getRs_idx()%>"><%=rest.getRs_name() %></a></td>
			<td width="10%"><%=rest.getRs_addr() %></td>
			<td width="10%"><%=rest.getRs_tell()%></td>			
			<td width="20%"><%=rest.getRs_hour() %></td>			
			<td width="10%"><%=rest.getRs_visitnum() %></td>
			<td width="10%"><%=rest.getRs_type() %></td>
			<td width="20%"><%=rest.getRs_reviews() %></td>
		</tr>
	<%} %>
<%} %>
</table>

		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기 </a>
		</div>
	</div>
	
	
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>