package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberEmailUpdateService;
import vo.ActionForward;
import vo.MemberBean;

public class MemberEmailUpdateAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MemberEmailUpdateAction");
		
		ActionForward forward = null;
		
		try {
			// MemberBean 객체 생성 및 파라미터 저장
			MemberBean member = new MemberBean();
			member.setMember_id(request.getParameter("id"));
			member.setMember_email(request.getParameter("email"));		
			System.out.println(member);
			
			// MemberEmailUpdateService 객체 생성 및 memberEmailUpdate() 호출
			MemberEmailUpdateService service = new MemberEmailUpdateService();
			boolean isUpdateSuccess = service.memberEmailUpdate(member);
			
			if(isUpdateSuccess) { // 메일 변경 성공 시
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("이메일이 변경되었습니다.");
				
			} else { // 실패 시
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("이미 사용 중이거나 탈퇴한 회원의 이메일입니다.");
				
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return forward;
	}

}
