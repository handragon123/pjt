<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="mpjt.dao.BoardDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
   <jsp:useBean id="bbs" class="mpjt.dto.BoardDTO" scope="page" />
   <jsp:setProperty name="bbs" property="fr_title" />
   <jsp:setProperty name="bbs" property="fr_cont" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트 </title>
</head>
<body>
<% 
    // 현재 세션 상태 체크 
    String user_id = (String)session.getAttribute("user_id");
    if(user_id == null) {
        out.println("<script>");
        out.println("alert('로그인을 하세요.');");
        out.println("location.href = 'login.jsp';");
        out.println("</script>");
    } else {
        if(bbs.getFr_title() == null || bbs.getFr_cont() == null) {
            out.println("<script>");
            out.println("alert('입력이 안 된 사항이 있습니다.');");
            out.println("history.back();");
            out.println("</script>");
        } else {
            BoardDAO boardDAO = new BoardDAO();
            int result = boardDAO.write(bbs.getFr_title(), user_id, bbs.getFr_cont());
            if(result == -1) {
                out.println("<script>");
                out.println("alert('글쓰기에 실패했습니다.');");
                out.println("history.back();"); //이전페이지로 돌려보냄 
                out.println("</script>");
            } else { // 글쓰기가 이루어진 경우 
                out.println("<script>");
                out.println("alert('글쓰기 성공');");
                out.println("location.href = 'bbs.jsp';"); // 글쓰기 성공하면 게시판 페이지로 이동
                out.println("</script>");
            }
        }
    }
%>  
</body>
</html>