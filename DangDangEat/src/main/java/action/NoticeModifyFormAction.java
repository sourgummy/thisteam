package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.NoticeDetailService;
import vo.ActionForward;
import vo.NoticeBean;

public class NoticeModifyFormAction implements Action {

	
		@Override
		public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
			ActionForward forward = null;
			
			int notice_code = Integer.parseInt(request.getParameter("notice_code"));
//			System.out.println(notice_code);
			
			// 글 상세정보 조회 작업 요청
			// => 주의! NoticeModifyFormService 클래스는 생성하지 않는다! (중복이므로 불필요)
			// => 파라미터 : 글번호, 조회수 증가 여부(false)   리턴타입 : NoticeBean(notice)
			NoticeDetailService service = new NoticeDetailService();
			NoticeBean notice = service.getNotice(notice_code, false);
//			System.out.println(notice);
			
			// 뷰페이지로 데이터 전달을 위해 request 객체에 저장
			request.setAttribute("notice", notice);
			
			// ActionForward 객체를 통해 notice_modify.jsp 페이지 포워딩 설정
			// => URL 유지 및 request 객체 유지를 위해 Dispatch 방식 포워딩
			forward = new ActionForward();
			forward.setPath("board/notice_modify.jsp");
			forward.setRedirect(false);
			
			return forward;
		}

	}