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
	  
	#writeForm {
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
		margin: auto;
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

	input[type=button], input[type=submit], input[type=reset], input[type=text], textarea {
	    font-family:"GmarketSansMedium" ;
	    border-radius: 0px;
	}
	
	table > tbody {
		border-style: none;
	}
	
	textarea {
		resize: none;
	}
	
</style>
    </head>
   
		<jsp:include page="/inc/top.jsp"></jsp:include>
	
    <body>

	<!-- 게시판 등록 -->
	<section class="writeForm">
		<h2>Notice Write</h2>
		<form action="NoticeWritePro.bo" name="noticeForm" method="post">
			<table class="table container">
			<tbody>
<!-- 				<tr> -->
<!-- 					<td class="td_left"><label for="member_id">Writer</label></td> -->
<!-- 					<td class="td_right"><input type="text" name="member_id" required="required" /></td> -->
<!-- 				</tr>				 -->
					
				<tr>
					<td class="td_left"><label for="notice_subject">Subject</label></td>
					<td class="td_right"><input type="text" name="notice_subject" required="required" /></td>
				</tr>
				<tr>
					<td class="td_left"><label for="notice_content">Content</label></td>
					<td class="td_right">
<!-- 						<input type="text" id="notice_content" style="width: 500px; height: 300px;" required="required"> -->
						<textarea cols="50" rows="15" required="required"></textarea>
					</td>
				</tr>	
				</tbody>			
			</table>
			<section id="commandCell">
				<input type="submit" value="등록">&nbsp;&nbsp;
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