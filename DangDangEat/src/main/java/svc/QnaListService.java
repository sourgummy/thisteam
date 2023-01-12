package svc;

import java.sql.Connection;
import java.util.List;

import dao.QnaDAO;
import db.JdbcUtil;
import vo.QnaBean;

public class QnaListService {

	public List<QnaBean> getQnaList(String keyword, int startRow, int listLimit) {		
		System.out.println("QnaListService - getQnaList()");
		
		List<QnaBean> qnaList = null;
		
		Connection con = JdbcUtil.getConnection();
		
		QnaDAO dao = QnaDAO.getInstance();
		
		dao.setConnection(con);
		
		qnaList = dao.selectQnaList(keyword, startRow, listLimit);
		
		JdbcUtil.commit(con);
		
		JdbcUtil.close(con);
		
		return qnaList;
	}
	

	public int getQnaListCount(String keyword) {
		System.out.println("QnaListService - getQnaListCount()");

		int listCount = 0;
		
		Connection con = JdbcUtil.getConnection();
		
		QnaDAO dao = QnaDAO.getInstance();
		
		dao.setConnection(con);
		
		listCount = dao.selectQnaListCount(keyword);
		
		JdbcUtil.commit(con);
		
		JdbcUtil.close(con);
		
		return listCount;
	}

	// 23/01/12 Qna 목록 전체 조회 구문
	public List<QnaBean> getRealQnaList() {
		List<QnaBean> realQnaList = null;
		
		Connection con = JdbcUtil.getConnection();
		QnaDAO dao = QnaDAO.getInstance();
		dao.setConnection(con);
		
		realQnaList = dao.AllQnaList();
		System.out.println("QnaListService로 넘어온 RealQnaList" + realQnaList);
		JdbcUtil.commit(con);
		JdbcUtil.close(con);
		
		return realQnaList;
	}
	
	// 23/01/12 Qna 목록 전체 조회 구문
		public List<QnaBean> getRealQnaList2(int startRow, int listLimit) {
			List<QnaBean> realQnaList = null;
			
			Connection con = JdbcUtil.getConnection();
			QnaDAO dao = QnaDAO.getInstance();
			dao.setConnection(con);
			
			realQnaList = dao.AllQnaList2(startRow, listLimit);
			System.out.println("QnaListService로 넘어온 RealQnaList2" + realQnaList);
			JdbcUtil.commit(con);
			JdbcUtil.close(con);
			
			return realQnaList;
		}
	
}
