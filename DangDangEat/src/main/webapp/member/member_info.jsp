<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang=""> <!--<![endif]-->
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DangDangShop - Member Info</title>
    <meta name="description" content="Ela Admin - HTML5 Admin Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="https://i.imgur.com/QRAUqs9.png">
    <link rel="shortcut icon" href="https://i.imgur.com/QRAUqs9.png">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/normalize.css@8.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome@4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/lykmapipo/themify-icons@0.1.2/css/themify-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pixeden-stroke-7-icon@1.2.3/pe-icon-7-stroke/dist/pe-icon-7-stroke.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.2.0/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>

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
String sId = (String)session.getAttribute("sId");
// System.out.println(sId);
if(sId == null || sId.equals("")) {
		%>
		<script>
		alert("로그인이 필요한 페이지입니다.");
		location.href="MemberLoginForm.me";
		</script>
		<%
}
%>
    <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<script type="text/javascript">

	function confirmPw(newPass2) {
		
		let newPass = document.querySelector("#newPass").value;
		let spanCpr = document.querySelector("#checkPasswdConfirmResult");
		
		if(newPass2 == newPass) {
			spanCpr.innerHTML = "비밀번호가 일치합니다";
			spanCpr.style.color = "GREEN";
		} else {
			spanCpr.innerHTML = "비밀번호가 불일치합니다";
			spanCpr.style.color = "RED";
		}
		
	}
	
	
	$(function() {
		
		let id = $("#id").text(); // 회원 아이디
		let email = $("#email").val(); // 이메일 인증 상태 확인용 (원래 이메일 주소)
// 		alert(email);
		
		$("#newPass").on("change", function() { // 신규 비밀번호 입력 시
// 			alert("신규 비밀번호 입력됨");
			if($("#newPass").val() != "") {
// 				alert('신규 비밀번호 입력');
				$("#confirmNewPass").prop("required", true); // 신규 비밀번호 확인
			} else {
				$("#confirmNewPass").prop("required", false); // 신규 비밀번호 확인
			}
		});
		
		// 이메일 인증 상태 변경 메서드 호출
		$("#email").on("change", function() {
			
// 			alert($("#email").val());
			
			if(email != $("#email").val()) {
				
// 				alert(id + ", " + $("#email").val());
				
				$.ajax({
					type: "POST",
					url: "MemberEmailUpdate.me",
					async : false,
					data: { 
						id: $("#id").text(),
						email: $("#email").val()
					},
					dataType: "text",
					success: function(result) {
						//작업이 성공적으로 발생했을 경우
						alert("이메일이 변경되었습니다.");
						location.reload();
					},
					error:function() {  
			            //에러가 났을 경우 실행시킬 코드
			            alert("이메일을 다시 입력해주세요.");
					}
						
				});
			}
				
		});
		
		// 이메일 인증하기
		$("#email_auth").on("click", function() {
			
// 			alert(id + ", " + $("#email").val());
			
			$.ajax({
				type: "POST",
				url: "MemberEmailAuth.me",
				async : false,
				data: { 
					id: $("#id").text(),
					email: $("#email").val()
				},
				dataType: "text",
				success: function(result) {
					//작업이 성공적으로 발생했을 경우
					alert("인증 메일이 발송되었습니다.");
					location.reload();
				},
				error:function() {  
		            //에러가 났을 경우 실행시킬 코드
		            alert("인증 메일 전송 실패");
				}
					
			});
			
		});
		
		
	});
	
	
</script>

<!-- 카카오 주소 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
   function kakaoAddr() { // onclick 시 작동할 함수 선언
      new daum.Postcode({
         oncomplete: function(data) {
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
	
	<div class="col-lg-12">
		<div class="card">
		    <div class="card-header">
		        <strong>회원 정보</strong>
		    </div>
		    <div class="card-body card-block">
		        <form action="MemberModifyPro.me" method="post" class="form-horizontal">
		            <div class="row form-group">
		                <div class="col col-md-3"><label class="form-control-label font-weight-bold">ID</label></div>
		                <div class="col-12 col-md-9">
		                    <span class="form-control-static bg-gradient-light" id="id">${member.member_id }</span>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3"><label class="form-control-label font-weight-bold">이름</label></div>
		                <div class="col-12 col-md-9">
		                    <span class="form-control-static bg-gradient-light">${member.member_name }</span>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="oldPass" class=" form-control-label font-weight-bold">기존 비밀번호<font color="red">*</font></label>
		                </div>
		                <div class="col-12 col-md-4">
		                	<input type="password" id="oldPass" name="oldPass" class="form-control" required="required">
		                	<span class="help-block form-text bg-gradient-light" id="checkPasswdResult"></span>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="newPass" class=" form-control-label font-weight-bold">신규 비밀번호</label>
		                </div>
		                <div class="col-12 col-md-4">
		                	<input type="password" id="newPass" name="newPass" class="form-control bg-gradient-light">
		                	<small class="help-block form-text text-muted">변경 시 입력 (영문 대소문자/숫자 4자~16자)</small>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="confirmNewPass" class="form-control-label font-weight-bold" >신규 비밀번호 확인</label>
		                </div>
		                <div class="col-12 col-md-4">
		                	<input type="password" id="confirmNewPass" name="confirmNewPass" class="form-control bg-gradient-light" onkeyup="confirmPw(this.value)">
		                	<span class="help-block form-text" id="checkPasswdConfirmResult"></span>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="text-input" class="form-control-label font-weight-bold">주소<font color="red">*</font></label>
		                </div>
		                <div class="col-12 col-md-4 d-flex">
		                	<input type="text" id="postcode" name="postcode" value="${member.member_postcode }" class="form-control bg-gradient-light" required="required">
		                	<input type="button" class=" mx-1 btn btn-outline-secondary" value="우편번호" onclick="kakaoAddr()">
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                </div>
		                <div class="col-12 col-md-8">
		                	<input type="text" id="addr1" name="addr1" value="${member.member_addr1 }" class="form-control bg-gradient-light" required="required">
		                	<small class="form-text text-muted">도로명주소</small>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="text-input" class=" form-control-label"></label>
		                </div>
		                <div class="col-12 col-md-8">
		                	<input type="text" id="addr2" name="addr2" value="${member.member_addr2 }" class="form-control bg-gradient-light">
		                	<small class="form-text text-muted">상세주소</small>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="text-input" class=" form-control-label font-weight-bold">휴대전화<font color="red">*</font></label>
		                </div>
		                <div class="col-12 col-md-6">
		                	<input type="text" id="mobile" name="mobile" value="${member.member_mobile }" class="form-control bg-gradient-light" required="required">
		                	<small class="form-text text-muted"></small>
		                </div>
		            </div>
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="email-input" class="form-control-label font-weight-bold">이메일<font color="red">*</font></label>
		               	</div>
		                <div class="col-12 col-md-6 d-flex">
		                	<input type="email" id="email" name="email" value="${member.member_email }" class="form-control bg-gradient-light" required="required">
		                	<input type="button" id="email_auth" class="mx-1 btn btn-outline-secondary" value="인증번호 받기">
		                </div>
		                <div class="col col-md-3">
		               	</div>
		                <div class="col col-md-3">
		               	</div>
		                <div class="col-12 col-md-6">
		                	<c:choose>
		                		<c:when test="${member.member_authStatus == 'Y' }">
				                	<small class="help-block form-text text-muted" id="email_auth_status">이메일 인증이 완료되었습니다.</small>
		                		</c:when>
		                		<c:otherwise>
				                	<small class="help-block form-text text-muted" id="email_auth_status">이메일 인증이 필요합니다.</small>
		                		</c:otherwise>
		                	</c:choose>
		                </div>
		            </div>
		            <div class="row form-group">
		            </div>
		            
		            <div class="row form-group">
		                <div class="col col-md-3">
		                	<label for="text-input" class=" form-control-label font-weight-bold">댕생일</label>
		                </div>
		                <div class="col-12 col-md-6">
		                	<input type="text" id="birth" name="birth" value="${member.member_birth }" class="form-control bg-gradient-light" readonly="readonly">
		                	<small class="form-text text-muted">변경 불가한 정보입니다.</small>
		                </div>
		            </div>
		            <div class="row form-group">
		            	<div class="col col-md-3">
				            <small class="form-text text-muted" style="text-align: right;"><font color="red">*</font>은(는) 필수 입력 정보입니다.</small>
		            	</div>
	            		<div class="col-12 col-md-8">
	                  		<input type="submit" class="btn btn-secondary" value="회원 정보 수정" style="float: right;">
	                  	</div>
                    </div>
				</form>
			</div>
		</div>
		<div>
        	<a href="MemberWithdrawForm.me">
            	<small  class="form-text text-muted" style="text-align: right;">회원 탈퇴</small>
            </a>
        </div>
	</div>
	<!-- Scripts -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@2.2.4/dist/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.4/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/jquery-match-height@0.7.2/dist/jquery.matchHeight.min.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>