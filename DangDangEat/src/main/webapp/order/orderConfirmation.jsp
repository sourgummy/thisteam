<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Payment</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <link rel="stylesheet" href="../css/orderConfirmation.css">
    <!-- jQuery for import--> 
  <script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<!--  <img src="http://localhost:8080/DangDangEat/upload/${cart.pro_real_thumb }" alt="${cart.pro_name }" class="product-frame" height="100">  -->
</head>
<body>
<jsp:include page="../inc/top.jsp"></jsp:include>
  <main>
    <div class="container mt-5 mb-5">
	<div class="row d-flex justify-content-center">
	<div class="col-md-8">
	<div class="card">
	<div class = "dangLogo" align="center"><img src="img/maindog.png" width="100" > </div>
	<div class="invoice p-5">
		<c:forEach var="pay" items="${paymentList }" varStatus="status">
        
			<span class="font-weight-bold d-block mt-4">${sessionScope.sId } 고객님, 주문이 완료되었습니다!</span> 
			<h5>주문번호 ${pay.pay_number}</h5> 
			<span>댕댕잇을 이용해주셔서 감사합니다.</span>
		</c:forEach>
	<div class="payment border-top mt-3 mb-3 border-bottom table-responsive">
	
		<table class="table table-borderless">
			<tbody>
			<tr>
			<c:forEach var="pay" items="${paymentList }" varStatus="status">
				<td><div class="py-2"> <span class="d-block text-muted">Order No</span> <span>${pay.pay_number}</span> </div></td>
			</c:forEach>
				<td><div class="py-2"> <span class="d-block text-muted">Order Date</span> <span>12 Jan,2018</span> </div></td>
				<td><div class="py-2"> <span class="d-block text-muted">Payment</span> <span><img src="https://img.icons8.com/color/48/000000/mastercard.png" width="20" /></span> </div></td>
				<td><div class="py-2"> <span class="d-block text-muted">Shiping Address</span> <span>414 Advert Avenue, NY,USA</span> </div></td>
			</tr>
			</tbody>
		</table>

	</div>
	
	<div class="product border-bottom table-responsive">
		<table class="table table-borderless">
			<tbody>
			<tr>
				<td width="20%"> <img src="https://i.imgur.com/u11K1qd.jpg" width="90"> </td>
				<td width="60%"> <span class="font-weight-bold">Men's Sports cap</span>
					<div class="product-qty"> <span class="d-block">Quantity:1</span> <span>Color:Dark</span> </div>
				</td>
				<td width="20%">
					<div class="text-right"> <span class="font-weight-bold">$67.50</span> </div>
				</td>
			</tr>
			
			<tr>
				<td width="20%"> <img src="https://i.imgur.com/SmBOua9.jpg" width="70"> </td>
				<td width="60%"> <span class="font-weight-bold">Men's Collar T-shirt</span>
					<div class="product-qty"> <span class="d-block">Quantity:1</span> <span>Color:Orange</span> </div>
				</td>
				<td width="20%">
					<div class="text-right"> <span class="font-weight-bold">$77.50</span> </div>
				</td>
			</tr>
			
			</tbody>
		</table>
	</div>
	
	<div class="row d-flex justify-content-end">
	<div class="col-md-5">
		<table class="table table-borderless">
			<tbody class="totals">
			<tr>
				<td><div class="text-left"> <span class="text-muted">주문금액</span> </div></td>
				<td><div class="text-right"> <span>$168.50</span> </div></td>
			</tr>
			<tr>
				<td><div class="text-left"> <span class="text-muted">배송비</span> </div></td>
				<td><div class="text-right"> <span>$22</span> </div></td>
			</tr>
			<tr>
				<td><div class="text-left"> <span class="text-muted">할인금액</span> </div></td>
				<td><div class="text-right"> <span class="text-success">$168.50</span> </div></td>
			</tr>
			<tr class="border-top border-bottom">
				<td><div class="text-left"> <span class="font-weight-bold">총주문금액</span> </div></td>
				<td><div class="text-right"> <span class="font-weight-bold">$238.50</span> </div></td>
			</tr>
			</tbody>
		</table>
	  </div>
	</div>
			<p>We will be sending shipping confirmation email when the item shipped successfully!</p>
			<p class="font-weight-bold mb-0">Thanks for shopping with us!</p> <span>DangDangEat Team</span>
	</div>
<!-- 	<div class="d-flex justify-content-between footer p-3"> <span>Need Help? visit our <a href="#"> help center</a></span> <span>12 June, 2020</span> </div> -->
	</div>
	</div>
	</div>
	</div> 
    
    
    
    
    
  </main>
</body>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>
