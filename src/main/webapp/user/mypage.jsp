<%@page import="mpjt.dto.FavoriteDTO"%>
<%@page import="java.util.List"%>
<%@page import="mpjt.dao.FavoriteDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/menu.jsp"%>
<%
String userId = (String) request.getSession().getAttribute("user_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta  name="viewport" content="width=device-width, initial-scale=1" charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css?v=<%= System.currentTimeMillis() %>" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css?v=<%= System.currentTimeMillis() %>" />
<title>마이페이지 - 좋아요 누른 게시물</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.0/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.11.0/dist/sweetalert2.min.css" rel="stylesheet">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script>
    function viewLikedPosts() {
        var userId = $('#userIdView').val();

        $.ajax({
            url: '<%=request.getContextPath()%>/MyLikesServlet',
            type: 'GET',
            data: { 
                userId: userId
            },
            success: function(response) {
                var likedPostsDiv = $('#likedPosts');
                likedPostsDiv.empty();

                if (response.length > 0) {
                    $.each(response, function(index, post) {
                        likedPostsDiv.append(
                        		'<table>' +
                        		'<tr>' +
                        		'<td>작성자: ' + post.user_id + '</td>' +
                                '<td style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 200px;">' + post.fr_title + '</td>' +                             
                                '<td>' + post.fr_regd + '</td>' +
                                '<td> 좋아요: ' + post.fr_like + '</td>' +
                                '</tr>' +
                                '</table>'
                        );
                    });
                } else {
                    likedPostsDiv.append('<p>좋아요를 누른 게시글이 없습니다.</p>');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX 호출 중 오류 발생: " + textStatus, errorThrown);
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function () {
        viewLikedPosts(); 
        viewFriends();
    });
    
    function viewFriends() {
        var userId = "<%= user_id %>";

        $.ajax({
            url: '<%=request.getContextPath()%>/FriendServlet',
            type: 'GET',
            data: {
                action: 'viewFriends', 
                userId: userId
            },
            success: function(response) {
                var friendsList = $('#friendsList');
                friendsList.empty();
                $.each(response, function(index, friend) {
                    friendsList.append('<li>' + friend.friend_id + '</li>');
                });
            }
        });
    }

    function addFriend() {
        var userId = "<%= user_id %>";
        var friendId = $('#friendId').val();

        $.ajax({
            url: '<%=request.getContextPath()%>/FriendServlet',
            type: 'POST',
            data: {
                action: 'addFriend',
                userId: userId,
                friendId: friendId
            },
            success: function(response) {
                if (response.status === 'success') {
                    alert('친구가 추가되었습니다!');
                    viewFriends();
                } else if (response.status === 'alreadyFriend') {
                    alert('이미 추가된 친구입니다.');
                } else if (response.status === 'notExist') {
                    alert('존재하지 않는 아이디입니다.');
                } else {
                    alert('친구 추가에 실패했습니다.');
                }
            }
        });
    }
    
    function removeFavorite(rs_id) {
        var confirmation = confirm("정말로 삭제하시겠습니까?");

        if (confirmation) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "<%=request.getContextPath()%>/favorite", true);
            xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    if (xhr.responseText === "success") {
                        var row = document.getElementById("favorite_" + rs_id);
                        row.parentNode.removeChild(row);
                    } else {
                        alert("찜 삭제에 실패했습니다.");
                    }
                }
            };
            xhr.send("action=remove&user_id=<%= userId %>&rs_id=" + rs_id);
        }
    }
</script>
<script>
	$(function() {
		const tabList = document.querySelectorAll('.tab_menu ul li');
		  const contents = document.querySelectorAll('.side_menu')
		  let activeCont = ''; // 현재 활성화 된 컨텐츠 (기본:#tab1 활성화)
	
		  for(var i = 0; i < tabList.length; i++){
		    tabList[i].querySelector('.menu_btn').addEventListener('click', function(e){
		      e.preventDefault();
		      for(var j = 0; j < tabList.length; j++){
		        // 나머지 버튼 클래스 제거
		        tabList[j].classList.remove('on');
	
		        // 나머지 컨텐츠 display:none 처리
		        contents[j].classList.remove('on');
		      }
	
		      // 버튼 관련 이벤트
		      this.parentNode.classList.add('on');
	
		      // 버튼 클릭시 컨텐츠 전환
		      activeCont = this.getAttribute('href');
		      document.querySelector(activeCont).classList.add('on');
		    });
		  }
	});

</script>
</head>
<body>
<main id="container">
 <div class="inner mypage_area">
 	<div class="mypage_wrap">
	<aside class="side_area">
		<h2>마이페이지</h2>
		<div class="tab_menu">
			<ul>
				<li class="on"><a href="#menu1" class="menu_btn">찜한 맛집</a></li>
				<li><a href="#menu2" class="menu_btn">좋아요 한 게시물</a></li>
				<li><a href="#menu3" class="menu_btn">친구 목록</a></li>
				<li><a href="#menu4" class="menu_btn">개인정보 수정</a></li>
			</ul>
		</div>
	</aside>
	<section class="right">
		<div id="menu1" class="side_menu on">
	        <h3>찜한 맛집</h3>
	        <hr>
	        <div class="favorite_list_wrap">
	            <table class="table table-striped">
	                <thead>
	                    <tr>
	                        <th class="col1">번호</th>
	                        <th>가게명</th>
	                        <th>주소</th>
	                        <th>관리</th>
	                    </tr>
	                </thead>
	                <tbody>
	                    <%
	                    // 세션에서 사용자 ID를 가져옵니다.
	                    userId = (String) request.getSession().getAttribute("user_id");
	
	                    if (userId == null) {
	                        // 로그인하지 않은 경우
	                        out.println("<tr><td colspan='4'>로그인이 필요합니다.</td></tr>");
	                    } else {
	                        // 사용자 ID로 찜한 식당 목록을 가져옵니다.
	                        FavoriteDAO favoriteDAO = new FavoriteDAO();
	                        List<FavoriteDTO> favoriteList = favoriteDAO.getFavoritesByUser(userId);
	
	                        if (favoriteList.isEmpty()) {
	                            // 찜한 식당이 없는 경우
	                            out.println("<tr><td colspan='4'>찜한 식당이 없습니다.</td></tr>");
	                        } else {
	                            // 찜한 식당 목록을 출력합니다.
	                            int index = 1;
	                            for (FavoriteDTO favorite : favoriteList) {%>
	                                <tr>
	                                    <td><%= index++ %></td>
	                                    <td><%= favorite.getRs_name() %></td>
	                                    <td><%= favorite.getRs_addr() %></td>
	                                    <td>
	                                        <button class="btn btn-danger" onclick="removeFavorite('<%= favorite.getRs_idx() %>');">삭제</button>
	                                    </td>
	                                </tr>
	                                <%
	                            }
	                        }
	                    }
	                    %>
	                </tbody>
	            </table>
	        </div>
		</div>
		<div id="menu2" class="side_menu">
		    <h3>좋아요 한 게시물</h3>
			<hr>
		    <div id="likedPosts"></div>
		</div>
		<div id="menu3" class="side_menu">
		    <h3>친구 목록</h3>
			<hr>
		    <form onsubmit="addFriend(); return false;">
	        친구 ID: <input type="text" id="friendId"><input type="submit" value="Add Friend">
	   	 	</form>
		    <ul id="friendsList"></ul>
		 </div>
		<div id="menu4" class="side_menu">
			<div class="user_update">
			<h3>개인정보 수정</h3>
			<hr>
           <form action="updateProc.do" method="post">
               <div class="mb-3">
                   <label for="userID" class="form-label">ID:</label>
                   <input type="text" class="form-control" id="userID" value="<%=session.getAttribute("user_id") %>" disabled>
               </div>
               <% if ("관리자".equals(userRole)) { %>
               <div class="form-check">
                   <input class="form-check-input" type="radio" name="user_role" id="user" value="일반 사용자" required>
                   <label class="form-check-label" for="user">일반 사용자</label>
               </div>
               <div class="form-check">
                   <input class="form-check-input" type="radio" name="user_role" id="admin" value="관리자" required>
                   <label class="form-check-label" for="admin">관리자</label>
               </div>
               <% } %>
               <div class="mb-3">
                   <label for="currentPassword" class="form-label">현재 비밀번호</label>
                   <input type="password" class="form-control" id="currentPassword" name="current_password" required>
               </div>

               <div class="mb-3">
                   <label for="newPassword" class="form-label">새 비밀번호</label>
                   <input type="password" class="form-control" id="newPassword" name="new_password" required>
               </div>
               <div class="mb-3">
                   <label for="userName" class="form-label">새 이름</label>
                   <input type="text" class="form-control" id="userName" name="user_name" required>
               </div>
               <div class="mb-3">
                   <label for="userGender" class="form-label">성별</label>
                   <div class="form-check">
                       <input class="form-check-input" type="radio" name="user_gen" id="male" value="남자" required>
                       <label class="form-check-label" for="male">남자</label>
                   </div>
                   <div class="form-check">
                       <input class="form-check-input" type="radio" name="user_gen" id="female" value="여자" required>
                       <label class="form-check-label" for="female">여자</label>
                   </div>
               </div>
               <button type="submit" class="btn btn-primary">수정</button>
			</form>
			</div>
			<hr>
			<div class="user_delete">
				<a href="delete.do" class="btn btn-primary btn-block">회원 탈퇴 <i class="xi-angle-right-min"></i></a>
			</div>
	</div>
	
	</section>
 </div>
</div>
</main>
</body>
</html>
