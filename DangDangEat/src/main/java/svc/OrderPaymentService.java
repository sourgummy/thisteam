package svc;

import java.sql.Connection;
import java.util.List;

import dao.OrderDAO;
import db.JdbcUtil;
import vo.paymentsBean;

public class OrderPaymentService {

	// 결제완료시 orders 테이블의 order_status를 결제완료로 변경하는 메서드 (0 > 1)
	public boolean orderStatusUpdate(String id, int order_code) {
		boolean isOrderStatusUpdate = false;
		
		Connection con = JdbcUtil.getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);
		
		int OrderStatusUpdateCount = dao.orderStatusUpdate(id, order_code);
		
		if(OrderStatusUpdateCount > 0 ) {
			JdbcUtil.commit(con);
			isOrderStatusUpdate = true; 
		} else {
			JdbcUtil.rollback(con);
		}
		
		return isOrderStatusUpdate;
	}// orderStatusUpdate

	// 결제 완료 시 장바구니(cart)에 있는 정보 업데이트하는 메서드  
	public int cartInfoUpdate(String id, int cart_code) {
		int cartInfoUpdateCount = 0;
		
		Connection con = JdbcUtil.getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);
		
		cartInfoUpdateCount = dao.cartInfoUpdate(id, cart_code);
		
		if(cartInfoUpdateCount > 0) {
			JdbcUtil.commit(con);
		} else {
			JdbcUtil.rollback(con);
		}
		
		return cartInfoUpdateCount;
		
	} // cartInfoDelete

	// payments 테이블에 정보를 넣는 구문
	public List<paymentsBean> paymentInsert(paymentsBean payments) {
		List<paymentsBean> paymentList = null;
		
		Connection con = JdbcUtil.getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);
		
		paymentList = dao.paymentInsert(payments);
		System.out.println("잘 넘어온 paymentsList" + paymentList);
		
		JdbcUtil.commit(con);
		
		return paymentList;
	}

	// 결제 완료시 주문상품 수량 업데이트 하는 구문
	public int productQtyUpdate(int order_code, int pro_code, int cart_code) {
		int productQtyUpdateCount = 0;
		
		Connection con = JdbcUtil.getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);
		
		productQtyUpdateCount = dao.productQtyUpdate(order_code, pro_code, cart_code);
		
		if(productQtyUpdateCount > 0) {
			JdbcUtil.commit(con);
		} else {
			JdbcUtil.rollback(con);
		}
		
		return productQtyUpdateCount;
	}


	
	
}
