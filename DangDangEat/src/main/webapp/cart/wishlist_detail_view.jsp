<%@page import="vo.CartBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%
request.setCharacterEncoding("UTF-8");
// List wishlist = (List)request.getAttribute("wishlist");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>wishlist</title>
<!-- 외부 CSS 가져오기 -->
<link href="css/bootstrap.css" rel="stylesheet" type="text/css">
<style>
	@font-face {
	    font-family: 'GmarketSansMedium';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	  
	body {
	    font-family:"GmarketSansMedium" ;
	}
	
	#total {
		text-align: right;
	}
	
	table {
	margin: auto;
	}
	
	#id {
		text-align: center;
	}
	
	th {
		text-align: center;
	}

	input[type=button], input[type=submit] {
	    font-family:"GmarketSansMedium" ;
	}

</style>
<!-- 챗봇 관련 코드 -->
<script>
  (function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
//   ChannelIO('boot', {
//     pluginKey: "1340eb3c-ddf6-43c5-a497-6a91281156bc", //please fill with your plugin key
//     memberId: "YOUR_USER_ID", //fill with user id
//     profile: {
//       "name": "YOUR_USER_NAME", //fill with user name
//       "mobileNumber": "YOUR_USER_MOBILE_NUMBER", //fill with user phone number
//       "CUSTOM_VALUE_1": "VALUE_1", //any other custom meta data
//       "CUSTOM_VALUE_2": "VALUE_2"
//     }
//   });
  ChannelIO('boot', {
     pluginKey: '1340eb3c-ddf6-43c5-a497-6a91281156bc'
      }, function onBoot(error, user) {
           if (error) {
                console.error(error);
           } else {
             console.log('boot success', user)
           }
   });
  
</script>
<!-- 챗봇 관련 코드 -->
</head>
<body>
	<!-- Login, Join 링크 표시 영역 -->
	<jsp:include page="/inc/top.jsp"></jsp:include>
	<!-- 장바구니 번호, 사진(대표이미지), 상품명, 사이즈,색상,수량,가격, 삭제 -->
	<div class="container">
	<div id="id">${sessionScope.sId }님의 위시리스트</div>
	 <table class="table">
		<tr>
		   <th></th>
		   <th>이미지</th>
		   <th>상품명</th>
		   <th>가격</th>
		   <th>선택</th>
		</tr>
		<c:forEach var="wishlist" items="${wishlist }">
			<input type="hidden" name="cart_code" value=${wishlist.cart_code }>
			<tr>
				<td>
					<input type="checkbox" checked="checked">
				</td>
				<td>${wishlist.pro_real_thumb }</td>
				<td><a href="ProductDetail.pd?pro_code=${wishlist.pro_code }">${wishlist.pro_name }</a></td>
				<td><fmt:formatNumber value="${wishlist.pro_price }" pattern="###,###,###"/></td>
				<td>
				<form action="CartInsert.ct" method="post">
					<input type="hidden" name="path" value="wishlist">
					<input type="hidden" name="pro_code" value=${wishlist.pro_code }>
					<input type="hidden" name="amount" value="1">
					<input type="submit" value="장바구니">
				</form>
				<form action="WishlistDelete.ct" method="post">
					<input type="hidden" name="path" value="wishlist">
					<input type="hidden" name="pro_code" value=${wishlist.pro_code }>
					<input type="submit" value="삭제">
				</form>
				</td>
			</tr> 
		</c:forEach>
	</table>
	</div>
	
<!-- 	<form action="WishlistDelete.ct" method="post"> -->
<%-- 		<input type="hidden" name="pro_code" value=${wishlist.pro_code }> --%>
<!-- 		<input type="submit" value="삭제하기"> -->
<!-- 	</form> -->
<!-- 	<input type="button" value="위시리스트 비우기" onclick="location.href='WishlistDelete.ct'"> -->
</body>
</html>