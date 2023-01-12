package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.MemberMonthlyJoinService;
import svc.ReviewCountMonthlyService;
import svc.OrderMonthlyService;
import svc.WishProductListService;
import vo.ActionForward;
import vo.WishProductBean;

public class AdminTotalMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		WishProductListService service = new WishProductListService();
		List<WishProductBean> wishproduct = service.getWishProductList();
		request.setAttribute("wishproduct", wishproduct);
		
		MemberMonthlyJoinService service2 = new MemberMonthlyJoinService();
		int joinCount = service2.getMemberMonthlyJoin();
		request.setAttribute("joinCount", joinCount);
		
		OrderMonthlyService service3 = new OrderMonthlyService();
		int orderCount = service3.getOrderMonthly();
		request.setAttribute("orderCount", orderCount);

		int salesTotal = service3.getSalesTotalMonthly();
		request.setAttribute("salesTotal", salesTotal);
		
		ReviewCountMonthlyService service4 = new ReviewCountMonthlyService();
		int reviewCount = service4.getReviewCountMonthly();
		request.setAttribute("reviewCount", reviewCount);
		
		
		forward = new ActionForward();
		forward.setPath("admin/admin_main.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
