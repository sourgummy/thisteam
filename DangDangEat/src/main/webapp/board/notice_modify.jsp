<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>DangDangEat - Shop List</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
        <link href="../css/bootstrap.min.css" rel="stylesheet" />
	<style type="text/css">
	  
	#modifyForm {
		width: 500px;
		height: 500px;
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
	
	<!-- 게시판 글 수정 -->
	<section id="modifyForm">
		<h5>게시판 글 수정</h5>
		<form action="NoticeModifyPro.bo" name="noticeForm" method="post">
			<!-- 입력받지 않은 글번호, 페이지번호 hidden 속성으로 전달 -->
			<input type="hidden" name="notice_code" value="${param.notice_code }" >
			<input type="hidden" name="pageNum" value="${param.pageNum }" >
			<table>
				<tr>
					<td class="td_left"><label for="member_id">글쓴이</label></td>
					<td class="td_right"><input type="text" name="member_id" value="${notice.member_id }" readonly="readonly"></td>
				</tr>
				<tr>
				<tr>
					<td class="td_left"><label for="notice_subject">제목</label></td>
					<td class="td_right"><input type="text" name="notice_subject" value="${notice.notice_subject }" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="notice_content">내용</label></td>
					<td class="td_right">
						<textarea id="notice_content" name="notice_content" cols="40" rows="15" required="required">${notice.notice_content }</textarea>
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