<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원삭제</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" />
</head>
<body>
<%@ include file="../common/menu.jsp" %>
<div class="container">
    <hr>
    <h1>회원 탈퇴</h1>
    <p>삭제할 아이디의 비밀번호를 입력하세요</p>
    <form action="deleteProc.jsp" method="post">
        <div class="mb-3">
            <label for="userPassword" class="form-label">비밀번호:</label>
            <input type="password" class="form-control" id="userPassword" name="user_password" required>
        </div>
        <button type="submit" class="btn btn-primary">확인</button>
    </form>
</div>
</body>
</html>