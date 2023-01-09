<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="en">
    <head>
  <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
  <style type="text/css">
	@font-face {
	    font-family: 'GmarketSansMedium';
	    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansMedium.woff') format('woff');
	    font-weight: normal;
	    font-style: normal;
	}
	  body {
	    font-family:"GmarketSansMedium" ;
	}	
	  
	#passForm {
		width: 1224px;
		height: 550px;
		margin: auto;
	}
	
	h2 {
	    font-family:"GmarketSansMedium" ;
		text-align: center;
	}
	
	table {
	    width: 300px;
		margin: auto;
		text-align: center;
	}
	
	#commandCell {
		text-align: center;
		margin-bottom: 30px;
	}
	
		input[type=button], input[type=submit], input[type=reset], input[type=text] {
	    font-family:"GmarketSansMedium" ;
	}	
	
	table > tbody {
		border-style: none;
	}
	
</style>
</head>
<jsp:include page="/inc/top.jsp"></jsp:include>
<body>		
			
	<!-- 게시판 글 삭제 -->
	<h2>QNA Delete</h2>
	<section id="passForm">
		<form action="QnaDeletePro.bo" name="deleteForm" method="post">
			<!-- 입력받지 않은 글번호, 페이지번호 hidden 속성으로 전달 -->
			<input type="hidden" name="qna_code" value="${param.qna_code }" >
			<input type="hidden" name="pageNum" value="${param.pageNum }" >
			<table>
				<tr>
					<td><label>Password</label></td>
					<td><input type="password" name="qna_pass" required="required"></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" value="삭제">&nbsp;&nbsp;
						<input type="button" value="돌아가기" onclick="javascript:history.back()">
					</td>
				</tr>
			</table>
		</form>
	</section>
 