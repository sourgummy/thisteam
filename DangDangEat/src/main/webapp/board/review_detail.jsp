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
	
	        <form action="Comment.bo">
	      <section id="CommentAria">				
					<thead>										
						<tr>
							<th colspan="3"
								style="background-color: #eeeeeee; text-align: center;">댓글</th>
						</tr>
					</thead>
					 <%-- for(CommentBean comment : commentList) {} --%>
											
		            
					<td><textarea type ="text" class="form-control"
								placeholder="댓글을 입력하세요." name="comment_content" maxlength="8000">${param.comment_date }</textarea></td>
						</td>
		        
				</table>
				</section>
				<section id="commandList">
				<input type="submit" class="btn" value="댓글입력">
				<input type="hidden" name="comment_code" value="${param.comment_code }" >
		        <input type="hidden" name="review_code" value="${param.review_code }" >
		        <input type="hidden" name="member_id" value="${param.member_id }" >
	            </section>
		
			</form>
	
  