package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;
import vo.CommentBean;
import vo.ReviewBean;

// 실제 비즈니스 로직을 수행하는 ReviewDAO 클래스 정의
// => 각 Service 클래스 인스턴스에서 ReviewDAO 인스턴스에 접근 시 고유 데이터가 불필요하므로
//    ReviewDAO 인스턴스는 애플리케이션에서 단 하나만 생성하여 공유해도 된다!
//    따라서, 싱글톤 디자인 패턴을 적용하여 클래스를 정의하면 메모리 낭비를 막을 수 있다!
public class CommentDAO {
	// ------------ 싱글톤 디자인 패턴을 활용한 ReviewDAO 인스턴스 생성 작업 -------------
	// 1. 외부에서 인스턴스 생성이 불가능하도록 생성자를 private 접근제한자로 선언
	// 2. 자신의 클래스 내에서 직접 인스턴스를 생성하여 멤버변수에 저장
	//    => 인스턴스 생성없이 클래스가 메모리에 로딩될 때 함께 로딩되도록 static 변수로 선언
	//    => 외부에서 접근하여 함부로 값을 변경할 수 없도록 private 접근제한자로 선언
	// 3. 생성된 인스턴스를 외부로 리턴하는 Getter 메서드 정의
	//    => 인스턴스 생성없이 클래스가 메모리에 로딩될 때 함께 로딩되도록 static 메서드로 선언
	//    => 누구나 접근 가능하도록 public 접근제한자로 선언
	private CommentDAO() {}
	
	private static CommentDAO instance = new CommentDAO();

	public static CommentDAO getInstance() {
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
	
	
	// 댓글 등록
	public int insertComment(CommentBean comment) {
		System.out.println("commentDAO - insertComment()");
	
	int insertCount = 0;
		
		PreparedStatement pstmt = null, pstmt2 = null;
		ResultSet rs = null;
		
		try {
			int comment_code = 1;
			

			String sql = "SELECT MAX(comment_code) FROM comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // 조회 결과가 있을 경우(= 기존 게시물이 하나라도 존재할 경우)
				// (만약, 게시물이 존재하지 않을 경우 DB 에서 NULL 로 표기, rs.next() 가 false)
				comment_code = rs.getInt(1) + 1; // 기존 게시물 번호 중 가장 큰 번호(= 조회 결과) + 1
			}
			System.out.println("새 글 번호 : " + comment_code);
			// --------------------------------------------------------------------------------
			// 전달받은 데이터(ReviewBean 객체)를 사용하여 INSERT 작업 수행
			// => 참조글번호(review_re_ref)는 새 글 번호와 동일한 번호로 지정
			// => 들여쓰기레벨(review_re_lev)과 순서번호(board_re_seq)는 0으로 지정
			// => INSERT 구문 실행 후 리턴값을 insertCount 변수에 저장
			sql = "INSERT INTO comment VALUES (?,?,?,?,now())";
			pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, comment_code); // 글번호
			pstmt2.setInt(2, comment.getReview_code()); // 작성자
			pstmt2.setString(3, comment.getMember_id());
			pstmt2.setString(4, comment.getComment_content());
			
			insertCount = pstmt2.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("SQL 구문 오류! - insertReview()");
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
	

	
	// 댓글 목록 가져오기
	   public List<CommentBean> selectCommentList(int review_code) {
		
			List<CommentBean> commentList = null;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {								
				
				String sql = "SELECT * FROM comment WHERE review_code LIKE ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, review_code);				
				rs = pstmt.executeQuery();
				
				commentList = new ArrayList<CommentBean>();
				
				while(rs.next())
				 
				{
					CommentBean comment = new CommentBean();
					comment.setComment_code(rs.getInt("comment_code"));
					comment.setReview_code(rs.getInt("review_code"));
					comment.setMember_id(rs.getString("member_id"));
					comment.setComment_content(rs.getString("comment_content"));
					comment.setComment_date(rs.getDate("comment_date"));
					
					commentList.add(comment);
					
				}
					
			} catch (SQLException e) {
				System.out.println("commentDAO - selectCommentList()");
				e.printStackTrace();
			} finally {
				// DB 자원 반환
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
			
			return commentList;
		}
}