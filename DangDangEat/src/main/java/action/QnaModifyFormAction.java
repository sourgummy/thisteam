package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.QnaDetailService;
import vo.ActionForward;
import vo.QnaBean;

public class QnaModifyFormAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		int qna_code = Integer.parseInt(request.getParameter("qna_code"));
//		System.out.println(qna_code);
		
		// QnaDetailService 클래스의 인스턴스 생성 및 getQna() 메서드를 호출하여
		// 글 상세정보 조회 작업 요청
		// => 주의! QnaModifyFormService 클래스는 생성하지 않는다! (중복이므로 불필요)
		// => 파라미터 : 글번호, 조회수 증가 여부(false)   리턴타입 : QnaBean(qna)
		QnaDetailService service = new QnaDetailService();
		QnaBean qna = service.getQna(qna_code);
//		System.out.println(qna);
		
		// 뷰페이지로 데이터 전달을 위해 request 객체에 저장
		request.setAttribute("qna", qna);
		
		// ActionForward 객체를 통해 review_modify.jsp 페이지 포워딩 설정
		// => URL 유지 및 request 객체 유지를 위해 Dispatch 방식 포워딩
		forward = new ActionForward();
		forward.setPath("board/qna_modify.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}