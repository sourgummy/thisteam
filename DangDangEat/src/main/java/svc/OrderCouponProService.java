package svc;

import java.sql.Connection;

import dao.OrderDAO;
import db.JdbcUtil;

public class OrderCouponProService {
	
	// 쿠폰코드를 이용하여 할인금액을 계산하는 메서드
	public int getCouponDiscountAmount(int cart_code, String cp_code) {
		int couponDiscounAmount = 0;
		
		Connection con = JdbcUtil.getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);
		
		couponDiscounAmount = dao.getCouponDiscountAmount(cart_code, cp_code);
		
		if(couponDiscounAmount > 0 ) {
			JdbcUtil.commit(con);
		} else {
			JdbcUtil.rollback(con);
		}
		
		return couponDiscounAmount;
	}

}
