<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




	<div class="container" id="mypage_couponAjax">

		<div class="card" id="titleDiv">
			<div class="card-header">
				<strong>내가 가진 쿠폰</strong>
			</div>

	
			<div class="card-body card-block" id="couponDiv">
			<c:choose>
				<c:when test="${not empty param.cp_code }">
				  <div class='m-3 d-flex justify-content-end'>
				       <input type='text'  class='col-sm-4 bg-light border border-secondary rounded' id='search_coupon_code' name='search_coupon_code' value='${ param.cp_code}' placeholder=' 쿠폰코드를 입력하세요.'>
				       <input type='button' value='쿠폰 등록' class='mx-2 btn btn-sm  btn-outline-dark rounded' id='c-search-btn'></div>
				</c:when>
				<c:otherwise>
					<div class='m-3 d-flex justify-content-end'> 
				       <input type='text'  class='col-sm-4 bg-light border border-secondary rounded' id='search_coupon_code' name='search_coupon_code' placeholder=' 쿠폰코드를 입력하세요.'>
				       <input type='button' value='쿠폰 등록' class='mx-2 btn btn-sm  btn-outline-dark rounded' id='c-search-btn'></div>
				</c:otherwise>
			</c:choose>
			
			
<%-- 		       <%if (request.getParameter("cp_code") != null){%> --%>
				   
<!-- 				       <div class='m-3 d-flex justify-content-end'> -->
<%-- 				       <input type='text'  class='col-sm-4 bg-light border border-secondary rounded' id='search_coupon_code' name='search_coupon_code' value='<%=(request.getParameter("cp_code") %>' placeholder=' 쿠폰코드를 입력하세요.'> --%>
<!-- 				       <input type='button' value='쿠폰 등록' class='mx-2 btn btn-sm  btn-outline-dark rounded' id='c-search-btn'></div> -->
<%-- 				   	<%}else{ %> --%>
				   	
<!-- 						<div class='m-3 d-flex justify-content-end'> -->
<!-- 							<input type='text'  class='col-sm-4 bg-light border border-secondary rounded' id='search_coupon_code' name='search_coupon_code' placeholder=' 쿠폰코드를 입력하세요.'>  -->
<!-- 							<input type='button' value='쿠폰 등록' class='mx-2 btn btn-sm  btn-outline-dark rounded' id='c-search-btn'> -->
<!-- 						</div> -->
				
<%-- 				<% } %> --%>
				

					<div class='card-body card-block' id='coupinDiv'>
				<% if (request.getAttribute("couponList") == "[]"){%>
							<div class='d-flex py-2 border border-dark rounded-2'>
								<div class='align-self-center p-2'><img src='img/no_coupon.png' width='100px'></div>
								<div class='align-self-center p-2'>사용가능한 쿠폰이 없습니다.</div>
							</div>
					<% }else{%> 
						
						<% JSONArray couponList = (JSONArray)request.getAttribute("couponList");
						for(int i=0; i<couponList.length(); i++){ 
						JSONObject coupon = couponList.getJSONObject(i); 
					System.out.println("   mypage_couponAjax.jsp  :" + couponList); %> 
					<div  class='border rounded-2 d-flex my-1'>
						<div class='p-5 '>
							 <h3><%=coupon.get("cp_name") %> ( <%=coupon.get("cp_discount_value") %> % 할인 ) </h3>  
							  
							    <%=coupon.get("cp_min_price") %>원 이상 구매 시 ( 최대 <%=coupon.get("cp_max_discount") %> 원)<br>
							  <%=coupon.get("target_sd") %> - <%=coupon.get("target_ed") %> ( <%=coupon.get("cp_period") %> 일)
							</div>
					</div>
					
				<% }} %>
			
					
			
				
	</div>
	</div>
	</div>
</div>
	
