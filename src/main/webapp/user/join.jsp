<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ include file="../common/menu.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원가입</title>
<link rel="icon" href="../resources/images/favicon.png"
   type="image/x-icon">
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
   crossorigin="anonymous">
<link rel="stylesheet"
   href="<%=request.getContextPath()%>/resources/css/common.css?v=<%=System.currentTimeMillis()%>" />
<link rel="stylesheet"
   href="<%=request.getContextPath()%>/resources/css/main.css?v=<%=System.currentTimeMillis()%>" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
   
<script>
function idCheck(){
    const id = document.querySelector('#userIdInput').value.trim(); // trim()을 사용하여 공백을 제거
    if (id === '') {
        // 공백일 때 메시지를 추가
        alert('아이디를 입력해주세요.');
        return;
    }
    
    const param = {user_id: id}; 
    
    $.ajax({
        contentType: "application/json",
        type:'GET',
        url:'<%=request.getContextPath()%>/user/idCheck.jsp',
        dataType:'json',
        data:param,
        success: function (data) {
            console.log(data);
            if(data['rs'] === '0'){
                $('#isIdFalse').show();
                $('#isIdTure').hide();
            }else{
                $('#isIdTure').show();
                $('#isIdFalse').hide();
            };
        },
        error: function (request, status, error) {
            console.log(request, status, error);
        }
    });
}

// 최초에 hide 실행
$(function(){
    $('#isIdTure').hide();
    $('#isIdFalse').hide();
});

    </script>
</head>
<body>
   
   <main id="container">
      <div class="col-lg-4">
         <div class="jumbotron" style="padding-top: 20px;">
            <%-- 메시지 출력 부분 추가 --%>
            <%
                String message = (String) request.getAttribute("message");
                if (message != null && !message.isEmpty()) {
            %>
            <div class="alert alert-warning" role="alert">
               <%= message %>
            </div>
            <% } %>
            <form method="post" action="joinProc.do">
               <h2>회원가입</h2>
               <hr>
               <div class="form-group blind" >
                  <label class="btn btn-primary active"> 
                  <input type="radio" name="user_role" autocomplete="off" value="일반 사용자" checked>
               </div>
               <div class="form-group_id">
                  <input type="text" class="form-control1" placeholder="아이디"
                     name="user_id" maxlength="20" id="userIdInput"> <input
                     type="button" class="duplication" value="중복확인" onclick="idCheck()"><br>
               </div>
                  <span id="isIdTure" style="color:red">ID가 존재 합니다.</span>
                  <span id="isIdFalse" style="color:blue">사용 가능한 ID 입니다.</span><br>   
               <div class="form-group_pass">
                  <input type="password" class="form-control" placeholder="비밀번호"
                     name="user_password" maxlength="20">
               </div>
               <div class="form-group_name">
                  <input type="text" class="form-control" placeholder="이름"
                     name="user_name" maxlength="20">
               </div>
               <div class="form-group" style="text-align: center;">
                  <label class="btn btn-primary active"> <input type="radio"
                     name="user_gen" autocomplete="off" value="남자" checked>남자
                  </label> <label class="btn btn-primary active"> <input
                     type="radio" name="user_gen" autocomplete="off" value="여자">여자
                  </label>
               </div>
               <input type="submit" class="btn btn-primary form-control"
                  value="회원가입">
            </form>
         </div>
      </div>
      <div class="col-lg-4"></div>
   </main>

   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"></script>

   <%-- 회원가입 완료 후 로그인 페이지로 이동하는 스크립트 --%>
   <%
    String successRedirect = (String) request.getAttribute("successRedirect");
    if (successRedirect != null && !successRedirect.isEmpty()) {
%>
   <script>
        alert('회원가입이 완료되었습니다.');
        window.location.href = '<%= successRedirect %>';
    </script>
   <% } %>
</body>
</html>