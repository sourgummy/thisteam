package action;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ReviewDetailService;
import vo.ActionForward;
import vo.CommentBean;
import vo.ReviewBean;

public class ReviewDetailAction implements Action {
	

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("ReviewDetailAction");
		
		ActionForward forward = null;
		
		// 상세정보 조회에 필요한 글번호 가져오기
		int review_code = Integer.parseInt(request.getParameter("review_code"));
//		System.out.println("review_code = " + review_code);
		// => pageNum 파라미터는 현재 작업에서 실제로 활용되는 데이터가 아니므로
		//    다음 페이지 포워딩 시 URL 또는 request 객체에 함께 전달하기만 하면 된다!
		// => 또한, Dispatch 방식으로 포워딩 시 URL 이 유지되므로 파라미터값 가져오기 불필요
		
		// ReviewDetailService 인스턴스 생성 후 getReview() 메서드 호출하여 게시물 조회 요청
		// => 파라미터 : 글번호, 조회수 증가 여부(true)    리턴타입 : ReviewBean(review)
		ReviewDetailService service = new ReviewDetailService();
		ReviewBean review = service.getReview(review_code, true);
//		System.out.println(review);
		
		
		// 댓글
		CommentBean comment = new CommentBean();
		
		// 파리미터 값을 가져온다.
		String comment_content = request.getParameter("comment_content");
        		
		comment.setComment_content(comment_content);
	
		
		// 뷰페이지로 데이터 전달을 위해 request 객체에 저장
		request.setAttribute("review", review);
		request.setAttribute("comment", comment);
		
		forward = new ActionForward();
		forward.setPath("board/review_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
	
}