package svc;

import java.sql.Connection;
import java.util.List;

import dao.OrderDAO;
import db.JdbcUtil;
import vo.AdminOrderListBean;
import vo.paymentsBean;

public class AdminOrderListService {

	// 관리자 > 주문관리 페이지를 위한 리스트 조회하는 메서드ㄴ

	public List<AdminOrderListBean> getAdminOrderList() {
		List<AdminOrderListBean> adminOrderList = null;
		
		Connection con = JdbcUtil.getConnection();
		OrderDAO dao = OrderDAO.getInstance();
		dao.setConnection(con);
		
		adminOrderList = dao.getAdminOrderList();
		System.out.println("서비스로 넘어온 주문금액 " + adminOrderList);
		
		return adminOrderList;
	}

}
