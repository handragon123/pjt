<%@page import="mpjt.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="mpjt.dao.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="mpjt.dto.UserDTO" scope="page" />
<jsp:setProperty name="user" property="user_id" />
<jsp:setProperty name="user" property="user_password" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
   <%
      String user_id = null;
   if(session.getAttribute("user_id") != null) {
      user_id = (String)session.getAttribute("user_id");
   }
      if(user_id != null) {
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('이미 로그인이 되어있습니다. ')");
         script.println("location.href = 'main.jsp'");
         script.println("</script>");
      }
      UserDAO userDAO = new UserDAO();
      int result = userDAO.login(user.getUser_id(), user.getUser_password());
      if(result == 1) {
      session.setAttribute("user_id", user.getUser_id());
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("location.href = 'main.jsp'");
         script.println("</script>");
      } 
      else if(result == 0) { // 비밀번호 틀릴 경우 
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('비밀번가 틀립니다. ')");
         script.println("history.back()"); //이전페이지로 돌려보냄 
         script.println("</script>");
      }
      else if(result == -1) { // 아이디 존재하지 않을  
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('존재하지 않는 아이디입니다.  ')");
         script.println("history.back()"); //이전페이지로 돌려보냄 
         script.println("</script>");
      }
      else if(result == -2) { // 아이디 존재하지 않을  
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('데이터베이스 오류가 발생했습니다.  ')");
         script.println("history.back()"); //이전페이지로 돌려보냄 
         script.println("</script>");
      } 
   %>
</body>
</html>