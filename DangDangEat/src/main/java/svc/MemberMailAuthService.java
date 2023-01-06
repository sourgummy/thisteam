package svc;

import java.sql.Connection;

import dao.MemberDAO;
import db.JdbcUtil;
import vo.AuthBean;

public class MemberMailAuthService {

	public boolean mailauth(AuthBean auth) {
		System.out.println("MemberMailAuthService");
		boolean isSuccess = false;
		
		
		// 공통작업-1. Connection 객체 가져오기
		Connection con = JdbcUtil.getConnection();

		// 공통작업-2. MemberDAO 객체 가져오기
		MemberDAO dao = MemberDAO.getInstance();

		// 공통작업-3. MemberDAO 객체에 Connection 객체 전달하기
		dao.setConnection(con);

		// MemberDAO 객체의 insertAuth() 메서드를 호출하여 인증정보추가 요청
		// => 파라미터 : MemberBean 객체   리턴타입 : int(insertCount)
		int insertCount = dao.insertAuth(auth);

		// 작업 처리 결과에 따른 트랜잭션 처리
		if(insertCount > 0) { // 성공 시
			System.out.println("성공");
			JdbcUtil.commit(con);
			isSuccess = true;
		} else { // 실패 시
			System.out.println("실패");
			JdbcUtil.rollback(con);
		}

		// 공통작업-4. Connection 객체 반환하기
		JdbcUtil.close(con);
		
		return isSuccess;
	}

}
