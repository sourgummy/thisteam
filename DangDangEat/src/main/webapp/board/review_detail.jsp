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
	
	   
	#articleForm {
		width: 500px;
		height: 550px;
		border: 1px solid #D3D3D3;
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
	
	#articleContentArea {
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
	
	#CommentAria {
	text-align: center; 
	border: 1px solid #dddddd
	
	
	}
</style>


</head>
<body>
	
		<!-- Login, Join 링크 표시 영역 -->
		<jsp:include page="/inc/top.jsp"></jsp:include>
	
	<!-- 게시판 상세내용 보기 -->
	<section id="articleForm">
		<h2>리뷰 내용</h2>
		<section id="basicInfoArea">
			<table border="1">
			<tr><th width="70">제 목</th><td colspan="3" >${review.review_subject }</td></tr>
			<tr>
				<th width="70">작성자</th><td>${review.member_id }</td>
				<th width="70">작성일</th>
				<td><fmt:formatDate value="${review.review_date }" pattern="yy-MM-dd" /></td>
			</tr>
			<tr>
				<th width="70">첨부파일</th>
				<td>
					<a href="upload/${review.review_real_file }" download="${review.review_file }">
						${review.review_file }
					</a>
				</td>
				<th width="70">조회수</th>
				<td>${review.review_readcount }</td>
			</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${review.review_content }
		</section>
	</section>
	<section id="commandList">
		<input type="button" value="답변" onclick="location.href='ReviewReplyForm.bo?review_code=${param.review_code}&pageNum=${param.pageNum }'">
		<input type="button" value="수정" onclick="location.href='ReviewModifyForm.bo?review_code=${param.review_code}&pageNum=${param.pageNum }'">
		<input type="button" value="삭제" onclick="location.href='ReviewDeleteForm.bo?review_code=${param.review_code}&pageNum=${param.pageNum }'">
		<input type="button" value="목록" onclick="location.href='ReviewList.bo?pageNum=${param.pageNum}'">
	</section>
	
	 <!-- 댓글 부분 -->
	<div id="comment">
	<table border="1" bordercolor="lightgray">
	<!-- 댓글 목록 -->	
			<%-- for(CommentBean comment : commentList) {} --%>
		<c:forEach var="comment" items="${commentList }">
			<tr>
				<!-- 아이디, 작성날짜 -->
					
						<td><tr><th width="70">작성자</th>${comment.member_id}<br></tr>
						<tr><th width="70">날짜</th>${comment.comment_date}</tr></td>
					
				
				<!-- 본문내용 -->
				<td width="550">
					<div class="text_wrapper">
						${comment.comment_content}
					</div>
				</td>
				<!-- 버튼 -->
				<td width="100">
					<div id="btn" style="text-align:center;">
			   	  <c:if test="${not empty sessionScope.sId and sessionScope.sId eq 'admin'}">					
						<a href="#">[수정]</a><br>	
						<a href="#">[삭제]</a>
					</c:if>		
					</div>
				</td>
			</tr>
			
		</c:forEach>
			
			<!-- 로그인 했을 경우만 댓글 작성가능 -->
			<c:if test="${not empty sessionScope.sId and sessionScope.sId eq 'admin'}">
			<tr bgcolor="#F5F5F5">
			
				<input type="hidden" name="review_code" value="${comment.review_code}">
				<input type="hidden" name="member_id" value="${sessionScope.sessionID}">
				<!-- 아이디-->
				<td width="150">
					<div>
						${sessionScope.sessionID}
					</div>
				</td>
				<!-- 본문 작성-->
				<td width="550">
					<div>
						<textarea name="comment_content" rows="4" cols="70" ></textarea>
					</div>
				</td>
				<!-- 댓글 등록 버튼 -->
		
				<td width="100">
					<div id="btn" style="text-align:center;">
						<input type="submit" value="등록">&nbsp;&nbsp;	
					</div>
				</td>			
			</form>
			</tr>
			
			</c:if>
			
	
		</table>
	</div>

</body>
</html>
  