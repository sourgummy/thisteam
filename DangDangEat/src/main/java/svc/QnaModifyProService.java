package svc;

import java.sql.Connection;

import dao.QnaDAO;
import db.JdbcUtil;
import vo.QnaBean;

public class QnaModifyProService {
	// 글 수정 가능 여부(= 패스워드 일치 여부) 판별 요청 수행할 isQnaWriter() 메서드 정의
	// => 파라미터 : QnaBean 객체(qna)    리턴타입 : boolean(isQnaWriter)
	public boolean isQnaWriter(QnaBean qna) {
		boolean isQnaWriter = false;
		
		Connection con = JdbcUtil.getConnection();
		
		QnaDAO dao = QnaDAO.getInstance();
		
		dao.setConnection(con);
		
		// QnaDAO 의 isQnaWriter() 메서드를 호출하여 패스워드 확인 작업 수행
		// => 파라미터 : 글번호, 패스워드    리턴타입 : boolean(isQnaWriter)
		isQnaWriter = dao.isQnaWriter(qna.getQna_code(), qna.getQna_pass());
		
		JdbcUtil.commit(con);
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isQnaWriter;
	}

	// 글 수정 작업 요청
	// => 파라미터 : QnaBean 객체    리턴타입 : boolean(isModifySuccess)
	public boolean modifyQna(QnaBean qna) {
		boolean isModifySuccess = false;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		
		// 공통작업-2. QnaDAO 객체 가져오기
		QnaDAO dao = QnaDAO.getInstance();
		
		// 공통작업-3. QnaDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// QnaDAO 의 updateQna() 메서드를 호출하여 글 수정 작업 수행
		// => 파라미터 : QnaBean 객체(qna)    리턴타입 : int(updateCount)
		int updateCount = dao.updateQna(qna);
		
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
