<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="mpjt.dao.UserDAO"%>
<%@page import="java.util.List"%>
<%@page import="mpjt.dao.RsDAO"%>
<%@page import="mpjt.dto.RsDTO"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8"); 
	RsDAO dao = new RsDAO();
	List<RsDTO> rsList =  dao.rsList();
	
	int index = 1;
%>  
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>뭐먹을끼니? 맛집찾기</title>
<link rel="icon" href="../resources/images/favicon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/ui-common.js?v=<?php echo time(); ?>"></script>
<script>
	// 클릭한 tr의 ID를 가져와 view.jsp로 이동하는 함수
	/* function redirectToView(id) {
	    window.location.href = 'rsView.jsp?num=' + id;
	} */
	
</script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var stars = document.querySelectorAll(".star");
        
        stars.forEach(function(star) {
            star.addEventListener("click", function() {
                var value = this.getAttribute("data-value");
                var parent = this.parentNode;

                // 모든 별을 ☆로 초기화
                var starChildren = parent.querySelectorAll(".star");
                starChildren.forEach(function(s) {
                    s.innerHTML = '<i class="xi-star-o"></i>';
                });
                
                // 클릭된 별까지 ★로 변경
                for (var i = 0; i < value; i++) {
                    starChildren[i].innerHTML = '<i class="xi-star"></i>';
                }

                // 별점 값을 부모 요소에 저장
                parent.setAttribute("data-rating", value);
            });
        });

        // 초기 별점 설정
        var ratings = document.querySelectorAll(".rating");
        ratings.forEach(function(rating) {
            var value = rating.getAttribute("data-rating");
            var starChildren = rating.querySelectorAll(".star");
            for (var i = 0; i < value; i++) {
                starChildren[i].innerHTML = '<i class="xi-star"></i>';
            }
        });
    });

    function saveRating(rs_idx) {
        var ratingDiv = document.querySelector("#rating-" + rs_idx);
        if (ratingDiv) {
            var rating = ratingDiv.getAttribute("data-rating");

            // Ajax 요청 보내기
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "RsController", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onload = function () {
                if (xhr.status === 200) {
                    alert("별점이 저장되었습니다.");
                } else {
                    alert("별점 저장에 실패하였습니다.");
                }
            };
            xhr.onerror = function () {
                alert("요청 중 오류가 발생했습니다.");
            };
            xhr.send("action=saveRating&rs_idx=" + rs_idx + "&rating=" + rating);
        } else {
            alert("별점 요소를 찾을 수 없습니다.");
        }
    }

    function deleteRestaurant(rs_idx) {
        if (confirm('정말로 삭제하시겠습니까?')) {
            window.location.href = 'RsController?action=delete&idx=' + rs_idx;
        }
    }
</script>
</head>
<body>
<%@ include file="../common/menu.jsp"%>
<main id="container">
<div class="inner rs_inner">
	<div class="rs_tit">
	<h2>맛집찾기</h2>
	<% 
      // UserDAO 클래스의 getUserRole 메서드를 호출하여 사용자의 역할을 확인
//       String userRole = new UserDAO().getUserRole((String)session.getAttribute("user_id"));
//       if ("관리자".equals(userRole)) { // 사용자 역할이 관리자인 경우에만 회원 리스트 버튼 표시
    %>
	<a href="addRs.jsp">+ 맛집추가</a>
	</div>
	<hr>
	<div class="category_wrap">
		<div class="rs_category">
			<a href="rsList.jsp" class="btn btn-primary active">지도/목록으로 보기</a>
			<a href="rsList_pic.jsp" class="btn btn-primary">사진으로 보기</a>
		</div>
		<div class="rs_filter">
	        <form class="search_food" action="rsList_pic.jsp" method="get">
	            <select name="category" class="select" onchange="this.form.submit()">
	            	<option value="select">음식종류 선택 &nbsp;🍚</option>
	                <option value="한식">한식</option>
	                <option value="일식">일식</option>
	                <option value="중식">중식</option>
	                <option value="아시아">아시아</option>
	            </select>
	        </form>
	    </div>
    </div>
	<div class="map_wrap">
		<div id="map" style="width:100%;height:400px;"></div>
	</div>
	  <div class="board_list_wrap rs_list">
	  <table>
	  	<thead>
		    <tr>
			  <th class="col1">번호</th>
			  <th class="col2">가게명</th>
			  <th class="col3">종류</th>
			  <th>주소</th>
			  <th>전화번호</th>
			  <th>별점</th>
			  <th>관리</th>
			</tr>
		</thead>
		<% for(RsDTO dto : rsList) { %>
	      <tr> 
	      	<td><%=index %></td>
	      	<td><%=dto.getRs_name() %></td>
	      	<td><%=dto.getRs_type() %></td>
	      	<td><%=dto.getRs_addr() %></td>
	      	<td><%=dto.getRs_num() %></td>
	      	<td>
				<!-- 별점 표시 부분 -->
				<div class="rating" id="rating-<%=dto.getRs_idx()%>" data-rating="<%=dto.getRs_rating()%>">
                    <span class="star" data-value="1"><i class="xi-star-o"></i></span>
                    <span class="star" data-value="2"><i class="xi-star-o"></i></span>
                    <span class="star" data-value="3"><i class="xi-star-o"></i></span>
                    <span class="star" data-value="4"><i class="xi-star-o"></i></span>
                    <span class="star" data-value="5"><i class="xi-star-o"></i></span>
                	<button class="btn" onclick="saveRating('<%=dto.getRs_idx()%>');">저장</button>
                </div>
			</td>
			<td class="btn_wrap"> 
				<button class="btn btn-primary" onclick="addFavorite('<%=dto.getRs_idx()%>');">찜하기</button>
				<button class="btn btn-danger" onclick="deleteRestaurant('<%=dto.getRs_idx()%>');">삭제</button>
			</td>
	      </tr>
	    <% index++; 
	    } %>
	</table>
	</div>
	</div>
</main>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9c81bee860ad23a53ad9cd495fc9a65a&libraries=services"></script>
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.5697289, 126.984164), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	var positions = [
		<%for(RsDTO dto : rsList) {%>
			{
				address: '<%=dto.getRs_addr()%>',
		        text: '<%=dto.getRs_name()%>'
		    },
		<%}%>

	];
	
	for (let i = 0; i < positions.length; i++) {
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(positions[i].address, function(result, status) {
		
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div class="info" style="width:150px;text-align:center;padding:6px 0;">'+positions[i].text+'</div>'
		        });
		        //infowindow.open(map, marker);
		        
		    	// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
		        // 이벤트 리스너로는 클로저를 만들어 등록합니다 
		        // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
		        kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		        kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		        
		    } 
		}); 
		
	}
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
</script>
<script>

  function deleteRestaurant(rs_idx) {
      if (confirm('정말 삭제하시겠습니까?')) {
          // AJAX를 사용하여 서버로 DELETE 요청을 보냅니다.
          const xhr = new XMLHttpRequest();
          xhr.open("GET", "../map/deleteRestaurant?idx=" + rs_idx, true);
          xhr.onload = function () {
              if (xhr.status === 200) {
                  alert("삭제되었습니다.");
                  // 필요한 경우 페이지를 새로 고침하거나 삭제된 항목을 제거합니다.
                  location.reload(); // 페이지를 새로 고침합니다.
              } else {
                  alert("삭제에 실패하였습니다.");
              }
          };
          xhr.onerror = function () {
              alert("요청 중 오류가 발생했습니다.");
          };
          xhr.send();
      }
  }
  
  function addFavorite(rs_id) {
      event.stopPropagation();
      const user_id = '<%=request.getSession().getAttribute("user_id")%>'; // 세션에서 사용자 ID를 가져옵니다.
      const xhr = new XMLHttpRequest();
      xhr.open("POST", "<%=request.getContextPath()%>/favorite", true);
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xhr.onload = function() {
          if (xhr.status === 200) {
              if (xhr.responseText === "success") {
                  alert("찜하기 완료!");
              } else {
                  alert("찜하기 실패!");
              }
          } else {
              alert("요청 중 오류가 발생했습니다.");
          }
      };
      xhr.onerror = function() {
          alert("요청 중 오류가 발생했습니다.");
      };
      xhr.send("action=add&user_id=" + encodeURIComponent(user_id) + "&rs_id=" + rs_id);
  }
</script>

</body>
</html>