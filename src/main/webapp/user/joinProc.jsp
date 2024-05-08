<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 1. 값을 받고 찍어 본다. 꼭~~
request.setCharacterEncoding("utf-8"); // 한글 처리
String id = request.getParameter("user_id");
String password = request.getParameter("user_password");
String name = request.getParameter("user_name");
String role = request.getParameter("user_gen");
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

// 중복 체크를 위한 변수
boolean isDuplicate = false;

try{
	// 1. driver loading
	Class.forName(driver);	
	// 2. connection
	conn = DriverManager.getConnection(url, user, pw);
	out.print("conn ok!!");
	
	// 3. 중복 체크
	String checkSql = "SELECT user_id FROM user WHERE user_id=?";
	pstmt = conn.prepareStatement(checkSql);
	pstmt.setString(1, id);
	rs = pstmt.executeQuery();
	
	if (rs.next()) {
		// 이미 존재하는 ID인 경우
		isDuplicate = true;
	}
	
	// 중복이 아닌 경우에만 사용자 추가
	if (!isDuplicate) {
		// 4. sql 창
		String insertSql = "insert into user(user_id, user_password, user_name, user_gen) values(?,?,?,?)";
		pstmt = conn.prepareStatement(insertSql);
		pstmt.setString(1,id);
		pstmt.setString(2,password);
		pstmt.setString(3,name);
		pstmt.setString(4,role);
		// 5. execute
		pstmt.executeUpdate();	// insert, update, delete
	}
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	if (rs != null) {
		rs.close();
	}
	if (pstmt != null) {
		pstmt.close();
	}
	if (conn != null) {
		conn.close();
	}
}

// 중복 체크 후 처리
if (isDuplicate) {
	// 중복된 ID인 경우 메시지 출력 후 이전 페이지로 돌아감
	out.println("<script>alert('중복된 ID입니다.'); history.back();</script>");
} else {
	// 중복되지 않은 경우 로그인 페이지로 이동
	response.sendRedirect("login.jsp");
}
%>
