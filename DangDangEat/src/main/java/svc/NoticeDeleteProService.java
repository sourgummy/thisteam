package svc;

import java.sql.Connection;

import dao.NoticeDAO;
import db.JdbcUtil;

public class NoticeDeleteProService {


	// 글 삭제 가능 여부(= 패스워드 일치 여부) 판별 요청 수행할 isNoticeWriter() 메서드 정의
	// => 파라미터 : 글번호, 패스워드    리턴타입 : boolean(isNoticeWriter)
	public boolean isNoticeWriter(int notice_code) {
		boolean isNoticeWriter = false;
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();
		
		// 공통작업-2. BoardDAO 객체 가져오기
		NoticeDAO dao = NoticeDAO.getInstance();
		
		// 공통작업-3. BoardDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);
		
		// NoticeDAO 의 isNoticeWriter() 메서드를 호출하여 패스워드 확인 작업 수행
		// => 파라미터 : 글번호, 패스워드    리턴타입 : boolean(isNoticeWriter)
		isNoticeWriter = dao.isNoticeWriter(notice_code);
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isNoticeWriter;
	}
	
	
	
	public boolean removeNotice(int notice_code) {
		System.out.println("NoticeDeleteProService - removeNotice()");
		
		boolean isDeleteSuccess = false;

		Connection con = JdbcUtil.getConnection();

		NoticeDAO dao = NoticeDAO.getInstance();

		dao.setConnection(con);

		int deleteCount = dao.deleteNotice(notice_code);
		
		if(deleteCount > 0) {
			JdbcUtil.commit(con);
			isDeleteSuccess = true;
		} else {
			JdbcUtil.rollback(con);
		}
		
		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isDeleteSuccess;
	}

}
