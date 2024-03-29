<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html lang="en">
    <head>
    <title>DangDangEAT - Review List</title>
  <link href="css/bootstrap.css" rel="stylesheet" type="text/css">
  <link href="css/styles.css" rel="stylesheet" />   
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
	
	  
	#listForm {
		width: 1224px;
        max-height: 610px;
        margin: auto;
	}
	
	h2 {
		text-align: center;
		font-family:"GmarketSansMedium" ;
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
	margin-bottom: 30px;
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
		margin-bottom: 30px;
	}
	
	#commandCell {
		text-align: center;
		margin-bottom: 30px;
	}
	
	a {
		text-decoration: none;
	}
		input[type=button], input[type=submit], input[type=text] {
	    font-family:"GmarketSansMedium" ;
	    border-radius: 0px;
	}
	
</style>
</head>
<body>
	
	<jsp:include page="/inc/top.jsp"></jsp:include>

	
	<!-- 게시판 리스트 -->
	<section id="listForm">
	
	<table class="table">	
	<h2>Review</h2>
		<tr id="tr_top">
			<td width="100px">No</td>
			<td>Subject</td>
			<td width="150px">Writer</td>
			<td width="150px">Date</td>
			<td width="100px">Hit</td>
		</tr>
		<!-- JSTL 과 EL 활용하여 글목록 표시 작업 반복 -->
		<%-- for(ReviewBean review : reviewList) {} --%>
		<c:forEach var="review" items="${reviewList }">
			<tr>
				<td>${review.review_code }</td>
				<!-- 제목 하이퍼링크(ReviewDetail.bo) 연결 -> 파라미터 : 글번호, 페이지번호 -->
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
					<%-- review_re_lev 값이 0보다 크면 답글이므로 들여쓰기 후 이미지 추가 --%>
					<c:if test="${review.review_re_lev > 0 }">
						<%-- 반복문을 통해 board_re_lev 값 만큼 공백 추가 --%>
						<c:forEach var="i" begin="1" end="${review.review_re_lev }">
							&nbsp;&nbsp;
						</c:forEach>
						<%-- 답글 제목 앞에 이미지 추가 --%>
      			     <img src="img/reply.png">	
					</c:if>
					<%-- =============================================================== --%>
					<a href="ReviewDetail.bo?review_code=${review.review_code }&pageNum=${pageNum }">
						${review.review_subject }
					</a>
				</td>
				<td>${review.member_id }</td>
				<td>				
					<fmt:formatDate value="${review.review_date }" pattern="yy-MM-dd"/>
				</td>
				<td>${review.review_readcount }</td>
			</tr>
		</c:forEach>
	</table>
	</section>
	<section id="buttonArea">
		<form action="ReviewList.bo">
			<input type="text" name="keyword">
			<input type="submit" value="검색">
			&nbsp;&nbsp;
		
			<input type="button" value="글쓰기" onclick="location.href='ReviewWriteForm.bo'" />
	</section>
	<section id="pageList">			
		<c:choose>
			<c:when test="${pageNum > 1}">
				<input type="button" value="이전" onclick="location.href='ReviewList.bo?pageNum=${pageNum - 1}'">
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
					<a href="ReviewList.bo?pageNum=${i }">${i }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<!-- 현재 페이지 번호(pageNum)가 총 페이지 수보다 작을 때만 [다음] 링크 동작 -->
		<c:choose>
			<c:when test="${pageNum < pageInfo.maxPage}">
				<input type="button" value="다음" onclick="location.href='ReviewList.bo?pageNum=${pageNum + 1}'">
			</c:when>
			<c:otherwise>
				<input type="button" value="다음">
			</c:otherwise>
		</c:choose>
	</section>
		  <!-- Footer-->
   <footer class="py-5 bg-dark">
      <div class="container">
         <p class="m-0 text-center text-white">Copyright &copy; DangDangEat 2023</p>
      </div>
   </footer>
    </body>
</html>