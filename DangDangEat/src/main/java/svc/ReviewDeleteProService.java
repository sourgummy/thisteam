package svc;

import java.sql.Connection;

import dao.ReviewDAO;
import db.JdbcUtil;

public class ReviewDeleteProService {

	public boolean isReviewWriter(int review_code, String review_pass) {
		boolean isReviewWriter = false;
		
		Connection con = JdbcUtil.getConnection();
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		dao.setConnection(con);
		
		isReviewWriter = dao.isReviewWriter(review_code, review_pass);
		
		JdbcUtil.close(con);
		
		return isReviewWriter;
	}

	public boolean removeReview(int review_code) {
		boolean isDeleteSuccess = false;
		
		Connection con = JdbcUtil.getConnection();
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		dao.setConnection(con);
		
		int deleteCount = dao.deleteReview(review_code);
		
		if(deleteCount > 0) {
			JdbcUtil.commit(con);
			isDeleteSuccess = true;
		} else {
			JdbcUtil.rollback(con);
		}
		
		JdbcUtil.close(con);
		
		return isDeleteSuccess;
	}

}
