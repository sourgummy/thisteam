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
	#insertForm {
		margin: auto;
		width: 500px;
		text-align: center;
	}
	#commentViewAria {
	margin: auto;
	text-align: center; 
	border: 1px solid #dddddd		
	}
		input[type=button], input[type=submit] {
	    font-family:"GmarketSansMedium" ;
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
	
	<div class="clear"></div>
			
				<div class="clear"></div>
			
			<div id="commentViewArea">	
				<!-- insertForm 영역(댓글 작성 영역) - 세션 아이디 존재 시에만 표시 -->
					<c:if test="${not empty sessionScope.sId and sessionScope.sId eq 'admin'}">
					<div id="insertForm">
						<form action="CommentWritePro.bo" method="post">
							<!-- 글번호, 게시판타입, 페이지번호를 함께 전달 -->
							<input type="hidden" name="review_code" value=${param.review_code }>
							<input type="hidden" name="pageNum" value=${param.pageNum }>
							<input type="hidden" name="comment_code" value=${param.comment_code }>
							<textarea rows="3" cols="50" name="comment_content" id="replyTextarea"></textarea> 
							<input type="submit" value="등록" id="replySubmit">
						</form>
					    </div>
						</c:if>			
				
				<!-- 댓글 표시 영역 -->
				  <section id="commentContentArea">
					 <%-- for(CommentBean comment : commentList) {} --%>
		             <c:forEach var="comment" items="${commentList }">
		           
		             <input type="hidden" name="comment_code" value=${param.comment_code }>
		             <th width="70">admin</th><td>${comment.member_id }</td>
					 <td><fmt:formatDate value="${comment.comment_date }" pattern="yy-MM-dd" /></td></tr>
					 <tr>	               
				     <td>${comment.comment_content }</td>
					 <img src="img/delete.png" width="10px" height="10px"></section>
					 </c:forEach>
				</div>							
			</div>