package svc;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import dao.ProductDAO;
import db.JdbcUtil;
import vo.ProductBean;

public class ProductSelectService {
//메인페이지 상품
	public List<ProductBean> getNewProduct(int numberOfProducts) {
		//공통작업
		Connection con = null;
		con = JdbcUtil.getConnection();
		ProductDAO dao =ProductDAO.getInstance();
		dao.setConnection(con);
		
		
		//
		 
		List<ProductBean> productList	= dao.selectNewProduct(numberOfProducts);
		
		JdbcUtil.commit(con);
		
		return productList;
		
	}
	
}
