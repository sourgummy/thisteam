<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>

<html class="no-js" lang="">

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>DangDangShop - My Page</title>
<meta name="description" content="Ela Admin - HTML5 Admin Template">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="apple-touch-icon" href="https://i.imgur.com/QRAUqs9.png">
<link rel="shortcut icon" href="https://i.imgur.com/QRAUqs9.png">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
<link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
<link rel="stylesheet" href="assets/css/style.css">

<link
	href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800'
	rel='stylesheet' type='text/css'>

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
</style>

<script src="https://code.jquery.com/jquery-3.6.3.js"></script>

	<div class="container" id="mypage_couponAjax">
		<div class="card" id="titleDiv">
			<div class="card-header">
				<strong>내가 가진 쿠폰</strong>
			</div>
			
			<div class="card-body card-block" id="couponDiv">
			
		       <%if (request.getParameter("cp_code") != null){%>
				   
				       <div class='m-3 d-flex justify-content-end'>
				       <input type='text'  class='col-sm-4 bg-light border border-secondary rounded' id='search_coupon_code' name='search_coupon_code' value='${param.cp_code}' placeholder=' 쿠폰코드를 입력하세요.'>
				       <input type='button' value='쿠폰 등록' class='mx-2 btn btn-sm btn-light rounded' id='c-search-btn'></div>
				   	<%}else{ %>
				   	
		    	 	
						<div class='m-3 d-flex justify-content-end'>"
							<input type='text'  class='col-sm-4 bg-light border border-secondary rounded' id='search_coupon_code' name='search_coupon_code' placeholder=' 쿠폰코드를 입력하세요.'> 
							<input type='button' value='쿠폰 등록' class='mx-2 btn btn-sm btn-light rounded' id='c-search-btn'>"
						</div>
				
				<% } %>
				
				
					<div class='card-body card-block' id='coupinDiv'>
				<% if (request.getAttribute("couponlistArr") == null){%>
					
							<div class='d-flex py-2 border border-dark rounded-2'>
								<div class='align-self-center p-2'><img src='img/no_coupon.png' width='100px'></div>
								<div class='align-self-center p-2'>사용가능한 쿠폰이 없습니다.</div>
							</div>
					
					<% }else{ 
						List couponlist = (ArrayList)request.getAttribute("couponlistArr");
						System.out.println("couponlist  :" + couponlist);
					%>
				
					<div  class='border rounded-2 d-flex'>
									<div class='p-3'>
<!-- 									   <h4>coupon.cp_name</h4> -->
<!-- 									  <b>coupon.cp_discount_value+% 할인 (<small>최대coupon.cp_max_discount  원</small></b>)<br> -->
<!-- 									   <small> coupon.cp_min_price 원 이상 구매 시</small><br> -->
<!-- 									  <small>coupon.target_sd  - coupon.target_ed (coupon.cp_period 일)</small> -->
<!-- 									</div> -->
								</div><br>
					
				 <% } %>
				
	</div>
	</div>
</div>
	
	<!-- Scripts -->
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>
<!-- </body> -->
<!-- </html> -->