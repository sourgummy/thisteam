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
	
	#modifyForm {
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
 		width: 150px; 
		background: #D3D3D3;
		text-align: center;
	}
	
	.td_right {
 		width: 300px; 
	}	
	
	#commandCell {
		text-align: center;
		margin-bottom: 30px;
	}
	
	input, textarea {
	    font-family:"GmarketSansMedium" ;
	    border-radius: 0px;
	}	
	
	table > tbody {
		border-style: none;
	}
			
</style>
</head>
  <jsp:include page="/inc/top.jsp"></jsp:include>

<body>	
		
	<!-- Q&A 글 수정 -->	
		<h2>Q & A Modify</h2>
		<form action="QnaModifyPro.bo" name="qnaForm" method="post" enctype="multipart/form-data">
		
			<input type="hidden" name="qna_code" value="${param.qna_code }" >
			<input type="hidden" name="pageNum" value="${param.pageNum }" >
			<input type="hidden" name="qna_pass" value="${param.qna_pass }" >
			<!-- 파일 수정 시 기존 파일 삭제를 위해 실제 파일명도 파라미터로 전달 필요 -->
			<input type="hidden" name="qna_real_file" value="${qna.qna_real_file }" >
			<table class="table container">
				<tr>
					<td class="td_left"><label for="member_id">작성자</label></td>
					<td class="td_right"><input type="text" name="member_id" value="${qna.member_id }" readonly="readonly"></td>
				</tr>
<!-- 				<tr> -->
<!-- 					<td class="td_left"><label for="qna_pass"></label></td> -->
<!-- 					<td class="td_right"><input type="password" name="qna_pass" required="required"></td> -->
<!-- 				</tr> -->
				<tr>
					<td class="td_left"><label for="qna_subject">제목</label></td>
					<td class="td_right"><input type="text" name="qna_subject" value="${qna.qna_subject }" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_content">내용</label></td>
					<td class="td_right">
						<textarea id="qna_content" name="qna_content" cols="40" rows="15" required="required">${qna.qna_content }</textarea>
					</td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_file">첨부 파일</label></td>
					<td class="td_right">
						<input type="file" name="qna_file">
						<br>(기존 파일 : ${qna.qna_file })
					</td>
				</tr>
			</table>
			<section id="commandCell">
		    	<c:if test="${not empty sessionScope.sId and sessionScope.sId eq 'sId'}"><input type="submit" value="수정">&nbsp;&nbsp;</c:if>
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>	
	  <!-- Footer-->
   <footer class="py-5 bg-dark">
      <div class="container">
         <p class="m-0 text-center text-white">Copyright &copy; DangDangEat 2023</p>
      </div>
   </footer>