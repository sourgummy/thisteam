<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>Shop Homepage - Start Bootstrap Template</title>

<link href="css/styles.css" rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="../js/jquery-3.6.3.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.slider_image').bxSlider({
			mode : "horizontal",
			auto : true,
			pager : true,
			//        slideWidth: 1300,  // 절대 수정 금지!!!건들지마세요!!!
			speed : 15, // 숫자 작을수록 빠르게 넘어감
			infinitelLoop : true

		});
	});
</script>
<style type="text/css">
@font-face {
	font-family: 'GmarketSansMedium';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}

body {
	font-family: "GmarketSansMedium";
}

#slider {
	margin: 0 auto;
	width: 1200px;
	padding: 0;
	position: relative;
}
</style>
</head>
<body>
	<!-- top.jsp -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!--         </nav> -->
	<!-- Header-->

	<section class="py-1"></section>
<body>
	<div id="slider">
		<ul class="slider_image">
			<li><img src="img/slider1.png" /></li>
			<li><img src="img/cheerup.jpg" /></li>
			<li><img src="img/cheerup.jpg" /></li>
		</ul>
	</div>

</body>

<!-- Footer-->
<footer class="py-5 bg-dark">
	<div class="container">
		<p class="m-0 text-center text-white">Copyright &copy; DANGDANGEAT
			2022</p>
	</div>
</footer>
<!-- Bootstrap core JS-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
</body>
</html>
