package svc;

import java.sql.Connection;

import dao.NoticeDAO;
import db.JdbcUtil;
import vo.NoticeBean;

public class NoticeDetailService {
	// 글 상세정보 조회
	// => 단, 글번호와 함께 조회수 증가 여부를 파라미터로 전달
	public NoticeBean getNotice(int notice_code, boolean isUpdateReadcount) {
		NoticeBean notice = null;
		
		Connection con = JdbcUtil.getConnection();
		
		NoticeDAO dao = NoticeDAO.getInstance();
		
		dao.setConnection(con);
		
		notice = dao.selectNotice(notice_code);
		
		if(notice != null && isUpdateReadcount) {
			int updateCount = dao.updateReadcount(notice_code);
			
			if(updateCount > 0) {
				JdbcUtil.commit(con);
				
				// 만약, 조회수 증가 전 조회 작업을 먼저 수행했을 경우
				// 수동으로 NoticeBean 객체의 조회수를 1만큼 증가시켜야함
				notice.setNotice_readcount(notice.getNotice_readcount() + 1);
			}
		}
		
		JdbcUtil.close(con);
		
		return notice;
	}

}