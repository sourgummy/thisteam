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
	  
	#modifyForm {
		width: 1224x;
		height: 500px;
		border: 1px;
		margin: auto;
	}
	
	h2 {
		font-family: 'GmarketSansMedium';
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
	<!-- 게시판 글 수정 -->
	<section id="modifyForm">
		<h2>Notice modify</h2>
		<form action="NoticeModifyPro.bo" name="noticeForm" method="post">
		    <input type="hidden" name="notice_code" value="${param.notice_code }" >
			<input type="hidden" name="pageNum" value="${param.pageNum }" >
			<table class="table container">
			<tbody>
			<!-- 입력받지 않은 글번호, 페이지번호 hidden 속성으로 전달 -->
			
<!-- 				<tr> -->
<!-- 					<td class="td_left"><label for="member_id">글쓴이</label></td> -->
<!-- 					<td class="td_right"><input type="text" name="member_id" value="${notice.member_id }" readonly="readonly"></td> --%>
<!-- 				</tr> -->
				<tr>
				<tr>
					<td class="td_left"><label for="notice_subject">Subject</label></td>
					<td class="td_right"><input type="text" name="notice_subject" value="${notice.notice_subject }" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="notice_content">Content</label></td>
					<td class="td_right">
					<input type="text" id="notice_content" style="width: 500px">
<!-- 						<textarea id="notice_content" name="notice_content" cols="250" rows="15" required="required"></textarea> -->
					</td>
				</tr>
			</table>
			<section id="commandCell">
				<input type="submit" value="수정">&nbsp;&nbsp;
				<input type="reset" value="다시쓰기">&nbsp;&nbsp;
				<input type="button" value="취소" onclick="history.back()">
			</section>
		</form>
	</section>
	<!-- Footer-->
        <footer class="py-5 bg-dark">
            <div class="container"><p class="m-0 text-center text-white">Copyright &copy; DANGDANGEAT 2022</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>
    </body>
</html>