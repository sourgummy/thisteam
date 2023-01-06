package svc;

import java.sql.Connection;

import dao.ReviewDAO;
import db.JdbcUtil;
import vo.ReviewBean;

public class ReviewReplyProService {

	// 글쓰기 작업 요청
	public boolean registReplyReview(ReviewBean review) {
		boolean isWriteSuccess = false;
		
		Connection con = JdbcUtil.getConnection();
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		dao.setConnection(con);
		
		int insertCount = dao.insertReplyReview(review);
		
		// 작업 처리 결과에 따른 트랜잭션 처리
		if(insertCount > 0) { // 성공 시
			JdbcUtil.commit(con);
			isWriteSuccess = true;
		} else { // 실패 시
			JdbcUtil.rollback(con);
		}
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isWriteSuccess; // ReviewReplyProAction 으로 리턴
	}

}
