package action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.ProductSelectService;
import vo.ActionForward;
import vo.ProductBean;

public class MainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		
		
		ProductSelectService service = new ProductSelectService();
		List<ProductBean> productList  = service.getNewProduct(5);

		System.out.println("productList: "+ productList);
		
		request.setAttribute("productList", productList);
		
		
		ActionForward forward = new ActionForward();
		forward.setPath("main/main.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}
