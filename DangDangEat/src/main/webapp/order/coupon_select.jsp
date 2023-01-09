<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 적용</title>
  	 <link href="css/styles.css" rel="stylesheet" />
   	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
  	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 	 <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
   @font-face { /*지마켓 산스*/
    font-family: 'GmarketSansMedium';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}    

body {
    font-family: 'GmarketSansMedium';
    vertical-align: middle;
}
</style>
</head>

<script type="text/javascript">
function setOrderCouponValue() {
    opener.document.getElementById("promo-code").value = document.getElementById("selectedCoupon").value;
    window.close();
   }
   
   
$(function(){

	
		$.ajax({//자동등록된 쿠폰(생일쿠폰,회원가입쿠폰) 있는지 확인
			type: "get",
			url: "SearchUsableCoupon.od",
			dataType: "json",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",

		})
		.done(function(result){

// 			alert("result:"+ JSON.stringify(result));

			
			if(JSON.stringify(result) == "[]"){//쿠폰 검색 결과가 없을 경우
				
				$("#coupon_list").html(
						"<div class='d-flex py-2 border border-dark rounded-2'>"+
							"<div class='align-self-center p-2'><img src='img/no_coupon.png' width='100px'></div>"+
							"<div class='align-self-center p-2'>사용가능한 쿠폰이 없습니다.</div>"+
						"</div>");
			}else{
		

				
				for(let coupon of result) {
					
// 					alert("total: " + parseInt($("#total").text()));
// 					alert("cp_min_price: " +parseInt(coupon.cp_min_price));
// 					alert(parseInt($("#total").text()) > parseInt(coupon.cp_min_price));
					
					if( parseInt($("#total").text()) < parseInt(coupon.cp_min_price)){
// 						alert(parseInt($("#total").text()) > parseInt(coupon.cp_min_price))
							$("#coupon_list").append(
									"<div  class='border rounded-2 d-flex bg-secondary bg-gradient' style='--bs-bg-opacity: .1' >"
										+"<div class='p-3'>"
											+"<input type='radio' id='selectedCoupon' disabled='disabled' name='cp_code' value="+coupon.cp_code+">" 
											+"<input type='hidden' id='cp_min_price' value="+coupon.cp_min_price+">" 
									 		+"<label for='selectedCoupon'></label>"
								  		 +"</div>"
										+"<div class='p-3'>"
										   +  "<h4>"+coupon.cp_name+"</h4>"
										   +  "<b>"+coupon.cp_discount_value+"% 할인 (<small>최대 "+ coupon.cp_max_discount +" 원</small></b>)<br>"
										   +  "<small>" + coupon.cp_min_price +  "원 이상 구매 시</small>"+"<br>"
										   + "<small>"+ coupon.target_sd + " - " +coupon.target_ed +" ("+coupon.cp_period +"일)</small>"
										+"</div>"
									+"</div><br>"
									
							);
					}else{
					
					
						$("#coupon_list").append(
								"<div  class='border rounded-2 d-flex ' >"
									+"<div class='p-3'>"
										+"<input type='radio' id='selectedCoupon' name='cp_code' value="+coupon.cp_code+">" 
										+"<input type='hidden' id='cp_min_price' value="+coupon.cp_min_price+">" 
								 		+"<label for='selectedCoupon'></label>"
							  		 +"</div>"
									+"<div class='p-3'>"
									   +  "<h4>"+coupon.cp_name+"</h4>"
									   +  "<b>"+coupon.cp_discount_value+"% 할인 (<small>최대 "+ coupon.cp_max_discount +" 원</small></b>)<br>"
									   +  "<small>" + coupon.cp_min_price +  "원 이상 구매 시</small>"+"<br>"
									   + "<small>"+ coupon.target_sd + " - " +coupon.target_ed +" ("+coupon.cp_period +"일)</small>"
									+"</div>"
								+"</div><br>"
								
						);
					
					}
				
				}//for
					
			}//else
		})
		.fail(function(data){
			alert("ajax 요청실패");
		});
		


	
	//쿠폰검색 버튼 클릭 시 ajax로 쿠폰 검색 
	$("#c-search-btn").on("click",function(){
		
			if($("#search_coupon_code").val() == ""){
				alert("쿠폰 코드를 입력해주세요 !");
				$("#search_coupon_code").focus();
				return;
			}
			
	
			$.ajax({
				type: "get",
				url: "SearchCouponCode.od",
				dataType: "json",
				data: {"cp_code": $("#search_coupon_code").val()}
				
				
			}).done(function(result){
				
				if(result == false){
					alert("사용가능한 쿠폰이 아닙니다.")
				}else if(result == true ){
					alert("이미 등록된 쿠폰입니다")
				}else{
					
// 				alert(JSON.stringify(result));
// 					$("#coupon_list").empty();
					for(let coupon of result) {
						$("#coupon_list").append(
								"<div  class='border rounded-2 d-flex ' >"
									+"<div class='p-3'>"
										+"<input type='radio' id='selectedCoupon' name='cp_code' value="+coupon.cp_code+">" 
								 		+"<label for='selectedCoupon'></label>"
							  		 +"</div>"
									+"<div class='p-3'>"
									   +  "<h4>"+coupon.cp_name+"</h4>"
									   +  "<b>"+coupon.cp_discount_value+"% 할인 (<small>최대 "+ coupon.cp_max_discount +" 원</small></b>)<br>"
									   +  "<small>" + coupon.cp_min_price +  "원 이상 구매 시</small>"+"<br>"
									   + "<small>"+ coupon.target_sd + " - " +coupon.target_ed +" ("+coupon.cp_period +"일)</small>"
									   +"<input type='hidden' name='cp_code' value='"+coupon.cp_code+"'>"
									+"</div>"
								+"</div><br>"
								
						);
					}//end of for
				
				}//end of else
				
			}).fail(function(data){
				$("#resultArea").html("요청실패").css("color","red");
			});
			
		
			

			
			

		
	
	
	});
	
	
});//$(function(){}

$(document).on("change","input[type=radio]",function(){ 
	alert("input[type=radio]");
    alert(parseInt($("#total").text()));
    
    $("input[type=radio]").is(":checked").closest("#cp_min_price").val();
    
	let calDiscount = parseInt($("#total").text()) * $("input[type=radio]").is(":checked").closest("#cp_min_price").val() / 100;
	alert("calDiscount " +  $("input[type=radio]").is(":checked").val())
	$("#discountTotal").text() = calDiscount +"원";
});
	
	function couponSubmit() {
		//쿠폰체크 여부에 따라 submit 여부 결정
		if($("input[name=cp_code]").is(":checked")){
				let cp_code = $("$input[name=cp_code]").val();
			function sendCp_code(cp_code){

				opener.getCp_code(cp_code);

				return true;
				window.close();

			}
	}else {
		alert("선택된 쿠폰이 없습니다.")
		return false;
	}
}

</script>
<body>

<!-- 팝업창: 가로 420px * 세로 600px 정도가 적당할듯 -->
	<div>
	<div class=" m-3 border border-dark border-top-0 rounded-2 border border-1"> 
		<div class="p-2 bg-dark text-white well rounded-2" >&#128226;쿠폰 사용에 대한 유의사항</div>
		<div class="mx-3 py-3">
			- 사용 가능한 쿠폰만 보여지게 됩니다.<br>
			- 쿠폰코드는 대소문자를 구분합니다.
		</div>
	</div>
	<br>
	
	<div>

                   
			<div class="m-3 d-flex justify-content-end">
				<input type="text"  class="col-sm-4 bg-light border border-secondary rounded" id="search_coupon_code" name="search_coupon_code" placeholder="  쿠폰코드를 입력하세요."> 
				<input type="button" value="쿠폰 등록" class=" mx-2 btn btn-sm btn-dark rounded" id="c-search-btn">
			</div>
		<form action="결제페이지" onsubmit="return couponSubmit();">
		<div  class=" m-3 p-3" id="coupon_list">
			
				
				<!-- 여기에 쿠폰 뿌려짐 -->

		
		</div>
			<div class="m-3">
				<input type="button" value="쿠폰 적용" class = "btn btn-primary btn-sm"  onclick="setOrderCouponValue()">
				<input type="button" value="취소" class = "btn btn-secondary btn-sm" onclick="window.close()">
			</div>
		</form>


<div>
<br>
<div class="m-3 text-center" >

		<table class=" table  text-center">
			<thead>
				<tr>
					<th width="100">현재 구매액 </th>
				    <th width="100">할인 적용액 </th>
				</tr> 
			</thead>
			<tbody>
				<tr>
					<td id="total"><%=Integer.parseInt(request.getParameter("total")) %> 원</td>
				    <td id="discountTotal"> </td>
				 </tr>
			</tbody>
		</table>
		

</div>
	

</div>

</div>
	</div>
	
	</div>
</body>
</html>