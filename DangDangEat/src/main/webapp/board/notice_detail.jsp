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
	#detailForm {
		width: 500px;
		height: 550px;
		border: 1px solid black;
		margin: auto;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
		border: 1px solid black;
		border-collapse: collapse; 
	 	width: 500px;
	}
	
	th {
		text-align: center;
	}
	
	td {
		width: 150px;
		text-align: center;
	}
	
	#basicInfoArea {
		height: 70px;
		text-align: center;
	}
	
	#detailContentArea {
		background: #D3D3D3;
		margin-top: 20px;
		height: 350px;
		text-align: center;
		overflow: auto;
		white-space: pre-line;
	}
	
	#commandList {
		margin: auto;
		width: 500px;
		text-align: center;
	}
   </style>	
   </head>
   <body>
        <!-- Header-->
        <!-- top.jsp -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
        <!-- Section-->
        <!-- 게시판 리스트 -->	
       <section id="detailForm">
		<h2>Notice</h2>
		<section id="basicInfoArea">
			<table border="1">
			<tr><th width="70">제 목</th><td colspan="3" >${notice.notice_subject }</td></tr>
			<tr>
				<th width="70">작성자</th><td>${notice.member_id }</td>
				<th width="70">작성일</th>
				<td><fmt:formatDate value="${notice.notice_date }" pattern="yy-MM-dd HH:mm:SS" /></td>
				<th width="70">조회수</th>
				<td>${notice.notice_readcount }</td>
			</tr>
			</table>
		</section>
		<section id="detailContentArea">
			${notice.notice_content }
		</section>
	</section>
	<section id="commandList">
	    <c:if test="${not empty sessionScope.sId and sessionScope.sId eq 'admin'}"> 
		<input type="button" value="수정" onclick="location.href='NoticeModifyForm.bo?notice_code=${param.notice_code}&pageNum=${param.pageNum }'">
		<input type="button" value="삭제" onclick="location.href='NoticeDeletePro.bo?notice_code=${param.notice_code}&pageNum=${param.pageNum }'">
		</c:if>
		<input type="button" value="목록" onclick="location.href='NoticeList.bo?pageNum=${param.pageNum}'">
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