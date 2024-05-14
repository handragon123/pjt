<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>뭐먹을끼니?</title>
<link rel="icon" href="../resources/images/favicon.png"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/common.css?v=<?php echo time(); ?>" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/main.css?v=<?php echo time(); ?>" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
  // Document가 준비되면 실행
  document.addEventListener('DOMContentLoaded', function () {
    // 스와이퍼 객체 생성 및 초기화
    var swiper = new Swiper('.swiper', {
      // 슬라이드 형태 지정
      slidesPerView: 1,
      // 페이징 여부
      pagination: {
        el: '.swiper-pagination',
        clickable: true,
      },
      // 네비게이션 버튼 여부
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      // 스크롤바 여부
      scrollbar: {
        el: '.swiper-scrollbar',
      },
      // loop 옵션 활성화
      loop: true,
    });
  });
</script>

<style>
.swiper-slide {
	width: 100%;
}

.swiper-button-prev, .swiper-button-next {
	color: #fff;
}

.swiper-scrollbar-horizontal {
	display: none;
}
</style>
</head>
<body>
	<%@ include file="../common/menu.jsp"%>
	<main id="container">
		<!-- Slider main container -->
		<section>
		<div class="swiper">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<img src="../resources/images/banner2_2.png" alt="Slide 1">
				</div>
				<div class="swiper-slide">
					<img src="../resources/images/banner1_1.png" alt="Slide 2">
				</div>
				<div class="swiper-slide">
					<img src="../resources/images/banner3_3.png" alt="Slide 3">
				</div>
			</div>


			<!-- If we need navigation buttons -->
			<div class="swiper-button-prev"></div>
			<div class="swiper-button-next"></div>


		</div>
		<a href="../user/userListPage.do">User List(Paging)</a>
		</section>
		<section class="main_service">
			<div class="inner">
				<div class="service_wrap">
					<div class="main_service">
						<h2>뭐먹고싶니?</h2>
					</div>
				</div>
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
	</main>
	<%
		String user_id = null;
		if(session.getAttribute("user_id") != null) {
			user_id = (String)session.getAttribute("user_id");
		}
	%>
	<nav class="navbar navbar-default">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
		data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
		aria-expanded="false">
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="main.jsp">JSP게시판 웹 사이트 </a>
	</div>
	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li class="active"><a href="main.jsp">메인 </a></li>
			<li><a href="../mbboard/bbs.jsp">게시판 </a></li>
			<li><a href="../Rest/restmain.jsp">음식 게시판 </a></li>
		</ul>
		
		
		<%
			if(user_id == null ){
		%>		
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기 <span class="caret">로그인 </span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp">로그인 </a></li>
					<li><a href="join.jsp">회원가입 </a></li>
				</ul>	
			</li>
		</ul>
		<% 		
			} else {
		%>		
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="list.jsp" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리 <span class="caret">로그인 </span></a>
				<ul class="dropdown-menu">
					<li><a href="logout.jsp">로그아웃 </a></li>

					<li><a href="delete.jsp">회원탈퇴 </a></li>

					<li><a href="update.jsp">회원수정 </a></li>
				</ul>	
			</li>
		</ul>
		<%		
			}
		%>
	    </div>
	</nav>
		
</body>
</html>