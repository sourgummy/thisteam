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

.main_rec{
	/*main 네모*/
width: 200px;
height:  200px;
}
</style>
</head>
<body>
	<!-- top.jsp -->
	<jsp:include page="../inc/top.jsp"></jsp:include>
	<!--         </nav> -->
	<!-- Header-->

	<section class="py-1"></section>

	<div id="slider">
		<ul class="slider_image">
			<li><img src="img/slider1.png" /></li>
			<li><img src="img/cheerup.jpg" /></li>
			<li><img src="img/cheerup.jpg" /></li>
		</ul>
	</div>

<article>
	<%String uploadPath = "upload"; // 업로드 가상디렉토리(이클립스) 
	String realPath = request.getServletContext().getRealPath(uploadPath);
	request.getContextPath();
	//실제 업로드 경로(집) : C:\Users\eyeds\eclipse_jsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\DangDangEat\ upload
	//실제 업로드 경로(학원) : D:\workspace_jsp5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\DangDangEat\ upload
//	//String uploadPath = "ftp://db.itwillbs.dev:8030/upload"; // FTP 주소!!!체크필수!!!  12/30
	System.out.println("실제 업로드 경로 : " + realPath);
	System.out.println("request.getSession().getServletContext().getRealPath(/)"+  request.getSession().getServletContext().getRealPath(uploadPath));
	%>
	         <!-- 메인 네모 부분 // 관련 클래스: main_rec-->
        <div class="mt-5 d-flex flex-row justify-content-center">
         </div>
	        <div class=" mb-5 d-flex flex-row justify-content-center">
			       <img class=" bg-light main_rec m-3" src="img/saleban.png"></img>
	        </div>
	
         <!-- 메인 네모 부분 // 관련 클래스: main_rec-->
        <div class="mt-5 d-flex flex-row justify-content-center">
	         <div class = ""> NEW EAT </div>
         </div>
	        <div class=" mb-5 d-flex flex-row justify-content-center">
		         <c:forEach items="${productList}" var="product" >
		         ${product.pro_real_thumb }
			       <img class=" bg-light main_rec m-3" src="<%=request.getSession().getServletContext().getRealPath(uploadPath) %>/${product.pro_real_thumb }"></img>
		         </c:forEach>
	        </div>
	        
	        
	        
</article>
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
