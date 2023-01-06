package svc;

import java.sql.Connection;

import dao.ReviewDAO;
import db.JdbcUtil;
import vo.ReviewBean;

public class ReviewModifyProService {
	// 글 수정 가능 여부(= 패스워드 일치 여부) 판별 요청 수행할 isReviewWriter() 메서드 정의
	// => 파라미터 : ReviewBean 객체(review)    리턴타입 : boolean(isReviewWriter)
	public boolean isReviewWriter(ReviewBean review) {
		boolean isReviewWriter = false;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		
		// 공통작업-2. ReviewDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. ReviewDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// ReviewDAO 의 isReviewWriter() 메서드를 호출하여 패스워드 확인 작업 수행
		// => 파라미터 : 글번호, 패스워드    리턴타입 : boolean(isReviewWriter)
		isReviewWriter = dao.isReviewWriter(review.getReview_code(), review.getReview_pass());
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isReviewWriter;
	}

	// 글 수정 작업 요청
	// => 파라미터 : ReviewBean 객체    리턴타입 : boolean(isModifySuccess)
	public boolean modifyReview(ReviewBean review) {
		boolean isModifySuccess = false;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		
		// 공통작업-2. ReviewDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. ReviewDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// ReviewDAO 의 updateReview() 메서드를 호출하여 글 수정 작업 수행
		// => 파라미터 : RevieewBean 객체(review)    리턴타입 : int(updateCount)
		int updateCount = dao.updateReview(review);
		
		// 글 수정 결과 판별 -> 성공 시 commit, 실패 시 rollback
		if(updateCount > 0) {
			JdbcUtil.commit(con);
			isModifySuccess = true;
		} else {
			JdbcUtil.rollback(con);
		}
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isModifySuccess;
	}
}
