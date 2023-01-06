package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;

import svc.SearchExistCouponService;
import vo.ActionForward;

public class SearchExistMemberCouponAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		String sId = null;
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
		
		try {
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println(couponList);

			
		} catch (IOException e) {

			e.printStackTrace();
		}
//		forward = new ActionForward();
//		forward.setPath("coupon_select_ajax.jsp");
//		forward.setRedirect(false);
		return forward;
	}

}
