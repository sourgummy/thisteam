package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import svc.CouponListService;
import vo.ActionForward;

public class CouponListAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		CouponListService service = new CouponListService();
		
		System.out.println(this.getClass());
		JSONArray CouponList =  service.SelectCouponList();
		System.out.println(CouponList +" - "+this.getClass());
		request.setAttribute("CouponList", CouponList);
		
		forward = new ActionForward();
		forward.setPath("order/admin_couponList.jsp");//
		forward.setRedirect(false);
		return forward;
	}

}
