<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="">
<!--<![endif]-->
<head>
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
<%
// 세션 아이디가 null 이거나 "" 일 경우 "로그인이 필요한 페이지입니다." 출력 후 로그인 페이지로 이동
String sId = (String) session.getAttribute("sId");
// System.out.println(sId);
if (sId == null || sId.equals("")) {
%>
<script>
	alert("로그인이 필요한 페이지입니다.");
	location.href = "MemberLoginForm.me";
</script>
<%
}
%>
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>





<script type="text/javascript">


	$(function(cp_code) {

		let id = $("#id").text(); // 회원 아이디
		let email = $("#email").val(); // 이메일 인증 상태 확인용 (원래 이메일 주소)
		// 		alert(email);

		
	
		
		
		//파라미터 cp_code 추출
		const param = new URL(location).searchParams;
		param.get("cp_code")
		if(param.get("cp_code") != null){
			
			$("#CouponCount").trigger("click");
// 			alert("클릭됨 !");
		}

		
		$("#CouponCount").on("click", function(){
			
			const searchCoupon = $.ajax({//자동등록된 쿠폰(생일쿠폰,회원가입쿠폰) 있는지 확인
				type: "get",
				url: "SearchUsableCoupon.od",
				contentType: "application/x-www-form-urlencoded; charset=UTF-8",
				dataType: "HTML",
				data:{
					"isMypage":true
				}

			})
			.done(function(result){
	    		alert(result);
				$("#ajax_changeDiv").html(result);
				$("#ajax_changeDiv_wapper").append("<input type='button' value='마이페이지 메인' class='mb-5 mx-3 p-2 btn btn-sm  btn-secondary rounded '  style='float: right;' id='goMypagebtn'></button>");
				//현재 URL가져와서 파라미터(cp_code)존재하면 값주기
				const urlParams = new URL(location.href).searchParams;
				
				//파라미터가 깨지므로 decode
// 				alert(decodeURI(urlParams));
// 				alert("urlParams.has('cp_code') : "+ urlParams.has('cp_code'));
				if(urlParams.has('cp_code')){
					
				const cp_code = decodeURI(urlParams.get('cp_code'));
				result.find("#search_coupon_code").val() = cp_code;
				
				}else{
					
				}
			})
			.fail(function(data){
				alert("ajax요청 실패");
			});
				

				
				
			
		});//$("#CouponCount")
	});
	
	$(document).on("click", "#goMypagebtn", function(){
		//Mypage로 이동하는 버튼
		//동적할당된 버튼이므로 따로 정의
		location.reload(true);
	});
</script>

<!-- 카카오 주소 API -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function kakaoAddr() { // onclick 시 작동할 함수 선언
		new daum.Postcode({
			oncomplete : function(data) {
				var roadAddr = data.roadAddress;
				// 회원이 검색해서 찾은 주소 클릭 시 폼에 뿌리기
				document.getElementById("postcode").value = data.zonecode;
				document.getElementById("addr1").value = data.roadAddress;

			}
		}).open();
	}
</script>

</head>
<body>

	<!-- Header-->
	<!-- top.jsp -->
	<jsp:include page="../inc/top.jsp"></jsp:include>

	<!-- Animated -->
	<div class="animated fadeIn container">
		<!-- Widgets  -->
		<div class="row">
			<div class="col-lg-3 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="stat-widget-five">
							<div class="stat-icon dib flat-color-1">
								<i class="fa fa-shopping-cart"></i>
							</div>
							<div class="stat-content">
								<div class="text-left dib">
									<div class="stat-heading">주문</div>
									<div class="stat-text">
										<span>${order_count } 건</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="stat-widget-five">
							<div class="stat-icon dib flat-color-2">
								<i class="fa fa-tags"></i>
							</div>
							<div class="stat-content" id="CouponCount">
								<div class="text-left dib">
									<div class="stat-heading">쿠폰</div>
									<div class="stat-text">
										<span>${coupon_count } 개</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="stat-widget-five">
							<div class="stat-icon dib flat-color-3">
								<i class="fa fa-question"></i>
							</div>
							<div class="stat-content">
								<div class="text-left dib">
									<div class="stat-heading">리뷰</div>
									<div class="stat-text">
										<span>${review_count } 개</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-3 col-md-6">
				<div class="card">
					<div class="card-body">
						<div class="stat-widget-five">
							<div class="stat-icon dib flat-color-4">
								<i class="fa fa-list-ul"></i>
							</div>
							<div class="stat-content">
								<div class="text-left dib">
									<div class="stat-heading">Q&A</div>
									<div class="stat-text">
										<span>${qna_count } 건</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- /Widgets -->

	<div class="container" id="ajax_changeDiv_wapper">
	<div id="ajax_changeDiv">
		<div class="card" >
			<div class="card-header">
				<strong>회원 정보</strong>
			</div>
			<div class="card-body card-block" >
				<div class="row form-group">
					<div class="col col-md-3">
						<label class="form-control-label font-weight-bold">ID</label>
					</div>
					<div class="col-12 col-md-9">
						<span class="form-control-static bg-gradient-light" id="id">${member.member_id }</span>
					</div>
				</div>
				<div class="row form-group">
					<div class="col col-md-3">
						<label class="form-control-label font-weight-bold">이름</label>
					</div>
					<div class="col-12 col-md-9">
						<span class="form-control-static bg-gradient-light">${member.member_name }</span>
					</div>
				</div>
				<div class="row form-group">
					<div class="col col-md-3">
						<label for="text-input"
							class="form-control-label font-weight-bold">주소<font
							color="red">*</font></label>
					</div>
					<div class="col-12 col-md-4 d-flex">
						<span class="form-control-static bg-gradient-light" id="postcode">${member.member_postcode }</span>
					</div>
				</div>
				<div class="row form-group">
					<div class="col col-md-3"></div>
					<div class="col-12 col-md-8">
						<span class="form-control-static bg-gradient-light" id="addr1">${member.member_addr1 }</span>
						<small class="form-text text-muted">도로명주소</small>
					</div>
				</div>
				<div class="row form-group">
					<div class="col col-md-3">
						<label for="text-input" class=" form-control-label"></label>
					</div>
					<div class="col-12 col-md-8">
						<span class="form-control-static bg-gradient-light" id="addr2">${member.member_addr2 }</span>
						<small class="form-text text-muted">상세주소</small>
					</div>
				</div>
				<div class="row form-group">
					<div class="col col-md-3">
						<label for="text-input"
							class=" form-control-label font-weight-bold">휴대전화<font
							color="red">*</font></label>
					</div>
					<div class="col-12 col-md-6">
						<span class="form-control-static bg-gradient-light" id="mobile">${member.member_mobile }</span>
						<small class="form-text text-muted"></small>
					</div>
				</div>
				<div class="row form-group">
					<div class="col col-md-3">
						<label for="email-input"
							class="form-control-label font-weight-bold">이메일<font
							color="red">*</font></label>
					</div>
					<div class="col-12 col-md-6">
						<span class="form-control-static bg-gradient-light" id="email">${member.member_email }</span>
						<c:choose>
							<c:when test="${member.member_authStatus == 'Y' }">
								<small class="help-block form-text text-muted"
									id="email_auth_status">이메일 인증이 완료되었습니다.</small>
							</c:when>
							<c:otherwise>
								<small class="help-block form-text text-muted"
									id="email_auth_status">이메일 인증이 필요합니다.</small>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<div class="row form-group">
					<div class="col col-md-3">
						<label for="text-input"
							class=" form-control-label font-weight-bold">댕생일</label>
					</div>
					<div class="col-12 col-md-6">
						<c:choose>
							<c:when test="${empty member.member_birth }">
								<span class="form-control-static bg-gradient-light" id="birth">입력한 생일이 없습니다.</span>
							</c:when>
							<c:otherwise>
								<span class="form-control-static bg-gradient-light" id="birth">${member.member_birth }</span>
							</c:otherwise>
						</c:choose>
						<small class="form-text text-muted">변경 불가한 정보입니다.</small>
					</div>
				</div>
				<div class="row form-group">
					<div class="col col-md-3">
						<small class="form-text text-muted" style="text-align: right;"><font
							color="red">*</font>은(는) 필수 입력 정보입니다.</small>
					</div>
					<div class="col-12 col-md-8">
						<button onclick="location.href='CheckPassForm.me'"
							class="btn btn-secondary" value="회원 정보 페이지" style="float: right;">회원 정보 페이지</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer-->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy;
				DangDangEat 2023</p>
		</div>
	</footer>

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
</body>
</html>