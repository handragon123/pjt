<%@page import="mpjt.dao.BoardDAO"%>
<%@page import="mpjt.dto.BoardDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/sessionCheck.jsp"%>      
<% // param
request.setCharacterEncoding("utf-8");
String sNum = request.getParameter("num"); 
int num = Integer.parseInt(sNum);
BoardDTO dto = new BoardDTO();

dto.setFr_idx(num);

%>    
<% // db - select
BoardDAO dao = new BoardDAO();

// view content
dto = dao.selectView(dto);

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board/update.jsp</title>
<script type="text/javascript">
function validateForm() {
	const form = document.writeForm;
	console.dir(form); // input
	if(form.title.value === ""){
		alert('title 필수값 입니다.');
		form.title.focus();
		return;
	}
	if(form.content.value === ""){
		alert('content 필수값 입니다.');
		form.content.focus();
		return;
	}
	
	form.submit();
}
</script>
</head>
<body>
<h2>글 수정하기 </h2>
<form name="writeForm" 
	action="<%=request.getContextPath() %>/board/UpdateProc" 
	method="post">
	<input type="hidden" name="num" value="<%=num%>">
	<table border="1" width="90%">
		<tr>

		<td>Num</td><td><%=dto.getFr_idx() %></td>
		<td></td><td><%=dto.getUser_id() %></td>	
		</tr>
		<tr>
		<td>PostDate</td><td><%=dto.getFr_regd() %></td>
		<td>Visitcount</td><td><%=dto.getFr_visitnum() %></td>	
		</tr>
		<tr><td>Title</td><td colspan="3">
		<input type="text" name="title" value="<%=dto.getFr_title() %>" style="width:90%">
		</td></tr>
		<tr><td>Content</td><td colspan="3">
		<textarea name="content" style="width:90%; height:100px"><%=dto.getFr_cont() %></textarea>
		</td></tr>
		<tr><td colspan="4">
		<a href="bbs.jsp">[List]</a> |  
		<a href="view.jsp?num=<%=num%>">[View]</a> |		
	<%if(session.getAttribute("user_id") != null && session.getAttribute("user_id").equals(dto.getUser_id())) {%>
		<a href="javascript:validateForm();">[Update]</a> 
	<%} %>
		</td></tr>		
	</table>
</form>

</body>
</html>