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
  <title>orderPayment</title>
  <link href="css/orderForm.css" rel="stylesheet" type="text/css">
  <link href="css/orderForm2.css" rel="stylesheet" type="text/css">
  <style type="text/css">
		@font-face {
		    font-family: 'GmarketSansMedium';
		    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
		    font-weight: normal;
		    font-style: normal;
		}
		  
		* {
		    font-family:"GmarketSansMedium" ;
		}
  </style>
	<!-- jQuery -->
  <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
  <!-- iamport.payment.js -->
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
  <script type="text/javascript">
    /* Set values + misc */
    var promoCode;
    var promoPrice;
    var fadeTime = 300;
    var cp_code;

    
    function getCp_code(cp_code){
        document.getElementById("#promo-code").value = cp_code;
  	}
    
    function couponView() {
    	 window.open("SelectCoupon.od", "_blank", "height:700, width:300");
    }
    
    function iamport() {
		
	      IMP.init('imp03617521');  //가맹점 식별코드(댕댕잇)
	      IMP.request_pay({
	          pg : 'html5_inicis', // pg사명
	          pay_method : 'card', // 결제방식
	          merchant_uid : 'merchant_' + new Date().getTime(), // 주문번호
	          name : '${cart.pro_name }' , // 상품명
	          amount : '${cart.pro_price * cart.cart_amount + 3500 }', // 결제되는 가격
	          buyer_name : '${order.order_name }' // 주문자 이름
	      }, function(rsp) {
	         console.log(rsp);
	          if ( rsp.success ) {
	             var msg = '결제가 완료되었습니다.';
	              msg += '고유ID : ' + rsp.imp_uid;
	              msg += '상점 거래ID : ' + rsp.merchant_uid;
	              msg += '결제 금액 : ' + rsp.paid_amount;
	              msg += '카드 승인번호 : ' + rsp.apply_num;
	              location.href="OrderPaymentPro.od?order_status=1&pay_amount='${price.pro_price * price.cart_amount + 3500 }''";
	          } else {
	              var msg = '결제에 실패하였습니다.';
	               msg += '에러내용 : ' + rsp.error_msg;
	               window.history.back();
	          }
	        
	          alert(msg);
	          
// 	      }
	          
	      });
    
    $(function() {
    	
    	$('.promo-code-cta').click(function() {
    	 
    	    window.open('SelectCoupon.od', '_blank', 'height:700, width:300');
		});	
// 		/* 상품금액 + 배송비 = Total (자동로드 되도록 수정예정)*/
		
// // 	    	$("#basket-subtotal").val($(".price").val());
// // 	    	$("#basket-promo").val($("#promo-code").val());
// // 	    	$("#basket-total").val($(".subtotal").val());
		
	    	
//     	/* 아임포트 api 연결  */
	    	
// // 			function iamPort() {
			
// // 			      IMP.init('imp03617521');  //가맹점 식별코드(댕댕잇)
// // 			      IMP.request_pay({
// // 			          pg : 'html5_inicis', // pg사명
// // 			          pay_method : 'card', // 결제방식
// // 			          merchant_uid : 'merchant_' + new Date().getTime(), // 주문번호
// // 			          name : '${cart.pro_name }' , // 상품명
// // 			          amount : '${price.pro_price * price.cart_amount + 3500 }', // 결제되는 가격
// // 			          buyer_name : '${order.order_name }' // 주문자 이름
// // 			      }, function(rsp) {
// // 			         console.log(rsp);
// // 			          if ( rsp.success ) {
// // 			             var msg = '결제가 완료되었습니다.';
// // 			              msg += '고유ID : ' + rsp.imp_uid;
// // 			              msg += '상점 거래ID : ' + rsp.merchant_uid;
// // 			              msg += '결제 금액 : ' + rsp.paid_amount;
// // 			              msg += '카드 승인번호 : ' + rsp.apply_num;
// // 			              location.href="OrderPaymentPro.od?order_status=1&pay_amount='${price.pro_price * price.cart_amount + 3500 }''";
// // 			          } else {
// // 			              var msg = '결제에 실패하였습니다.';
// // 			               msg += '에러내용 : ' + rsp.error_msg;
// // 			               window.history.back();
// // 			          }
// // 			          alert(msg);
			          
// // 			      });
			
			
// // 		}); // 아임포트 api
	    	
		
// 	    /* Promo actions */
	
	
// 	    $('.promo-code-cta').click(function() {
	
// 	      promoCode = $('#promo-code').val();
	
// 	      if (promoCode == '10off' || promoCode == '10OFF') {
// 	        //If promoPrice has no value, set it as 10 for the 10OFF promocode
// 	        if (!promoPrice) {
// 	          promoPrice = 10;
// 	        } else if (promoCode) {
// 	          promoPrice = promoPrice * 1;
// 	        }
// 	      } else if (promoCode != '') {
// 	        alert("Invalid Promo Code");
// 	        promoPrice = 0;
// 	      }
// 	      //If there is a promoPrice that has been set (it means there is a valid promoCode input) show promo
// 	      if (promoPrice) {
// 	        $('.summary-promo').removeClass('hide');
// 	        $('.promo-value').text(promoPrice.toFixed(2));
// 	        recalculateCart(true);
// 	      }
// 	    });
	
// 	    /* Recalculate cart */
// 	    function recalculateCart(onlyTotal) {
// 	      var subtotal = 0;
	
// 	      /* Sum up row totals */
// 	      $('.basket-product').each(function() {
// 	        subtotal += parseInt($(this).children('.subtotal').text());
// 	      });
	
// 	      /* Calculate totals */
// 	      var total = subtotal;
	
// 	      //If there is a valid promoCode, and subtotal < 10 subtract from total
// 	      var promoPrice = parseInt($('.promo-value').text());
// 	      if (promoPrice) {
// 	        if (subtotal >= 10) {
// 	          total -= promoPrice;
// 	        } else {
// 	          alert('Order must be more than £10 for Promo code to apply.');
// 	          $('.summary-promo').addClass('hide');
// 	        }
// 	      }
	
// 	      /*If switch for update only total, update only total display*/
// 	      if (onlyTotal) {
// 	        /* Update total display */
// 	        $('.total-value').fadeOut(fadeTime, function() {
// 	          $('#basket-total').html(total.toFixed(2));
// 	          $('.total-value').fadeIn(fadeTime);
// 	        });
// 	      } else {
// 	        /* Update summary display. */
// 	        $('.final-value').fadeOut(fadeTime, function() {
// 	          $('#basket-subtotal').html(subtotal.toFixed(2));
// 	          $('#basket-total').html(total.toFixed(2));
// 	          if (total == 0) {
// 	            $('.checkout-cta').fadeOut(fadeTime);
// 	          } else {
// 	            $('.checkout-cta').fadeIn(fadeTime);
// 	          }
// 	          $('.final-value').fadeIn(fadeTime);
// 	        });
// 	      }
// 	    }
	
// 	    /* Update quantity */
// 	    function updateQuantity(quantityInput) {
// 	      /* Calculate line price */
// 	      var productRow = $(quantityInput).parent().parent();
// 	      var price = parseFloat(productRow.children('.price').text());
// 	      var quantity = $(quantityInput).val();
// 	      var linePrice = price * quantity;
	
// 	      /* Update line price display and recalc cart totals */
// 	      productRow.children('.subtotal').each(function() {
// 	        $(this).fadeOut(fadeTime, function() {
// 	          $(this).text(linePrice.toFixed(2));
// 	          recalculateCart();
// 	          $(this).fadeIn(fadeTime);
// 	        });
// 	      });
	
// 	      productRow.find('.item-quantity').text(quantity);
// 	      updateSumItems();
// 	    }
	
// 	    function updateSumItems() {
// 	      var sumItems = 0;
// 	      $('.quantity input').each(function() {
// 	        sumItems += parseInt($(this).val());
// 	      });
// 	      $('.total-items').text(sumItems);
// 	    }
	
	    
	    

//     });


function getCp_code(let cp_code){

		alert(cp_code);
//       document.getElementById("값 넣을곳 id").value = cp_code;

}

	</script>
</head>

<body>
 <jsp:include page="../inc/top.jsp"></jsp:include>
  <main>
  	<form action="OrderPaymentPro.od" method="post">
  	<c:forEach var="cart" items="${orderProductList }" varStatus="status">
  		<input type="hidden" name="cart_code" value="${cart.cart_code }">
  		<input type="hidden" name="pro_code" value="${cart.pro_code }">
  		<input type="hidden" name="pro_amount" value="${cart.pro_price * cart.cart_amount + 3500 }">
  	</c:forEach>
  		<h1 align="center">주문서 확인 & 결제 페이지</h1>
	    <div class="basket">
  		<h1>주문상품 확인</h1>
  		<p>Please check your shopping details.</p>
	      <div class="basket-labels">
	        <ul>
	          <li class="item item-heading">Item</li>
	          <li class="price">Price</li>
	          <li class="quantity">Quantity</li>
	          <li class="subtotal">Subtotal</li>
	        </ul>
	      </div>
	   
	      <div class="basket-product">
	         <c:forEach var="cart" items="${orderProductList }" varStatus="status">
		        <div class="item">
			          <div class="product-image">
			          		<a href="ProductDetail.pd?pro_code=${cart.pro_code}">
			            	<img src="http://localhost:8080/DangDangEat/upload/${cart.pro_real_thumb }" alt="${cart.pro_name }" 
			            	class="product-frame" height="100" onerror="this.src='./img/sample1_thumb.png';" >
			            	</a>
			          </div>
			          <div class="product-details">
			            <h1><strong><span class="item-quantity" >상품명 : ${cart.pro_name }</span></strong></h1>
<%-- 			            <p><strong>브랜드명 : ${cart.pro_brand }</strong></p> --%>
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
	      
	   <!-- 주문자 정보 -->
	  <hr />    
	  <h1>배송 정보 확인</h1>
	  <p>Please check your shipping details.</p>
	  <hr />
		  <div class="form">
		    <c:forEach var="order" items="${orderMemberList }" varStatus="status">
		    	<input type="hidden" name="order_code" value="${order.order_code }">
			  <div class="fields fields--2">
			    <label class="field">
			      <span class="field__label" >이름</span>
			      <input class="field__input" type="text" id="order_name" name="order_name" value="${order.order_name }" readonly="readonly">
			    </label>
			  </div>
			      
			  <div class="fields fields--2">
			  	<label class="field">
			      <span class="field__label">연락처</span>
			      <input class="field__input" type="text" id="order_mobile" name="order_mobile" value="${order.order_mobile }" readonly="readonly">
			    </label>
			   </div>
			   
	     	  <div class="fields fields--2">
			    <label class="field">
			      <span class="field__label">우편번호</span>
			      <input class="field__input" type="text" id="order_zipcode" value="${order.order_postcode }" readonly="readonly"/>
			    </label>
			  </div>
			   
			  <label class="field">
			    <span class="field__label" >Address1</span>
			    <input class="field__input" type="text" id="order_address1" value="${order.order_address1 }" readonly="readonly"/>
			  </label>
			  <label class="field">
			    <span class="field__label" >Address2(상세주소)</span>
			    <input class="field__input" type="text" id="order_address2" value="${order.order_address2 }" readonly="readonly"/>
			  </label>
			  <label class="field">
			    <span class="field__label" >배송 메세지</span>
			    <input class="field__input" type="text" id="order_message" value="${order.order_comment }" readonly="readonly"/>
			  </label>
			  
			
			  
	  	</c:forEach>
	  </div>
	  <!-- 주문자 정보 -->
	  
		 
 	
		<!-- 할인 정보 -->
	  <hr />    
	  <h1>할인 정보</h1>
	       <div class="basket-module"> 
		        <label for="promo-code">Enter a promotional code</label>
		        <input id="promo-code" type="text" name="promo-code" maxlength="5" class="promo-code-field">
		        <input type="button" class="promo-code-cta" onclick="window.open('SelectCoupon.od, '_blank', 'height:700, width:300')">Apply
	      </div>
	  	 <hr>
	</div>
			<c:forEach var="price" items="${orderProductList }" varStatus="status">
		      <div class="basket">
			        <div class="summary-total-items"><span class="total-items"></span> Items in your Bag</div>
			        <div class="summary-subtotal">
				          <div class="subtotal-title">상품금액</div>
				          <div class="subtotal-value final-value" id="basket-subtotal"><fmt:formatNumber pattern="#,###">${price.pro_price * price.cart_amount }</fmt:formatNumber></div>
				          <div class="summary-promo hide">
					          <div class="promo-title">할인금액</div>
					          <div class="promo-value final-value" id="basket-promo"></div>
				       	  </div>
				          <div class="subtotal-title">배송비</div>
				          <div class="subtotal-value final-value" id="basket-delivery">3,500</div>
			        </div>
			      <div class="summary-total">
			          <div class="total-title">Total</div>
			          <div class="total-value final-value" id="basket-total"><fmt:formatNumber pattern="#,###">${price.pro_price * price.cart_amount + 3500 }</fmt:formatNumber></div>
			      </div>
		      	  <div class="summary-checkout">
		             <button class="button" id="checkout" type="submit" >Checkout</button>
		     	  </div>
		      </div>
	     </c:forEach> 
	 
	   </form>   
  </main>
</body>

</html>

 
 
