<%@page import="mpjt.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mpjt.dao.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="mpjt.dto.UserDTO" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_password" />
<jsp:setProperty name="user" property="user_name" />
<jsp:setProperty name="user" property="user_gen" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
	String user_id = null;
	if (session.getAttribute("user_id") != null) {
		user_id = (String) session.getAttribute("user_id");
	}
	// 		if(user_id != null) {
	// 			PrintWriter script = response.getWriter();
	// 			script.println("<script>");
	// 			script.println("alert('이미 로그인이 되어있습니다. ')");
	// 			script.println("location.href = 'main.jsp'");
	// 			script.println("</script>");
	// 		}

	// 입력값 없을시
	if (user.getUser_id() == null || user.getUser_password() == null || user.getUser_name() == null
			|| user.getUser_gen() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다. ')");
		script.println("history.back()");
		script.println("</script>");
	} else { // 입력값 다 있음
		
		// join.jsp에서 값 받아오기
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("user_id");
		String password = request.getParameter("user_password");
		String name = request.getParameter("user_name");
		String gen = request.getParameter("user_gen");

		// 2. 받은 값 찍어보기
		System.out.printf("%s,%s,%s,%s", id, password, name, gen);
		
		
		UserDAO userDAO = new UserDAO();
		// dto에 값 넣기
		UserDTO dto = new UserDTO(id, password, name, gen);
		
		// user.join 실행후 result값 리턴받기
		int result = userDAO.join(user);
		
		if (result == 1) { // 회원가입 성공
			session.setAttribute("user_id", user.getUser_id());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입 성공!! ')");
			script.println("location.href = 'login.jsp'"); // 회원가입 성공하면 메인창으로 보냄 
			script.println("</script>");

		} else { // 회원가입이 이루어진 실패 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다. ')");
			script.println("history.back()"); //이전페이지로 돌려보냄 
			script.println("</script>");
		}
	}
	%>
</body>
</html>