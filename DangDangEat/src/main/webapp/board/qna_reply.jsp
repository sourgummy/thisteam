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
        <style type="text/css">
	#replyForm {
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
	<header>
		<!-- Login, Join 링크 표시 영역 -->
		<jsp:include page="/inc/top.jsp"></jsp:include>
	</header>
	<!-- 게시판 답글 작성 -->
	<section id="replyForm">
		<h1>Q&A 답글 작성</h1>
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
					<td class="td_left"><label for="member_id">글쓴이</label></td>
					<td class="td_right"><input type="text" name="member_id" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_pass">비밀번호</label></td>
					<td class="td_right"><input type="password" name="qna_pass" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_subject">제목</label></td>
					<td class="td_right"><input type="text" name="qna_subject" value="Re: ${qna.qna_subject }" required="required"></td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_content">내용</label></td>
					<td class="td_right">
						<textarea id="qna_content" name="qna_content" cols="40" rows="15" required="required">${qna.qna_content }</textarea>
					</td>
				</tr>
				<tr>
					<td class="td_left"><label for="qna_file">파일</label></td>
					<td class="td_right">
						<!-- 답글 작성 시 파일 업로드는 선택 사항으로 required 옵션 제거 -->
						<input type="file" name="qna_file">
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