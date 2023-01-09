package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;

import svc.SearchExistCouponService;
import vo.ActionForward;

public class SearchExistMemberCouponAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		String sId = null;
		boolean isMypage =false ;
		
		if(request.getParameter("isMypage") != null) {
			//마이페이지에서 호출 시에 이동 경로 다름!
		     isMypage = Boolean.valueOf(request.getParameter("isMypage"));

		}
		 response.setCharacterEncoding("UTF-8");
		HttpSession session =  request.getSession(false);
		// TODO: sId삭제
		if(session != null) {
			sId = (String)session.getAttribute("sId");
		}
		
		System.out.println("sId : "+sId);
	
		SearchExistCouponService service = new SearchExistCouponService();
		JSONArray couponList = service.selectMemberCoupon(sId);
		System.out.println("couponList: " + couponList);
		if(isMypage) {//마이페이지에서 호출 된 경우 
			System.out.println(this.getClass()+ "   isMypage: "+ isMypage);
			
			request.setAttribute("couponList", couponList);
			
			forward = new ActionForward();
			forward.setPath("member/mypage_couponAjax.jsp");
			forward.setRedirect(false);
			
		}else {// 쿠폰페이지에서 호출 된 경우 
			
			try {
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println(couponList);
	
				
			} catch (IOException e) {
	
				e.printStackTrace();
			}
		}

		return forward;
	}

}
