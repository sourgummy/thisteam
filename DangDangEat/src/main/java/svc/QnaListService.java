package svc;

import java.sql.Connection;
import java.util.List;

import dao.QnaDAO;
import db.JdbcUtil;
import vo.QnaBean;

public class QnaListService {

	// 게시물 목록 조회 - getQnaList()
	// => 파라미터 : 검색어, 시작행번호, 목록갯수   리턴타입 : List<QnaBean>(QnaList)
	public List<QnaBean> getQnaList(String keyword, int startRow, int listLimit) {		
		System.out.println("QnaListService - getQnaList()");
		
		List<QnaBean> qnaList = null;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		
		// 공통작업-2. QnaDAO 객체 가져오기
		QnaDAO dao = QnaDAO.getInstance();
		
		// 공통작업-3. QnaDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// QnaDAO 객체의 selectQnaList() 메서드를 호출하여 글목록 조회 작업 수행
		// => 파라미터 : 검색어, 시작행번호, 목록갯수   리턴타입 : List<QnaBean>(QnaList)
		qnaList = dao.selectQnaList(keyword, startRow, listLimit);
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		// 조회 결과 리턴
		return qnaList;
	}
	

	public int getQnaListCount(String keyword) {
		System.out.println("QnaListService - getQnaListCount()");

		int listCount = 0;
		
		Connection con = JdbcUtil.getConnection();
		
		QnaDAO dao = QnaDAO.getInstance();
		
		dao.setConnection(con);
		
		listCount = dao.selectQnaListCount(keyword);
		
		JdbcUtil.close(con);
		
		return listCount;
	}


}
