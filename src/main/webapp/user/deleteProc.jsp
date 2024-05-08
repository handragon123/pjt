<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/sessionCheck.jsp"%>
<%
// 1. 값을 받고 찍어 본다. 꼭~~
request.setCharacterEncoding("utf-8"); // 한글 처리
String id = (String) session.getAttribute("id");
String password = request.getParameter("password");
boolean isCheck = false;
%>
<%
// 값을 꼭 찍어 보시오.
%>
<%
// 2. DB 처리를 한다.
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null; // select

String driver = "com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3307/mpjt?serverTimezone=UTC";
String user = "root";
String pw = "rpass";


try {
	// 1. driver loading
	Class.forName(driver);
	// 2. connection
	conn = DriverManager.getConnection(url, user, pw);
	out.print("conn ok!!");
	// 3. sql 창

	// 3-1. 패스워드 확인
	String sql = "select user_password from user where user_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	
	if (rs.next()) {
		if (password.equals(rs.getString("user_password"))) {
			isCheck = true;
		}
	}
	if(isCheck){
		// 3.2 탙퇴 처리
		sql = "delete from user where id =?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		// 4. execute
		pstmt.executeUpdate(); // insert, update, delete
	}

} catch (Exception e) {
	e.printStackTrace();
} finally {
	//rs.close();
	pstmt.close();
	conn.close();
}
%>
<%
if(isCheck){
	session.invalidate();
	response.sendRedirect("main.jsp");// jsp : get
}else{
	response.sendRedirect("delete.jsp");// jsp : get
}
%>
