<%@page import="java.util.Map"%>
<%@page import="mpjt.dto.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="mpjt.dao.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%
BoardDAO boardDAO = new BoardDAO();
List<BoardDTO> recentPosts = boardDAO.getRecentPosts();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>뭐먹을끼니?</title>
<link rel="icon" href="../resources/images/favicon.png" type="image/x-icon">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/common.css?v=<?php echo time(); ?>" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/main.css?v=<?php echo time(); ?>" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="../resources/js/ui-common.js"></script>
<script>

//클릭한 tr의 ID를 가져와 view.jsp로 이동하는 함수
function redirectToView(id) {
 window.location.href = '../mbboard/view.bo?num=' + id;
}


</script>
</head>
<body>
   <%@ include file="../common/menu.jsp"%>
   <main id="container">
   <section class="main_banner">
      <!-- Slider main container -->
      <!-- Slider main container -->
      <div class="swiper">
         <div class="btn_wrap">
            <div class="swiper-pagination"></div>
            <button class="toggle_btn" type="button">
               <span class="blind">일시정지</span>
            </button>
         </div>
         <div class="swiper-wrapper">
            <div class="swiper-slide">
               <img src="../resources/images/banner1.png" alt="Slide 1">
            </div>
            <div class="swiper-slide">
               <img src="../resources/images/banner2.png" alt="Slide 2">
            </div>
            <div class="swiper-slide">
               <img src="../resources/images/banner3.png" alt="Slide 3">
            </div>
         </div>

         <!-- If we need navigation buttons -->
         <div class="swiper-button-prev arrowbtn"></div>
         <div class="swiper-button-next arrowbtn"></div>

         <!-- Pagination -->

      </div>
	  </section>
      <section class="main_service">
         <div class="inner">
			<h2>뭐먹고싶니?</h2>
         </div>
         <div class="main_service_list">
            <div class="main_service_group">
               <div class="service_row1">
                  <div class="marqueebox">
                     <div class="marquee_wrap">
                        <!-- <marquee에 li 8개 * 3개(marquee)> -->
                        <ul class="marquee">
                           <li class="marquee_con marquee1"><a href="#"> </a></li>
                           <li class="marquee_con marquee2"><a href="#"> </a></li>
                           <li class="marquee_con marquee3"><a href="#"> </a></li>
                           <li class="marquee_con marquee4"><a href="#"> </a></li>
                           <li class="marquee_con marquee5"><a href="#"> </a></li>
                           <li class="marquee_con marquee6"><a href="#"> </a></li>
                           <li class="marquee_con marquee7"><a href="#"> </a></li>
                           <li class="marquee_con marquee8"><a href="#"> </a></li>
                        </ul>
                        <ul class="marquee marquee_2">
                           <li class="marquee_con marquee1"><a href="#"> </a></li>
                           <li class="marquee_con marquee2"><a href="#"> </a></li>
                           <li class="marquee_con marquee3"><a href="#"> </a></li>
                           <li class="marquee_con marquee4"><a href="#"> </a></li>
                           <li class="marquee_con marquee5"><a href="#"> </a></li>
                           <li class="marquee_con marquee6"><a href="#"> </a></li>
                           <li class="marquee_con marquee7"><a href="#"> </a></li>
                           <li class="marquee_con marquee8"><a href="#"> </a></li>
                        </ul>
                        <ul class="marquee marquee_2">
                           <li class="marquee_con marquee1"><a href="#"> </a></li>
                           <li class="marquee_con marquee2"><a href="#"> </a></li>
                           <li class="marquee_con marquee3"><a href="#"> </a></li>
                           <li class="marquee_con marquee4"><a href="#"> </a></li>
                           <li class="marquee_con marquee5"><a href="#"> </a></li>
                           <li class="marquee_con marquee6"><a href="#"> </a></li>
                           <li class="marquee_con marquee7"><a href="#"> </a></li>
                           <li class="marquee_con marquee8"><a href="#"> </a></li>
                        </ul>
                        <ul class="marquee marquee_2">
                           <li class="marquee_con marquee1"><a href="#"> </a></li>
                           <li class="marquee_con marquee2"><a href="#"> </a></li>
                           <li class="marquee_con marquee3"><a href="#"> </a></li>
                           <li class="marquee_con marquee4"><a href="#"> </a></li>
                           <li class="marquee_con marquee5"><a href="#"> </a></li>
                           <li class="marquee_con marquee6"><a href="#"> </a></li>
                           <li class="marquee_con marquee7"><a href="#"> </a></li>
                           <li class="marquee_con marquee8"><a href="#"> </a></li>
                        </ul>
                        <ul class="marquee marquee_2">
                           <li class="marquee_con marquee1"><a href="#"> </a></li>
                           <li class="marquee_con marquee2"><a href="#"> </a></li>
                           <li class="marquee_con marquee3"><a href="#"> </a></li>
                           <li class="marquee_con marquee4"><a href="#"> </a></li>
                           <li class="marquee_con marquee5"><a href="#"> </a></li>
                           <li class="marquee_con marquee6"><a href="#"> </a></li>
                           <li class="marquee_con marquee7"><a href="#"> </a></li>
                           <li class="marquee_con marquee8"><a href="#"> </a></li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
      	 </div>
      </section>
 	<section class="recent_bbs">
 		<div class="inner">
 		<div class="recent_tit">
 		<h2>최근 게시물</h2>
 		<a href="../mbboard/bbs.bo">+ 더보기</a>
 		</div>
 		<div class="board_list_wrap">
            <table>
               <thead>
                  <tr>
                     <th class="col2">작성자</th>
                     <th class="col3">제목</th>
                     <th class="col4"><img class="views" src="../resources/images/eyes.png" alt="조회수"></th>
                     <th class="col5"><img class="likes" src="../resources/images/like.png" alt="좋아요"></th>
                     <th class="col6">작성일</th>
                  </tr>
               </thead>
               <tbody>
                <% 
                for (BoardDTO post : recentPosts) { %> 
                    <tr onClick="redirectToView('<%= post.getFr_idx() %>')" >
                        <td><%= post.getUser_id() %></td>
                        <td><%= post.getFr_title() %></a></td>
                        <td><%= post.getFr_visitnum() %></td>
                        <td><%= post.getFr_like() %></td>
                        <td><%= post.getFr_regd() %></td>
                    </tr>
                <% } %>
            </tbody>
               </table>
            </div>
 		 <ul>
        
    </ul>
    </div>
    </section>
    <section class="top_views">
    	<div class="inner">
 			<div class="views_tit">
 				<h2>조회수 높은 맛집 👀</h2>
 			</div>
 		</div>
    </section> 
      
      
   </main>
   <footer id="footer">
      <div class="inner">
        <div class="footer_left">
          <h2><img src="../resources/images/pjt_logo.png" alt="뭐먹을끼니로고"></h2>
          <ul>
            <li><a href="#">개인정보처리방침</a></li>
            <li><a href="#">법적고지</a></li>
          </ul>
          <div class="address_wrap">
            <p class="address">클라우드(AWS) 환경에서 개발하는 풀스택(프론트엔드&백엔드) 자바(JAVA)웹&앱</p>
            <p class="copyright">Ⓒ 2021 BANDO ENGINEERING · CONSTRUCTION CO., LTD. All rights reserved.</p>
          </div>
        </div>
        <div class="footer_right">
          <ul class="footer_menu">
            <li><a href="#">전자조달시스템</a></li>
            <li><a href="#">E-브로슈어</a></li>
            <li><a href="#">사이버신문고</a></li>
          </ul>
          <div class="tel_num">
            <p>평일 AM 09:00 ~ PM05:00</p>
            <p>1800-0015</p>
          </div>
        </div>
      </div>
    </footer>
</body>
</html>