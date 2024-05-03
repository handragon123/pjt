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
request.setCharacterEncoding("utf-8"); 
UserDAO dao = new UserDAO();
List<UserDTO> userList =  dao.getUsers();
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
<h1>User List
<table border="1">
<tr><th>IDX</th><th>ID</th><th>PW</th><th>Name</th><th>Nickname</th></tr>
<%
	for(UserDTO dto : userList) {
		int idx = dto.getUser_idx();
		String id = dto.getUser_id();
		String password = dto.getUser_password();
		String name = dto.getUser_name();
		String nickname = dto.getUser_nickname();
%>
<tr><td><%=idx %><td><%=id %></td><td><%=password %></td><td><%=name %></td><td><%=nickname %></td></tr>
<%} %>
</table>
</h1>
</body>
</html>