package svc;

import java.sql.Connection;

import dao.CommentDAO;
import db.JdbcUtil;
import vo.CommentBean;

// Action 클래스로부터 작업 요청을 받아 DAO 클래스와 상호작용을 통해
// 실제 비즈니스 로직(DB 작업)을 수행하는 클래스
// 또한, DB 작업 수행 후 결과 판별을 통해 트랜잭션 처리(commit or rollback)도 수행
public class CommentWriteProService {
	
	public boolean registComment(CommentBean comment) {
		System.out.println("CommentWriteProService - registComment()");
		
		boolean isWriteSuccess = false;
		
		Connection con = JdbcUtil.getConnection();
		
		CommentDAO dao = CommentDAO.getInstance();
		
		dao.setConnection(con);		
		
		int insertCount = dao.insertCommentReview(comment);
		

					if(insertCount > 0) { // 성공 시
						// INSERT 작업 성공했을 경우의 트랜잭션 처리(commit) 을 위해
						// JdbcUtil 클래스의 commit() 메서드를 호출하여 commit 작업 수행
						// => 파라미터 : Connection 객체
						JdbcUtil.commit(con);
						
						// 작업 처리 결과를 성공으로 표시하여 리턴하기 위해 isWriteSuccess 를 true 로 변경
						isWriteSuccess = true;
					} else { // 실패 시
						// INSERT 작업 실패했을 경우의 트랜잭션 처리(rollback) 을 위해
						// JdbcUtil 클래스의 rollback() 메서드를 호출하여 rollback 작업 수행
						JdbcUtil.rollback(con);
						// isWriteSuccess 기본값이 false 이므로 변경 생략
					}
					
					// 7. Connection Pool 로부터 가져온 Connection 자원 반환(공통)
					// => 주의! DAO 객체 내에서 Connection 객체를 반환하지 않도록 해야한다!
					JdbcUtil.close(con);
					
					// 8. 작업 요청 처리 결과 리턴
					return isWriteSuccess; // NoticeWriteProAction 으로 리턴
				}
				
			}