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
	
	  
	#reviewForm {
		width: 500px;
		height: 450px;
		border: 1px solid black;
		margin: auto;
	}
	
	h1 {
		text-align: center;
	}
	
	table {
		margin: auto;
		width: 450px;
	}
	
	.td_left {
		width: 150px;
		background: #D3D3D3;
		text-align: center;
	}
	
	.td_right {
		width: 300px;
	}
	
	#commandCell {
		text-align: center;
	}
</style>
</head>
<body>
	
		<jsp:include page="/inc/top.jsp"></jsp:include>
	
	<!-- 게시판 등록 -->
	<section id="writeForm">
		<h1>Q&A 등록</h1>
		<!-- 파일 업로드 기능 사용 위해 enctype 속성 설정 => cos.jar 라이브러리 필요 -->
		<form action="QnaWritePro.bo" name="qnaForm" method="post" enctype="multipart/form-data">
			<table>
				<tr>
					<td class="td_left"><label for="member_id">작성자</label></td>
					<td class="td_right"><input type="text" name="member_id" required="required" /></td>
				</tr>
				<tr>
               <td class="td_left"><label for="pro_code">상품코드</label></td>
               <td class="td_right"><input type="text" name="pro_code" required="required" /></td>
               </tr>
				<tr>
					<td class="td_left"><label for="qna_pass">비밀번호</label></td>
					<td class="td_right">
						<input type="password" name="qna_pass" required="required" />
					</td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_subject">제목</label></td>
					<td class="td_right"><input type="text" name="qna_subject" required="required" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_content">내용</label></td>
					<td class="td_right">
						<textarea id="qna_content" name="qna_content" cols="40" rows="15" required="required"></textarea>
					</td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_file">파일 첨부</label></td>
					<!-- 파일 첨부 형식은 input 태그의 type="file" 속성 사용 -->
					<td class="td_right">
						<input type="file" name="qna_file" />
<!-- 						<br><input type="file" name="qna_file2" /> -->
<!-- 						<br><input type="file" name="qna_file3" /> -->
					</td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="등록">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>
	</section>

