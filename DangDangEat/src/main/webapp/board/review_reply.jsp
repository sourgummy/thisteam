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
	
	#replyForm {
		width: 1224px;
		height: 550px;
		border: 1px solid #D3D3D3;
		margin: auto;
	}
	
	
	h2 {
	    font-family:"GmarketSansMedium" ;
		text-align: center;
	}
	
	table {
	    border-collapse: collapse; 
	 	width: 1224px;
	}
	
	.td_left {
		background: #D3D3D3;
		text-align: center;
	}
	
	.td_right {
/* 	    width: 150px;   */
/* 		text-align: center; */
			background: white;
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
  	<!-- 게시판 답글 작성 -->
	<section>
	
		<h2>Review Reply Write</h2>
		<form action="ReviewReplyPro.bo" name="reviewForm" method="post" enctype="multipart/form-data">
			<!-- 입력받지 않은 글번호, 페이지번호 hidden 속성으로 전달 -->
			<input type="hidden" name="review_code" value="${param.review_code }" >
			<input type="hidden" name="pageNum" value="${param.pageNum }" >
			<!-- 답글 작성에 필요한 정보도 hidden 속성으로 전달 -->
			<input type="hidden" name="review_re_ref" value="${review.review_re_ref }" >
			<input type="hidden" name="review_re_lev" value="${review.review_re_lev }" >
			<input type="hidden" name="review_re_seq" value="${review.review_re_seq }" >
			<table class="table">
				<tr>
					<td class="td_left"><label for="member_id">Writer</label></td>
					<td class="td_right"><input type="text" name="member_id" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="review_pass">Pass</label></td>
					<td class="td_right"><input type="password" name="review_pass" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="review_subject">Subject</label></td>
					<td class="td_right"><input type="text" name="review_subject" value="Re: ${review.review_subject }" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="review_content">Content</label></td>
					<td class="td_right">
						<textarea id="review_content" name="review_content" cols="40" rows="15" required="required">${review.review_content }</textarea>
					</td>
				</tr>
				<tr>
					<td class="td_left"><label for="review_file">File</label></td>
					<td class="td_right">
						<!-- 답글 작성 시 파일 업로드는 선택 사항으로 required 옵션 제거 -->
						<input type="file" name="review_file">
					</td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="답글등록">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>
	</section>
  