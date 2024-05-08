<%@page import="mpjt.dao.BoardDAO"%>
<%@page import="mpjt.dto.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% // param
request.setCharacterEncoding("utf-8");
String sNum = request.getParameter("num"); 
int num = Integer.parseInt(sNum);
BoardDTO dto = new BoardDTO();

dto.setFr_idx(num);
%>    
<% // db - select
BoardDAO dao = new BoardDAO();

//1. visitcount update
dao.updateVisitcount(dto); // 5초

//2. view content
dto = dao.selectView(dto);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/view.jsp</title>
<script>
	function del(num){
		const input = confirm("정말 삭제 할까요?");
		if(input){
			location.href = "<%=request.getContextPath()%>/board/DeleteProc?num="+num;
		}else{
			alert('삭제를 취소 했습니다.');
			return;
		}
		
	}
</script>
</head>
<body>

<%-- <%@ include file="../user/main.jsp" %> --%>
<li><a href="bbs.jsp">게시판으로</a></li>
<h2>글 상세보기 </h2>
<table border="1" width="90%">
	<tr>
	<td>글 번호</td><td><%=dto.getFr_idx() %></td>
	<td>작성자</td><td><%=dto.getUser_id() %></td>	
	</tr>
	<tr>
	<td>작성일자</td><td><%=dto.getFr_regd() %></td>
	<td>조회수</td><td><%=dto.getFr_visitnum() %></td>	
	</tr>
	<tr><td>제목</td><td colspan="3"><%=dto.getFr_title() %></td></tr>
	<tr><td>내용</td><td colspan="3"><%=dto.getFr_cont() %></td></tr>
	<tr><td colspan="4">
	<a href="bbs.jsp">[List]</a> |  
<%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(dto.getUser_id())) {%>

	<a href="update.jsp?num=<%=num%>">[Update]</a> | 
	<a href="javascript:del('<%=num%>');">[Delete]</a>
<%} %>
	</td></tr>
	
</table>


</body>
</html>