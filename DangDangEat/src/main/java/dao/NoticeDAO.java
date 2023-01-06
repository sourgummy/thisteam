package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;
import vo.NoticeBean;

public class NoticeDAO {
	
	private NoticeDAO() {}
	
	private static NoticeDAO instance = new NoticeDAO();

	public static NoticeDAO getInstance() {
		return instance;
	}
	// ----------------------------------------------------------------------------------
	// 데이터베이스 접근에 사용할 Connection 객체를 Service 객체로부터 전달받기 위한
	// Connection 타입 멤버변수 선언 및 Setter 메서드 정의
	private Connection con;

	public void setConnection(Connection con) {
		this.con = con;
	}
	// ----------------------------------------------------------------------------------
	// 글쓰기 작업 수행
	// => Service 로부터 전달받은 NoticeBean 객체를 사용하여 INSERT 작업 수행
	public int insertNotice(NoticeBean notice) {
		System.out.println("NoticeDAO - insertNotice()");
		
		// INSERT 작업 결과를 리턴받아 저장할 변수 선언
		int insertCount = 0;
		
		// 데이터베이스 작업에 필요한 변수 선언
		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;
		
		try {
			int notice_code = 1; // 새 글 번호
			
			String sql = "SELECT MAX(notice_code) FROM notice";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 조회 결과가 있을 경우(= 기존 게시물이 하나라도 존재할 경우)
				// (만약, 게시물이 존재하지 않을 경우 DB 에서 NULL 로 표기, rs.next() 가 false)
				notice_code = rs.getInt(1) + 1; // 기존 게시물 번호 중 가장 큰 번호(= 조회 결과) + 1
			}
			System.out.println("새 글 번호 : " + notice_code);
			// --------------------------------------------------------------------------------
			sql = "INSERT INTO notice VALUES (?,?,?,?,?,now())";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, notice_code); // 글번호
			pstmt2.setString(2, notice.getMember_id()); // 작성자
			pstmt2.setString(3, notice.getNotice_subject()); // 제목
			pstmt2.setString(4, notice.getNotice_content()); // 내용
			pstmt2.setInt(5, 0); 
			
			insertCount = pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - insertNotice()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(pstmt2);
			// 주의! Connection 객체는 Service 클래스가 관리하므로 DAO 에서 반환 금지!
		}
		
		return insertCount; // Service 로 리턴
	}
		
	
	// 글 상세정보 조회
	public NoticeBean selectNotice(int notice_code) {
		NoticeBean notice = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM notice WHERE notice_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice_code);			
			rs = pstmt.executeQuery();
			
			// 조회 결과가 있을 경우
			if(rs.next()) {
				notice = new NoticeBean();				
				notice.setNotice_code(rs.getInt("notice_code"));
				notice.setMember_id(rs.getString("member_id"));
				notice.setNotice_subject(rs.getString("notice_subject"));
				notice.setNotice_content(rs.getString("notice_content"));
				notice.setNotice_readcount(rs.getInt("notice_readcount"));
				notice.setNotice_date(rs.getDate("notice_date"));
//				System.out.println(notice);
			}
			
		} catch (SQLException e) {
			System.out.println("NoticeDAO - selectNotice()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return notice;
	}
	
	// 조회수 증가
	public int updateReadcount(int notice_code) {
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			// 글번호가 일치하는 레코드의 조회수(readcount) 1만큼 증가
			String sql = "UPDATE notice "
								+ "SET notice_readcount=notice_readcount+1 "
								+ "WHERE notice_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice_code);
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("NoticeDAO - updateReadcount()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(pstmt);
		}
		
		return updateCount;
	}
	
	// 글 삭제
	public int deleteNotice(int notice_code) {
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			// 글번호에 해당하는 레코드 삭제
			String sql = "DELETE FROM notice "
								+ "WHERE notice_code=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice_code);
			deleteCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류 - deleteNotice()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(pstmt);
		}
		
		return deleteCount;
	}
	
	// 글 수정
	public int updateNotice(NoticeBean notice) {
		int updateCount = 0;
		
		PreparedStatement pstmt = null;
		
		try {
			String sql = "UPDATE notice"
								+ " SET"
								+ " 	notice_subject = ?"
								+ " 	, notice_content = ?"						
						        + " WHERE"
								+ " 	notice_code = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getNotice_subject());
			pstmt.setString(2, notice.getNotice_content());
			
			updateCount = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("NoticeDAO - updateNotice()");
			e.printStackTrace();
		} finally {
			// DB 자원 반환
			JdbcUtil.close(pstmt);
		}
		
		return updateCount;
	}


// 공지사항 목록 조회
public List<NoticeBean> selectNoticeList(String keyword, int startRow, int listLimit) {
	List<NoticeBean> noticeList = null;
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String sql = "SELECT * FROM notice "
							+ "WHERE notice_subject "
							+ "LIKE ? ORDER BY notice_code DESC LIMIT ?,?";
						
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + keyword + "%");
		pstmt.setInt(2, startRow);
		pstmt.setInt(3, listLimit);
		rs = pstmt.executeQuery();
		
		// 전체 목록 저장할 List 객체 생성
		noticeList = new ArrayList<NoticeBean>();
		
		// 조회 결과가 있을 경우
		while(rs.next()) {
			// NoticeBean 객체(notice) 생성 후 조회 데이터 저장
			NoticeBean notice = new NoticeBean();			
			notice.setNotice_code(rs.getInt("notice_code"));
			notice.setMember_id(rs.getString("member_id"));
			notice.setNotice_subject(rs.getString("notice_subject"));
			notice.setNotice_content(rs.getString("notice_content"));
			notice.setNotice_readcount(rs.getInt("notice_readcount"));
			notice.setNotice_date(rs.getDate("notice_date"));
//			System.out.println(notice);
			
			// 전체 목록 저장하는 List 객체에 1개 게시물 정보가 저장된 NoticeBean 객체 추가
			noticeList.add(notice);
		}
		
	} catch (SQLException e) {
		System.out.println("NoticeDAO - selectNoticeList()");
		e.printStackTrace();
	} finally {
		// DB 자원 반환
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
	}
	
	return noticeList;
}

// 글목록 갯수 조회
public int selectNoticeListCount(String keyword) {
	int listCount = 0;
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String sql = "SELECT COUNT(*) "
							+ "FROM notice "
							+ "WHERE notice_subject LIKE ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, "%" + keyword + "%");
		rs = pstmt.executeQuery();
		
		// 조회 결과가 있을 경우 listCount 변수에 저장
		if(rs.next()) {
			listCount = rs.getInt(1);
		}
		
	} catch (SQLException e) {
		System.out.println("NoticeDAO - selectNoticeListCount()");
		e.printStackTrace();
	} finally {
		// DB 자원 반환
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
	}
	
	return listCount;
  }


public boolean isNoticeWriter(int notice_code) {
	boolean isNoticeWriter = false;
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try {
		String sql = "SELECT * FROM notice "
							+ "WHERE notice_code=?";
	
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, notice_code);
		rs = pstmt.executeQuery();
		
		// 조회 결과가 있을 경우
		if(rs.next()) {
			isNoticeWriter = true;
		}
		
	} catch (SQLException e) {
		System.out.println("NoticeDAO - isNoticeWriter()");
		e.printStackTrace();
	} finally {
		// DB 자원 반환
		JdbcUtil.close(rs);
		JdbcUtil.close(pstmt);
	}
	
	return isNoticeWriter;
}
}