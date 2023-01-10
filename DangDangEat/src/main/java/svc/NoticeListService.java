package svc;

import java.sql.Connection;
import java.util.List;

import dao.NoticeDAO;
import db.JdbcUtil;
import vo.NoticeBean;

public class NoticeListService {

		public List<NoticeBean> getNoticeList(String keyword, int startRow, int listLimit) {
						
			List<NoticeBean> noticeList = null;
			
			Connection con = JdbcUtil.getConnection();
			
			NoticeDAO dao = NoticeDAO.getInstance();
			
			dao.setConnection(con);
			
			noticeList = dao.selectNoticeList(keyword, startRow, listLimit);
			
			JdbcUtil.close(con);
			
			return noticeList;
		}

		// 목록 갯수 조회 
		public int getNoticeListCount(String keyword) {
			int listCount = 0;
			
			Connection con = JdbcUtil.getConnection();
			
			NoticeDAO dao = NoticeDAO.getInstance();
			
			dao.setConnection(con);
			
			// NoticeDAO 객체의 selectNoticeListCount() 메서드를 호출하여 글목록 갯수 조회 작업 수행
			// => 파라미터 : 검색어     리턴타입 : int(listCount)
			listCount = dao.selectNoticeListCount(keyword);
			
			// 공통작업-4. Connection 객체 반환하기
			JdbcUtil.close(con);
			
			return listCount;
		}
		
	}