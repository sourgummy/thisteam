package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.QnaDetailService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaDetailAction implements Action {


	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("QnaDetailAction");
		
		ActionForward forward = null;
		
		// 상세정보 조회에 필요한 글번호 가져오기
		int qna_code = Integer.parseInt(request.getParameter("qna_code"));
//		System.out.println("qna_code = " + qna_code);
		// => pageNum 파라미터는 현재 작업에서 실제로 활용되는 데이터가 아니므로
		//    다음 페이지 포워딩 시 URL 또는 request 객체에 함께 전달하기만 하면 된다!
		// => 또한, Dispatch 방식으로 포워딩 시 URL 이 유지되므로 파라미터값 가져오기 불필요
		
		// QnaDetailService 인스턴스 생성 후 getQna() 메서드 호출하여 게시물 조회 요청
		// => 파라미터 : 글번호    리턴타입 : QnaBean(qna)
		QnaDetailService service = new QnaDetailService();
		QnaBean qna = service.getQna(qna_code);
//		System.out.println(qna);
		
		// 뷰페이지로 데이터 전달을 위해 request 객체에 저장
		request.setAttribute("qna", qna);
		
		forward = new ActionForward();
		forward.setPath("board/qna_detail.jsp");
		forward.setRedirect(false);
		
		return forward;
	}
}