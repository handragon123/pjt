<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
<title>JSP 게시판 웹 사이트 </title>
</head>
<body>
	<div class="container">
	<div class="row">
<h2>글쓰기</h2>
<form name="writeForm" method="post" action="<%=request.getContextPath()%>/WriteProc">
	<table border="1" width="90%">
		<tr><td>Title</td><td><input type="text" name="title" style="width:90%"></td></tr>
		<tr><td>Content</td>
		<td><textarea name="content" style="width:90%; height:100px"></textarea></td></tr>
	</table>
	<input type="button" value="Submit" onclick="validateForm();">
</form>

		</div>
	</div>
	
	
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>