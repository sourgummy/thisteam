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
/* 		width: 150px; */
		background: #D3D3D3;
		text-align: center;
	}
	
	.td_right {
/* 		width: 300px; */
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
	<section id="replyForm">
		<h2>Q&A Reply Write</h2>
		<form action="QnaReplyPro.bo" name="qnaForm" method="post" enctype="multipart/form-data">
			<!-- 입력받지 않은 글번호, 페이지번호 hidden 속성으로 전달 -->
			<input type="hidden" name="qna_code" value="${param.qna_code }" >
			<input type="hidden" name="pageNum" value="${param.pageNum }" >
			<!-- 답글 작성에 필요한 정보도 hidden 속성으로 전달 -->
			<input type="hidden" name="qna_re_ref" value="${qna.qna_re_ref }" >
			<input type="hidden" name="qna_re_lev" value="${qna.qna_re_lev }" >
			<input type="hidden" name="qna_re_seq" value="${qna.qna_re_seq }" >
			<table>
				<tr>
					<td class="td_left"><label for="member_id">Writer</label></td>
					<td class="td_right"><input type="text" name="member_id" required="required"></td>
				</tr>
				
				<tr>
					<td class="td_left"><label for="qna_pass">Pass</label></td>
					<td class="td_right"><input type="password" name="qna_pass" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_subject">Subject</label></td>
					<td class="td_right"><input type="text" name="qna_subject" value="Re: ${qna.qna_subject }" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_content">Content</label></td>
					<td class="td_right">
						<textarea id="qna_content" name="qna_content" cols="40" rows="15" required="required">${qna.qna_content }</textarea>
					</td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_file">File</label></td>
					<td class="td_right">
						<input type="file" name="qna_file">
							<br>(기존 파일 : ${qna.qna_file })
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
