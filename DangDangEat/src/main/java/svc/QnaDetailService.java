package svc;

import java.sql.Connection;

import dao.QnaDAO;
import db.JdbcUtil;
import vo.QnaBean;

public class QnaDetailService {
	// 글 상세정보 조회
	public QnaBean getQna(int qna_code) {
		QnaBean qna = null;
		
		Connection con = JdbcUtil.getConnection();
		
		QnaDAO dao = QnaDAO.getInstance();
		
		dao.setConnection(con);
		
		// QnaDAO 의 selectQna() 메서드 호출하여 게시물 상세 정보 조회 작업 수행
		// => 파라미터 : 글번호    리턴타입 : QnaBean(qna)
		qna = dao.selectQna(qna_code);
				
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return qna;
	}

}