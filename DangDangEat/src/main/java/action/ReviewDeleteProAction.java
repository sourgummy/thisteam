package action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReviewDeleteProService;
import svc.ReviewDetailService;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewDeleteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		// 글번호, 패스워드 파라미터 가져오기
		int review_code = Integer.parseInt(request.getParameter("review_code"));
		String review_pass = request.getParameter("review_pass");
		System.out.println(review_code + ", " + review_pass);
		System.out.println(request.getParameter("pageNum"));
		
		try {
			ReviewDeleteProService service = new ReviewDeleteProService();
			boolean isReviewWriter = service.isReviewWriter(review_code, review_pass);
			System.out.println("isReviewWriter : " + isReviewWriter);
			
			// 만약, 게시물 삭제 권한이 없는 경우(= 패스워드 틀림)
			// 자바스크립트 사용하여 "삭제 권한이 없습니다!" 출력 후 이전페이지로 돌아가기
			// 아니면, 삭제 작업 요청 수행
			if(!isReviewWriter) { // 삭제 권한 없음
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('삭제 권한이 없습니다!')");
				out.println("history.back()");
				out.println("</script>");
			} else { // 삭제 권한 있음
				// ReviewDetailService 객체의 getReview() 메서드 호출하여 삭제할 파일명 조회
				// => 파라미터 : 글번호, 조회수 증가 여부(false) 리턴타입 : ReviewBean(review)
				ReviewDetailService service2 = new ReviewDetailService();
				ReviewBean review = service2.getReview(review_code, false);
				// => 주의! 레코드 삭제 전 정보 조회 먼저 수행해야한다!
				
				boolean isDeleteSuccess = service.removeReview(review_code);
				
				// 삭제 결과를 판별하여 실패 시 자바스크립트 오류 메세지 출력 및 이전페이지로 이동하고
				// 성공 시 ActionForward 객체를 통해 "ReviewList.bo" 페이지로 포워딩(Redirect)
				// (=> URL 에 페이지 번호를 붙여서 요청)
				if(!isDeleteSuccess) { // 삭제 실패 시 
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('삭제 실패!')");
					out.println("history.back()");
					out.println("</script>");
				} else { // 삭제 성공 시
					String uploadPath = "upload"; // 업로드 가상 디렉토리(이클립스)
					String realPath = request.getServletContext().getRealPath(uploadPath);
					
					System.out.println("ReviewBean : " + review);
					System.out.println("realPath : " + realPath);
					
					// 업로드 된 실제 파일 삭제
					File f = new File(realPath, review.getReview_real_file());
					
					// 해당 디렉토리 및 파일 존재 여부 판별
					if(f.exists()) { // 존재할 경우
						// File 객체의 delete() 메서드를 호출하여 해당 파일 삭제
						f.delete();
					}
					
					forward = new ActionForward();
					forward.setPath("ReviewList.bo?pageNum=" + request.getParameter("pageNum"));
					forward.setRedirect(true);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}