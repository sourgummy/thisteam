package svc;

import java.sql.Connection;
import java.util.List;

import dao.ReviewDAO;
import db.JdbcUtil;
import vo.ReviewBean;

public class ReviewListService {

	// 게시물 목록 조회 - getReviewList()
	// => 파라미터 : 검색어, 시작행번호, 목록갯수   리턴타입 : List<ReviewBean>(reviewList)
	public List<ReviewBean> getReviewList(String keyword, int startRow, int listLimit) {
		List<ReviewBean> reviewList = null;
		
		Connection con = JdbcUtil.getConnection();
		
		ReviewDAO dao = ReviewDAO.getInstance();
		
		dao.setConnection(con);
		
		// ReviewDAO 객체의 selectBoardList() 메서드를 호출하여 글목록 조회 작업 수행
		// => 파라미터 : 검색어, 시작행번호, 목록갯수   리턴타입 : List<ReviewBean>(reviewList)
		reviewList = dao.selectReviewList(keyword, startRow, listLimit);
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		// 조회 결과 리턴
		return reviewList;
	}

	// 목록 갯수 조회 - getReviewListCount()
	// => 파라미터 : 검색어   리턴타입 : int(listCount)
	public int getReviewListCount(String keyword) {
		int listCount = 0;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		
		// 공통작업-2. ReviewDAO 객체 가져오기
		ReviewDAO dao = ReviewDAO.getInstance();
		
		// 공통작업-3. ReviewDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// ReviewDAO 객체의 selectBoardListCount() 메서드를 호출하여 글목록 갯수 조회 작업 수행
		// => 파라미터 : 검색어     리턴타입 : int(listCount)
		listCount = dao.selectReviewListCount(keyword);
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return listCount;
	}
	
}