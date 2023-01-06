<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>   
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>orderForm</title>
  <link href="css/orderForm.css" rel="stylesheet" type="text/css">
  <link href="css/orderForm2.css" rel="stylesheet" type="text/css">
  	<!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
    <!-- iamport.payment.js -->
     <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
    <script type="text/javascript">
    /* Set values + misc */
    var promoCode;
    var promoPrice;
    var fadeTime = 300;
    
    $(function() {
    	
		/* 체크박스 클릭 시 주문자 정보 => 배송정보 */	
		$("#same_info").on("change", function() {
			if($("#same_info").is(":checked")) {
				$("#shipment_name").val($("#order_name").val());
				$("#shipment_mobile").val($("#order_mobile").val());
				$("#shipment_address1").val($("#order_address1").val());
				$("#shipment_address2").val($("#order_address2").val());
				$("#shipment_zipcode").val($("#order_zipcode").val());
			} else {  
				$("#shipment_name").val("");
				$("#shipment_mobile").val("");
				$("#shipment_address1").val("");
				$("#shipment_address2").val("");
				$("#shipment_zipcode").val("");
			}
		});
		
		
		
		/* 상품금액 + 배송비 = Total (자동로드 되도록 수정예정)*/
		
// 	    	$("#basket-subtotal").val($(".price").val());
// 	    	$("#basket-promo").val($("#promo-code").val());
// 	    	$("#basket-total").val($(".subtotal").val());
		
	    /* Promo actions */
	
	
	    $('.promo-code-cta').click(function() {
	
	      promoCode = $('#promo-code').val();
	
	      if (promoCode == '10off' || promoCode == '10OFF') {
	        //If promoPrice has no value, set it as 10 for the 10OFF promocode
	        if (!promoPrice) {
	          promoPrice = 10;
	        } else if (promoCode) {
	          promoPrice = promoPrice * 1;
	        }
	      } else if (promoCode != '') {
	        alert("Invalid Promo Code");
	        promoPrice = 0;
	      }
	      //If there is a promoPrice that has been set (it means there is a valid promoCode input) show promo
	      if (promoPrice) {
	        $('.summary-promo').removeClass('hide');
	        $('.promo-value').text(promoPrice.toFixed(2));
	        recalculateCart(true);
	      }
	    });
	
	    /* Recalculate cart */
	    function recalculateCart(onlyTotal) {
	      var subtotal = 0;
	
	      /* Sum up row totals */
	      $('.basket-product').each(function() {
	        subtotal += parseInt($(this).children('.subtotal').text());
	      });
	
	      /* Calculate totals */
	      var total = subtotal;
	
	      //If there is a valid promoCode, and subtotal < 10 subtract from total
	      var promoPrice = parseInt($('.promo-value').text());
	      if (promoPrice) {
	        if (subtotal >= 10) {
	          total -= promoPrice;
	        } else {
	          alert('Order must be more than £10 for Promo code to apply.');
	          $('.summary-promo').addClass('hide');
	        }
	      }
	
	      /*If switch for update only total, update only total display*/
	      if (onlyTotal) {
	        /* Update total display */
	        $('.total-value').fadeOut(fadeTime, function() {
	          $('#basket-total').html(total.toFixed(2));
	          $('.total-value').fadeIn(fadeTime);
	        });
	      } else {
	        /* Update summary display. */
	        $('.final-value').fadeOut(fadeTime, function() {
	          $('#basket-subtotal').html(subtotal.toFixed(2));
	          $('#basket-total').html(total.toFixed(2));
	          if (total == 0) {
	            $('.checkout-cta').fadeOut(fadeTime);
	          } else {
	            $('.checkout-cta').fadeIn(fadeTime);
	          }
	          $('.final-value').fadeIn(fadeTime);
	        });
	      }
	    }
	
	    /* Update quantity */
	    function updateQuantity(quantityInput) {
	      /* Calculate line price */
	      var productRow = $(quantityInput).parent().parent();
	      var price = parseFloat(productRow.children('.price').text());
	      var quantity = $(quantityInput).val();
	      var linePrice = price * quantity;
	
	      /* Update line price display and recalc cart totals */
	      productRow.children('.subtotal').each(function() {
	        $(this).fadeOut(fadeTime, function() {
	          $(this).text(linePrice.toFixed(2));
	          recalculateCart();
	          $(this).fadeIn(fadeTime);
	        });
	      });
	
	      productRow.find('.item-quantity').text(quantity);
	      updateSumItems();
	    }
	
	    function updateSumItems() {
	      var sumItems = 0;
	      $('.quantity input').each(function() {
	        sumItems += parseInt($(this).val());
	      });
	      $('.total-items').text(sumItems);
	    }
	
	    
	    
    });
    </script>
</head>

<body>
 <jsp:include page="../inc/top.jsp"></jsp:include>
  <main>
  	<form action="OrderInsertPro.od" method="post">
  		<!-- order_product 에 들어갈 정보 -->
  		<input type="hidden" name="cart_code" value="${param.cart_code }"> 
  		<input type="hidden" name="pro_code" value="${param.pro_code }">
  		<!--  -->
	    <div class="basket">
	      <div class="basket-labels">
	        <ul>
	          <li class="item item-heading">Item</li>
	          <li class="price">Price</li>
	          <li class="quantity">Quantity</li>
	          <li class="subtotal">Subtotal</li>
	        </ul>
	      </div>
	   
	      <div class="basket-product">
	         <c:forEach var="cart" items="${cartList }" varStatus="status">
		        <div class="item">
			          <div class="product-image">
			            <a href="ProductDetail.pd?pro_code=${cart.pro_code}">
			            	<img src="http://localhost:8080/DangDangEat/upload/${cart.pro_real_thumb }" alt="${cart.pro_name }" class="product-frame" height="100">
			           	</a>
			          </div>
			          <div class="product-details">
			            <h1><strong><span class="item-quantity" >상품명 : ${cart.pro_name }</span></strong></h1>
			            <p><strong>브랜드명 : ${cart.pro_brand }</strong></p>
			            <p>Product Code : ${cart.pro_code }</p>
			          </div>
		        </div>
		        <div class="price" ><fmt:formatNumber pattern="#,###">${cart.pro_price }</fmt:formatNumber></div>
		        <div class="quantity">
		          <input type="number" value="${cart.cart_amount }" id="quantitiy" class="quantity-field">
		        </div>
		        <div class="subtotal"><fmt:formatNumber pattern="#,###">${cart.pro_price * cart.cart_amount }</fmt:formatNumber></div>
	        </c:forEach>
	      </div>
	     </div> 
	   <!-- 주문자 정보 -->
	  <hr />    
	  <h1>주문자 정보</h1>
	  <p>Please enter your shipping details.</p>
	  <hr />
		  <div class="form">
		    <c:forEach var="member" items="${memberList }" varStatus="status">
			  <div class="fields fields--2">
			    <label class="field">
			      <span class="field__label" >이름</span>
			      <input class="field__input" type="text" id="order_name" name="order_name" value="${member.member_name }">
			    </label>
			  </div>
			      
			  <div class="fields fields--2">
			  	<label class="field">
			      <span class="field__label">연락처</span>
			      <input class="field__input" type="text" id="order_mobile" name="order_mobile" value="${member.member_mobile }">
			    </label>
			   </div>
			   
	     	  <div class="fields fields--2">
			    <label class="field">
			      <span class="field__label">우편번호</span>
			      <input class="field__input" type="text" id="order_zipcode" value="${member.member_postcode }"/>
			    </label>
			  </div>
			   
			  <label class="field">
			    <span class="field__label" >Address1</span>
			    <input class="field__input" type="text" id="order_address1" value="${member.member_addr1 }"/>
			  </label>
			  <label class="field">
			    <span class="field__label" >Address2(상세주소)</span>
			    <input class="field__input" type="text" id="order_address2" value="${member.member_addr2 }"/>
			  </label>
			  
			
			  
	  	</c:forEach>
	  </div>
	  <!-- 주문자 정보 -->
	  
		  <!-- 배송 정보 -->
		  <hr />    
		  <h1>배송 정보</h1>
		  <p>Please enter your shipping details.</p>
		  <hr />
		  <div>
			  <label class="same_info">
			  <input type="checkbox" id="same_info" />주문자 정보와 동일합니까?</label>
		  </div>
		  <hr />
  	
		  <div class="form">
			  <div class="fields fields--2">
			    <label class="field">
			      <span class="field__label" >이름</span>
			      <input class="field__input" type="text" id="shipment_name" name="shipment_name" placeholder="김댕댕" required="required">
			    </label>
			  </div>
			      
			  <div class="fields fields--2">
			  	<label class="field">
			      <span class="field__label">연락처</span>
			      <input class="field__input" type="text" id="shipment_mobile" name="shipment_mobile" placeholder="010-1234-5678" required="required">
			    </label>
			  </div>
		      <div class="fields fields--2">
				    <label class="field">
				      <span class="field__label" >우편번호</span>
				      <input class="field__input" type="text" id="shipment_zipcode" name="shipment_zipcode" required="required">
			    	</label>
			       <input type="button" value="주소 검색" onclick="kakaoAddr()">
		      </div>
			   
			  <label class="field">
				    <span class="field__label" >Address1</span>
				    <input class="field__input" type="text" id="shipment_address1" name="shipment_address1"  required="required">
			  </label>
			  
			  <label class="field">
				    <span class="field__label" >Address2(상세주소)</span>
				    <input class="field__input" type="text" id="shipment_address2" name ="shipment_address2" required="required">
			  </label>
			  
		  	  <div class="fields fields--2">
			     <label class="field">
			       	  <span class="field__label" >배송 메시지 선택</span>
				      <select id="message" name="message">
				      	<option>선택하세요</option>
				      	<option value="배송 전 미리 연락 바랍니다.">배송 전 미리 연락바랍니다.</option>
				      	<option value="부재 시 경비실에 맡겨주세요.">부재 시 경비실에 맡겨주세요.</option>
				      	<option value="부재 시 문 앞에 놓아주세요.">부재 시 문 앞에 놓아주세요.</option>
				      	<option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
				      	<option value="택배함에 놓아주세요">택배함에 놓아주세요</option>
				      </select>
			     </label>
			  </div>
		 </div>
 	
		<!-- 할인 정보 -->
<!-- 	  <hr />     -->
<!-- 	  <h1>할인 정보</h1> -->
<!-- 	       <div class="basket-module">  -->
<!-- 		        <label for="promo-code">Enter a promotional code</label> -->
<!-- 		        <input id="promo-code" type="text" name="promo-code" maxlength="5" class="promo-code-field"> -->
<!-- 		        <button class="promo-code-cta">Apply</button> -->
<!-- 	      </div> -->
<!-- 	  	 <hr> -->
<!-- 	</div> -->
<%-- 			<c:forEach var="cart" items="${viewList }" varStatus="status"> --%>
<!-- 		      <div class="basket"> -->
<!-- 			        <div class="summary-total-items"><span class="total-items"></span> Items in your Bag</div> -->
<!-- 			        <div class="summary-subtotal"> -->
<!-- 				          <div class="subtotal-title">상품금액</div> -->
<%-- 				          <div class="subtotal-value final-value" id="basket-subtotal"><fmt:formatNumber pattern="#,###">${cart.pro_price * cart.cart_amount }</fmt:formatNumber></div> --%>
<!-- 				          <div class="summary-promo hide"> -->
<!-- 					          <div class="promo-title">할인금액</div> -->
<!-- 					          <div class="promo-value final-value" id="basket-promo"></div> -->
<!-- 				       	  </div> -->
<!-- 				          <div class="subtotal-title">배송비</div> -->
<!-- 				          <div class="subtotal-value final-value" id="basket-delivery">3,500</div> -->
<!-- 			        </div> -->
<!-- 		      </div> -->
<!-- 		      <div class="summary-total"> -->
<!-- 		          <div class="total-title">Total</div> -->
<%-- 		          <div class="total-value final-value" id="basket-total"><fmt:formatNumber pattern="#,###">${cart.pro_price * cart.cart_amount + 3500 }</fmt:formatNumber></div> --%>
<!-- 		      </div> -->
<%-- 	     </c:forEach>  --%>
	 	<hr>
	 	<hr>
	      <div class="summary-checkout">
	          <button class="button" type="submit" id="checkout" >Checkout</button>
	      </div>
	   </form>   
  </main>
</body>
<%-- 카카오 주소 API 적용하기 --%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
	function kakaoAddr() { // onclick 시 작동할 함수 선언
		new daum.Postcode({
			oncomplete: function(data) {
				var roadAddr = data.roadAddress;
				// 회원이 검색해서 찾은 주소 클릭 시 폼에 뿌리기
				document.getElementById("shipment_zipcode").value = data.zonecode;
				document.getElementById("shipment_address1").value = data.roadAddress;
			}
		}).open();
	}
</script>
</html>
