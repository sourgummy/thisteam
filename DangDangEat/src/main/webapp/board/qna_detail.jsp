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
		width: 1224px;
		height: 550px;
		border: 1px solid #D3D3D3;
		margin: auto;
	}
	
	h2 {
		font-family:"GmarketSansMedium" ;
		text-align: center;
	}
	
	table {
		border-collapse: collapse; 
	 	width: 1224px;
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
		margin-bottom: 30px;
		background: #D3D3D3;
		margin-top: 20px;
		height: 350px;
		text-align: center;
		overflow: auto;
		white-space: pre-line;
	}
	
	#commandList {
		margin: auto;
		margin-bottom: 30px;
		width: 500px;
		text-align: center;
	}
	
	input[type=button], input[type=submit] {
	    font-family:"GmarketSansMedium" ;
	}
</style>
</head>
		
<!-- 챗봇 관련 코드 -->
<script>
  (function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
//   ChannelIO('boot', {
//     pluginKey: "1340eb3c-ddf6-43c5-a497-6a91281156bc", //please fill with your plugin key
//     memberId: "YOUR_USER_ID", //fill with user id
//     profile: {
//       "name": "YOUR_USER_NAME", //fill with user name
//       "mobileNumber": "YOUR_USER_MOBILE_NUMBER", //fill with user phone number
//       "CUSTOM_VALUE_1": "VALUE_1", //any other custom meta data
//       "CUSTOM_VALUE_2": "VALUE_2"
//     }
//   });
  ChannelIO('boot', {
     pluginKey: '1340eb3c-ddf6-43c5-a497-6a91281156bc'
      }, function onBoot(error, user) {
           if (error) {
                console.error(error);
           } else {
             console.log('boot success', user)
           }
   });
  
</script>
<!-- 챗봇 관련 코드 -->
  	
<body>
	
		<!-- Login, Join 링크 표시 영역 -->
		<jsp:include page="../inc/top.jsp"></jsp:include>
	
	<div class="container">
	<!-- 게시판 상세내용 보기 -->
<!-- 		<h2>글 상세내용 보기</h2> -->
	<section>
		<section>
			<table class="table">
			<tr><th width="70">제 목</th><td colspan="3" >${qna.qna_subject }</td></tr>
			<tr>
				<th width="70">작성자</th><td>${qna.member_id }</td>
				<th width="70">작성일</th>
				<td><fmt:formatDate value="${qna.qna_date }" pattern="yy-MM-dd HH:mm:SS" /></td>
			</tr>
			<tr>
				<th width="70">첨부파일</th>
				<td colspan="3">
					<a href="upload/${qna.qna_real_file }" download="${qna.qna_file }">
						${qna.qna_file }
					</a>
				</td>				
			</tr>
			</table>
		</section>
		<section id="articleContentArea">
			${qna.qna_content }
		</section>
	</section>
			</div>
	<section id="commandList">
		<input type="button" value="답변" onclick="location.href='QnaReplyForm.bo?qna_code=${param.qna_code}&pageNum=${param.pageNum }'">
		<input type="button" value="수정" onclick="location.href='QnaModifyForm.bo?qna_code=${param.qna_code}&pageNum=${param.pageNum }'">
		<input type="button" value="삭제" onclick="location.href='QnaDeleteForm.bo?qna_code=${param.qna_code}&pageNum=${param.pageNum }'">
		<input type="button" value="목록" onclick="location.href='QnaList.bo?pageNum=${param.pageNum}'">
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