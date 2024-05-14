<%@page import="mpjt.common.PageDTO"%>
<%@page import="mpjt.dto.UserDTO"%>
<%@page import="mpjt.dao.UserDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
List<UserDTO> userList =  (List<UserDTO>)request.getAttribute("userList");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userList.jsp</title>
</head>
<body>
<%@ include file="main.jsp" %>
<hr>
<h1>User List</h1>
<table border="1">
<tr><th>IDX</th><th>ID</th><th>PW</th><th>Name</th><th>gen</th><th>user_regd</th><th>user_upd</th></tr>
<%
   for(UserDTO dto : userList) {
      int idx = dto.getUser_idx();
      String id = dto.getUser_id();
      String password = dto.getUser_password();
      String name = dto.getUser_name();
      String gen = dto.getUser_gen();
      String user_regd = dto.getUser_regd();
      String user_upd = dto.getUser_upd();
%>
<tr><td><%=idx %><td><%=id %></td><td><%=password %></td><td><%=name %></td><td><%=gen %></td><td><%=user_regd %></td><td><%=user_upd %></td></tr>
<%} %>
<% 
PageDTO p = (PageDTO)request.getAttribute("paging");
%>
<tr>
<td colspan="6">
<%if(p.isPrev()) {%><a href="userListPage.do?pageNum=<%=p.getStartPage()-1%>">[Prev]</a><%} %>
<%for(int i=p.getStartPage(); i<= p.getEndPage(); i++) {%>
	<%if(i == p.getPageNum()){%>
		<b>[<%=i %>]</b>
	<%}else{ %>
	<a href="userListPage.do?pageNum=<%=i%>">[<%=i %>]</a>
	<%} %>
<%} %>
<%if(p.isNext()){%><a href="userListPage.do?pageNum=<%=p.getEndPage()+1%>">[Next]</a><%} %>
</td>
</tr>
</table>

</body>
</html>