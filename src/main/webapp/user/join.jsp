<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/main.css" /><title>JSP 게시판 웹 사이트 </title>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
   <div id="container">
      <div class="col-lg-4"></div>
      <div class="col-lg-4">
         <div class="jumbotron" style="padding-top: 20px;">
            <form method="post" action="joinProc.jsp">
            <h3 style="text-align: center; margin-bottom: 10px;">회원가입 화면  </h3>
            <div class="form-group">
               <input type="text" class="form-control" placeholder="아이디"name="user_id" maxlength="20">
            </div>
            <div class="form-group">
               <input type="password" class="form-control" placeholder="비밀번호"name="user_password" maxlength="20">
            </div>
            <div class="form-group">
               <input type="text" class="form-control" placeholder="이름"name="user_name" maxlength="20">
            </div>
            <div class="form-group" style="text-align: center;">
               <label class="btn btn-primary active">
                  <input type="radio" name="user_gen" autocomplete="off" value="남자 " checked>남자 
               </label>
               <label class="btn btn-primary active">
                  <input type="radio" name="user_gen" autocomplete="off" value="여자 ">여자  
               </label>
            </div>
            <input type="submit" class="btn btn-primary form-control" value="회원가입  ">
            </form>
      </div>
      <div class="col-lg-4"></div>
   </div>
      <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"></script>
</body>
</html>