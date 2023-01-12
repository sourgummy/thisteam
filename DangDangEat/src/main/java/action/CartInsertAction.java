package action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.CartInsertService;
import vo.ActionForward;
import vo.CartBean;

public class CartInsertAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		ActionForward forward = null;
		
		try {
			// 상품코드
			int pro_code = Integer.parseInt(request.getParameter("pro_code"));
			HttpSession session = request.getSession();
			// 아이디
			String id = (String)session.getAttribute("sId");
			// 수량
			int cart_amount = Integer.parseInt(request.getParameter("amount"));
			// 경로
			String path = request.getParameter("path");
			
			// 로그인 회원만 가능
			if(id == null || id.equals(null)) {
//				System.out.println(id);
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('로그인을 먼저 해주세요')");
				out.println("history.back()");
				out.println("</script>");
				
			} else { // 회원
				
				// 아이디, 제품코드, 수량 받아오기
				CartBean cart = new CartBean();
				cart.setMember_id(id);
				cart.setPro_code(pro_code);
				if(cart_amount == 1) {
					cart.setCart_amount(1);
				} else {
					cart.setCart_amount(cart_amount);
				}
				cart.setCart_ischecked(1);
				CartInsertService service = new CartInsertService();
				int insertCount = service.insertCart(cart);
				System.out.println(insertCount);
				if(insertCount == 1) { // 장바구니 추가 성공
					if(path.equals("product_detail")) { // 경로 상품상세
						// ajax로 구현
					} else if(path.equals("wishlist")) { // 경로 위시리스트
						forward = new ActionForward();
						forward.setPath("WishList.ct");
						forward.setRedirect(true);
					} else if(path.equals("product_list")) { // 경로 상품 목록
						forward = new ActionForward();
						forward.setPath("ProductList.pd");
						forward.setRedirect(true);
					}
				} else if(insertCount == 2){ // 이미 있음
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('장바구니에 있는 상품입니다!')");
					out.println("history.back()");
					out.println("</script>");
					
					return forward;
				} else { // 추가 실패
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('장바구니 추가 실패!')");
					out.println("history.back()");
					out.println("</script>");
					
					return forward;
				}
			}
		
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return forward;
	}

}
