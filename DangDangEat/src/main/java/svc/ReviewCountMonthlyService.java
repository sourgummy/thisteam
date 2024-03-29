package svc;

import java.sql.Connection;

import dao.AdminDAO;
import db.JdbcUtil;

public class ReviewCountMonthlyService {
	
	// 한 달 리뷰 수
	public int getReviewCountMonthly() {
		int reviewCount = 0;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		// 공통작업-2. BoardDAO 객체 가져오기
		AdminDAO dao = AdminDAO.getInstance();
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		reviewCount = dao.getReviewCountMonthly();
		
		// 커밋 처리
		JdbcUtil.commit(con);
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return reviewCount;
	}

}
