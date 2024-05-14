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
</body>
</html>