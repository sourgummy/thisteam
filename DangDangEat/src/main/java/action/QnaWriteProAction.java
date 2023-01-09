package action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.QnaWriteProService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("QnaWriteProAction");
		
		ActionForward forward = null;
		
		try {
			String uploadPath = "upload"; // 업로드 가상 디렉토리(이클립스)
			// 업로드 실제 디렉토리(톰캣) 얻어오기
			String realPath = request.getServletContext().getRealPath(uploadPath);
			System.out.println("실제 업로드 경로 : " + realPath);
			// D:\Shared\JSP\workspace_jsp5\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\DangDangEat\ upload
			int fileSize = 1024 * 1024 * 10;
			
			// --------------------------------------------------------------------
			// 게시물 작성자(= 클라이언트)의 IP 주소를 얻어와야 할 경우
			String writerIpAddr = request.getRemoteAddr();
			System.out.println("작성자 IP 주소 : " + writerIpAddr);
			// --------------------------------------------------------------------
			// 파일 업로드 처리(enctype="mutlipart/form-data") 를 위해
			// MultipartRequest 객체 생성 => cos.jar 라이브러리 필요
			MultipartRequest multi = new MultipartRequest(
					request,  // 1) 실제 요청 정보(파라미터)가 포함된 request 객체
					realPath, // 2) 실제 업로드 경로
					fileSize, // 3) 업로드 파일 최대 사이즈
					"UTF-8",  // 4) 한글 파일명 처리 위한 인코딩 방식
					new DefaultFileRenamePolicy() // 5) 중복 파일명을 처리할 객체
			);
			
			QnaBean qna = new QnaBean();
			qna.setMember_id(multi.getParameter("member_id"));
			qna.setQna_pass(multi.getParameter("qna_pass"));
			qna.setQna_subject(multi.getParameter("qna_subject"));
			qna.setQna_content(multi.getParameter("qna_content"));
			qna.setQna_secret(multi.getParameter("qna_secret"));
			
			// 파일명은 getParameter() 로 단순 처리 불가능
			// => 원본 파일명 : getOriginalFileName()
			//    중복 처리된(실제 업로드 되는) 파일명 : getFilesystemName() 
//			System.out.println(multi.getOriginalFileName("qna_file"));
//			System.out.println(multi.getFilesystemName("qna_file"));
			qna.setQna_file(multi.getOriginalFileName("qna_file"));
			qna.setQna_real_file(multi.getFilesystemName("qna_file"));
//			System.out.println(qna);
			
			// -------------------------------------------------------------------------
			// 파라미터명이 다른 복수개의 파일이 전달될 경우 복수개의 파라미터 처리 방법
			// 1) 파일에 대한 파라미터명을 관리하는 객체(Enumeration) 가져오기
//			Enumeration e = multi.getFileNames();
//			// 2) while 문을 사용하여 Enumeration 객체의 hasMoreElements() 메서드가
//			//    true 일 동안(다음 요소가 존재할 동안) 반복
//			while(e.hasMoreElements()) {
//				// 3) nextElement() 메서드를 호출하여 다음 요소(파라미터 이름) 가져오기
//				// => 리턴타입이 Object 이므로 문자열로 변환
//				String fileElement = e.nextElement().toString();
////				System.out.println(fileElement);
//				// 4) 파라미터명에 해당하는 원본 파일명, 실제 파일명 가져오기
//				System.out.println("원본 파일명 : " + multi.getOriginalFileName(fileElement));
//				System.out.println("실제 파일명 : " + multi.getFilesystemName(fileElement));
//			}
			// -------------------------------------------------------------------------
			QnaWriteProService service = new QnaWriteProService();
			boolean isWriteSuccess = service.registQna(qna);
			
			// 글쓰기 요청 처리 결과 판별
			if(!isWriteSuccess) { // 실패 시
				// 업로드 된 실제 파일 삭제
				File f = new File(realPath, qna.getQna_real_file());
				
				// 해당 디렉토리 및 파일 존재 여부 판별
				if(f.exists()) { // 존재할 경우
					// File 객체의 delete() 메서드를 호출하여 해당 파일 삭제
					f.delete();
				}
				
				// 자바스크립트 사용하여 "글쓰기 실패!" 출력 후 이전페이지로 돌아가기
				// => 웹브라우저로 HTML 태그 등을 내보내기(출력) 위한 작업 수행
				//    (자바 클래스 내에서 출력스트림을 활용하여 HTML 태그 출력해야함)
				// => 응답 데이터 생성을 위해 응답 객체인 response 객체 활용
				// 1) 출력할 HTML 형식에 대한 문서 타입(contentType) 설정
				//    => 응답 데이터의 타입으로 HTML 태그가 사용됨을 클라이언트에게 알려줌
				//    => response 객체의 setContentType() 메서드를 호출하여 문서 타입 전달
				//       (jsp 파일 최상단의 page 디렉티브 냉늬 contentType=XXX 항목 활용)
				response.setContentType("text/html; charset=UTF-8");
				
				// 2) 자바 코드를 사용하여 HTML 태그 등을 출력(전송)하려면
				//    java.io.PrintWriter 객체가 필요함(= 출력스트림으로 사용할 객체)
				//    => response 객체의 getWriter() 메서드를 호출하여 얻어올 수 있다!
				PrintWriter out = response.getWriter();
				
				// 3) PrintWriter 객체의 print() 또는 println() 메서드를 호출하여
				//    파라미터로 HTML 태그 등의 코드를 문자열 형태로 전달
				out.println("<script>");
				out.println("alert('글쓰기 실패!')");
				out.println("history.back()");
				out.println("</script>");
				// ActionForward 객체 생성하지 않음!! => null 값 전달
			} else { // 성공 시
				forward = new ActionForward();
				forward.setPath("QnaList.bo");
				forward.setRedirect(true);
			}
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return forward; // BoardFrontController 로 리턴
	}

}