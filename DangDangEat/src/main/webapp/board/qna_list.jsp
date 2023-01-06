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
	#listForm {
		width: 1600px;
        max-height: 610px;
        margin: auto;
	}
	
	h2 {
		text-align: center;
	}
	
	table {
		margin: auto;
		width: 1024px;
	}
	
	#tr_top {
		background: #D3D3D3;
		text-align: center;
	}
	
	table td {
		text-align: center;
	}
	
	#subject {
		text-align: left;
		padding-left: 20px;
	}
	
	#pageList {
		margin: auto;
		width: 1024px;
		text-align: center;
	}
	
	#emptyArea {
		margin: auto;
		width: 1024px;
		text-align: center;
	}
	
	#buttonArea {
		margin: auto;
		width: 1024px;
		text-align: right;
		margin-top: 10px;
	}
	
	a {
		text-decoration: none;
	}
</style>
</head>
<body>
	
		<jsp:include page="../inc/top.jsp"></jsp:include>
	
	<!-- 게시판 리스트 -->
	<section id="listForm">
	<h2>문의</h2>
    <table>	
		<tr id="tr_top">
			<td width="100px">No</td>
			<td>Subject</td>
			<td width="150px">Writer</td>
			<td width="150px">Date</td>
			<td width="150px">Status</td>
		</tr>
		<!-- JSTL 과 EL 활용하여 글목록 표시 작업 반복 -->
		<%-- for(QnaBean qna : qnaList) {} --%>
		<c:forEach var="qna" items="${qnaList}">
			<tr>
				<td>${qna.qna_code }</td>
				<!-- 제목 하이퍼링크(QnaDetail.bo) 연결 -> 파라미터 : 글번호, 페이지번호 -->
				<!-- 만약, pageNum 파라미터가 비어있을 경우 pageNum 변수 선언 및 기본값 1로 설정 -->
				<c:choose>
					<c:when test="${empty param.pageNum }">
						<c:set var="pageNum" value="1" />
					</c:when>
					<c:otherwise>
						<c:set var="pageNum" value="${param.pageNum }" />
					</c:otherwise>
				</c:choose>
				<td id="subject">
					<%-- ======================== 답글 관련 처리 ======================= --%>
					<%-- qna_re_lev 값이 0보다 크면 답글이므로 들여쓰기 후 이미지 추가 --%>
					<c:if test="${qna.qna_re_lev > 0 }">
						<%-- 반복문을 통해 qna_re_lev 값 만큼 공백 추가 --%>
						<c:forEach var="i" begin="1" end="${qna.qna_re_lev }">
							&nbsp;&nbsp;
						</c:forEach>
						<%-- 답글 제목 앞에 이미지 추가 --%>
						<img src="images/re.gif">	
					</c:if>
					<%-- =============================================================== --%>
					<a href="QnaDetail.bo?qna_code=${qna.qna_code }&pageNum=${pageNum }">
						${qna.qna_subject }
					</a>
				</td>
				<td>${qna.member_id }</td>
				<td>
					<%-- JSTL 의 fmt 라이브러리를 활용하여 날짜 표현 형식 변경 --%>
					<%-- fmt:formatDate - Date 타입 날짜 형식 변경 --%>
					<%-- fmt:parseDate - String 타입 날짜 형식 변경 --%>
					<fmt:formatDate value="${qna.qna_date }" pattern="yy-MM-dd HH:mm"/>
				</td>
					<td>${qna.qna_status }</td>
			  </tr>
		</c:forEach>
	</table>
	</section>
	<section id="buttonArea">
		<form action="QnaList.bo">
			<input type="text" name="keyword">
			<input type="submit" value="검색">
			&nbsp;&nbsp;			
			<input type="button" value="글쓰기" onclick="location.href='QnaWriteForm.bo'" />
		</form>
	</section>
	<section id="pageList">
		<!-- 
		현재 페이지 번호(pageNum)가 1보다 클 경우에만 [이전] 링크 동작
		=> 클릭 시 QnaList.bo 서블릿 주소 요청하면서 
		   현재 페이지 번호(pageNum) - 1 값을 page 파라미터로 전달
		-->
		<c:choose>
			<c:when test="${pageNum > 1}">
				<input type="button" value="이전" onclick="location.href='QnaList.bo?pageNum=${pageNum - 1}'">
			</c:when>
			<c:otherwise>
				<input type="button" value="이전">
			</c:otherwise>
		</c:choose>
			
		<!-- 페이지 번호 목록은 시작 페이지(startPage)부터 끝 페이지(endPage) 까지 표시 -->
		<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
			<!-- 단, 현재 페이지 번호는 링크 없이 표시 -->
			<c:choose>
				<c:when test="${pageNum eq i}">
					${i }
				</c:when>
				<c:otherwise>
					<a href="QnaList.bo?pageNum=${i }">${i }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
		<c:choose>
			<c:when test="${pageNum < pageInfo.maxPage}">
				<input type="button" value="다음" onclick="location.href='QnaList.bo?pageNum=${pageNum + 1}'">
			</c:when>
			<c:otherwise>
				<input type="button" value="다음">
			</c:otherwise>
		</c:choose>
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
	