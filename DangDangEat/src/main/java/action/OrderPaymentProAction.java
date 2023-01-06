package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import svc.OrderPaymentService;
import vo.ActionForward;
import vo.paymentsBean;

public class OrderPaymentProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("주문 결제를 진행하는 OrderPaymentProAction");
		ActionForward forward = null;
		
		// 결제 페이지 진행하는 액션 (주문번호 생성)
		
		/*
		 *  1. 입력받은 쿠폰 코드를 가져와서 수식 계산을 하는(구문만 짜두기 연결은 별도)
		 *  
		 *  완료 2. payment(결제) 테이블로 정보를 입력 
		 *  	pay_number : varchar(20)
		 *      order_code : int 
		 *      pay_amount : int 
		 *   
		 *  완료 3. orders 테이블에 order_status = 1로 변경 시키기 
		 *  완료 4. 주문 확인서 페이지로 이동
		 *  완료 5. cart에 있는 상품 cart_ischecked 업데이트 해서 카트 페이지에서 삭제하기 
		 *  
		 *  6. 주문완료한 수량 product 수량에서 (-)변경하기   
		 */
		
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("sId");
		int pro_code = Integer.parseInt(request.getParameter("pro_code"));
		int cart_code = Integer.parseInt(request.getParameter("cart_code"));
		int pro_amount = Integer.parseInt(request.getParameter("pro_amount"));
		int order_code = Integer.parseInt(request.getParameter("order_code"));
		
		System.out.println("상품 코드 잘넘어 옵니까" + pro_code);
		System.out.println("카트 코드 잘넘어 옵니까" + cart_code);
		System.out.println("상품금액 잘넘어 옵니까" + pro_amount);
		System.out.println("주문번호 잘넘어 옵니까" + order_code);
		
		// 주문번호 생성을 위한 구문------------------------------------------
		
			// 현재 날짜 구하기
	        LocalDate now = LocalDate.now();
	        // 포맷 정의
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd00");
	        int formatedNow = Integer.parseInt(now.format(formatter));
	        int pay_number = (formatedNow + order_code);
	        // 결과 출력
	        System.out.println(pay_number);  // 23010500
	        
	     //------------------------------------------------------------------
	        
		paymentsBean payments = new paymentsBean();
		payments.setPay_number(pay_number); // 최종 주문번호 
		payments.setPay_amount(pro_amount); // 결제금액
		payments.setOrder_code(order_code); // orders 테이블 주문번호
		
		OrderPaymentService service = new OrderPaymentService();
		// orders 테이블에 order_status = 1 (결제완료) 로 변환하는 작업
		boolean isOrderStatusUpdate = service.orderStatusUpdate(id, order_code);
		// 결제 정보 생성 구문
		List<paymentsBean> paymentList = service.paymentInsert(payments);
		request.setAttribute("paymentList", paymentList);
		System.out.println("여기까지 넘어왔니 페이먼트 프로 액션" + paymentList);
		
		// 결제완료시 상품 테이블에서 수량변경하는 코드
		int productQtyUpdate = service.productQtyUpdate(order_code, pro_code, cart_code);
		
			try {
				// orders 테이블에 order_status = 1 (결제완료) 로 변환하는 작업
				if(isOrderStatusUpdate) {
				
					// 장바구니 화면에서 제거(cart테이블 cart_ischecked)
					int cartUpdateCount = service.cartInfoUpdate(id, cart_code);
					
					 if(cartUpdateCount > 0) {
						 
						forward = new ActionForward();
						forward.setPath("OrderConfirm.od");
						forward.setRedirect(false);
						
					 } else {
						response.setContentType("text/html; charset=UTF-8");
						PrintWriter out = response.getWriter();
						
						out.println("<script>");
						out.println("alert('장바구니 업데이트 실패')");
						out.println("history.back()");
						out.println("</script>");
					 }
				 
					
				} else {
					response.setContentType("text/html; charset=UTF-8");
//				
					PrintWriter out = response.getWriter();
					
					out.println("<script>");
					out.println("alert('주문상태 업데이트 실패')");
					out.println("history.back()");
					out.println("</script>");
				}
			} catch (IOException e) {
				System.out.println("OrderPaymentProAction 오류 발생");
				e.printStackTrace();
			} finally {
				
			}
		
		
		return forward;
	}

}
