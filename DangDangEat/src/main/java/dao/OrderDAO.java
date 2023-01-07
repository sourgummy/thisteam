package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import db.JdbcUtil;
import vo.AdminOrderListBean;
import vo.CartBean;
import vo.MemberBean;
import vo.Order_productBean;
import vo.OrdersBean;
import vo.cart_productBean;
import vo.paymentsBean;

public class OrderDAO {
	// OrderDAO 인스턴스 생성
	private OrderDAO () {}; // 기본 생성자
	
	private static OrderDAO instance = new OrderDAO(); // 인스턴스
	
	public static OrderDAO getInstance() {
		return instance;
	}
	
	private Connection con;
	
	public void setConnection(Connection con) {
		this.con = con;
	}

	//-----------------------------------------------------
	// 주문 회원 정보 가져오는 메서드
	
	public List<MemberBean> selectMemberList(String id) {
		
		List<MemberBean> memberList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM member WHERE member_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			memberList = new ArrayList<MemberBean>();
			
			if(rs.next()) {
				MemberBean member = new MemberBean();
				member.setMember_id(rs.getString("member_id"));
				member.setMember_name(rs.getString("member_name"));
				member.setMember_mobile(rs.getString("member_mobile"));
				member.setMember_addr1(rs.getString("member_addr1"));
				member.setMember_addr2(rs.getString("member_addr2"));
				member.setMember_postcode(rs.getString("member_postcode"));
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("orderDAO - selectMemberList 구문오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return memberList;
	} // selectMemberList
	
	//  단일상품 주문시 - 장바구니에 있는 상품정보 가져오는 메서드
	public List<cart_productBean> getViewCartList(String id, int proCode, int cartCode) {
		List<cart_productBean> viewCartList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM cart_product_view WHERE cart_code = ? "
					+ "AND member_id = ? AND pro_code = ?";
				
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cartCode);
			pstmt.setString(2, id);
			pstmt.setInt(3, proCode);
			rs = pstmt.executeQuery();
			
			viewCartList = new ArrayList<cart_productBean>();
			
			 if(rs.next()) {
				 cart_productBean cart = new cart_productBean();
				 cart.setCart_code(rs.getInt("cart_code"));
				 cart.setMember_id(rs.getString("member_id"));
				 cart.setPro_code(rs.getInt("pro_code"));
				 cart.setCart_amount(rs.getInt("cart_amount"));
				 cart.setPro_name(rs.getString("pro_name"));
				 cart.setPro_brand(rs.getString("pro_brand"));
				 cart.setPro_price(rs.getInt("pro_price"));
				 cart.setPro_real_thumb(rs.getString("pro_real_thumb"));
				 viewCartList.add(cart);
			 
			 }
		} catch (SQLException e) {
			System.out.println("OrderDAO - getViewCartList() 구문오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return viewCartList;
	}// getViewCartList

	// 카트번호가 중복되는 상품이 있을 경우 삭제하는 메서드
	public int deleteCartOrder() {
		int deleteCount = 0;
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		
		try {
			String sql = "DELETE FROM order_product WHERE order_code IN "
					+ "	(select order_code from orders where order_status = 0)";
			pstmt = con.prepareStatement(sql);
			deleteCount = pstmt.executeUpdate();
			
			System.out.println("pstmt : " + pstmt);
			
			if( deleteCount >= 0) {
				
				sql = "DELETE FROM orders WHERE order_status = 0 ";
				pstmt2 = con.prepareStatement(sql);
				pstmt2.executeUpdate();
				
				System.out.println("pstmt2 : " + pstmt2);
			}
			
		} catch (SQLException e) {
			System.out.println("SQL 구문오류 - orderDAO delteCartOrder");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(pstmt2);
			JdbcUtil.close(pstmt);
		}
		return deleteCount;
	} // deleteCartOrder
	

	//  주문자 정보 & 주문상품 등록 구문 (orders & order_product table)
	public int insertOrder(OrdersBean order, Order_productBean order_product, int cart_code){
		System.out.println("orderdao = insertorders()");
		int insertCount = 0;
		
		// 주문번호
		int order_code = 0; 
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		
		ResultSet rs = null;
		
			try {
				
				// 주문테이블 인덱스(order_code) 자동 증가
				String sql = "SELECT MAX(order_code) FROM orders";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					order_code = rs.getInt(1)+1;
				}
				
				System.out.println("주문번호 증가했으면 늘어나는 = " + order_code);
				
					// 주문 테이블에 주문정보 입력
					sql = "INSERT INTO orders VALUES(?,?,?,?,?,?,?,?,0,now())";
					pstmt2 = con.prepareStatement(sql);
					pstmt2.setInt(1, order_code);
					pstmt2.setString(2, order.getMember_id());
					pstmt2.setString(3, order.getOrder_name());
					pstmt2.setString(4, order.getOrder_postcode());
					pstmt2.setString(5, order.getOrder_address1());
					pstmt2.setString(6, order.getOrder_address2());
					pstmt2.setString(7, order.getOrder_mobile());
					pstmt2.setString(8, order.getOrder_comment());
					
					insertCount = pstmt2.executeUpdate();
					
					if(insertCount > 0) {
						// 주문 테이블 입력 성공 후 실행되는 주문 상품 정보 입력
						sql = "INSERT INTO order_product (order_code, pro_code, order_stock, cart_code) "
								+ "SELECT o.order_code, c.pro_code, c.cart_amount, c.cart_code "
								+ "FROM orders o NATURAL JOIN cart c "
								+ "WHERE c.cart_code = ? AND o.order_code = ? ";
								
						pstmt3 = con.prepareStatement(sql);
						pstmt3.setInt(1, cart_code);
						pstmt3.setInt(2, order_code);
						insertCount = pstmt3.executeUpdate();
						System.out.println("주문 테이블에 정보 입력하고 order_product 실행하는자리");
					}
			} catch (SQLException e) {
				System.out.println("orderDAO - insertOrders 구문 오류");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
				JdbcUtil.close(pstmt2);
				JdbcUtil.close(pstmt3);
			}
		return insertCount;
	}// insertOrders
	
	
	// 결제 시 필요한 주문자 정보 가져오는 메서드
	public List<OrdersBean> getOrderMemberList(String id, int cart_code) {
		
		List<OrdersBean> orderMemberList = null;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "SELECT * FROM orders WHERE order_code = "
					+ "(SELECT order_code FROM order_product "
					+ "WHERE cart_code = ? ) AND member_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cart_code);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			
			orderMemberList = new ArrayList<OrdersBean>();
			if(rs.next()) {
				OrdersBean order = new OrdersBean();
					order.setOrder_code(rs.getInt("order_code"));
					order.setMember_id(rs.getString("member_id"));
					order.setOrder_name(rs.getString("order_name"));
					order.setOrder_postcode(rs.getString("order_postcode"));
					order.setOrder_address1(rs.getString("order_address1"));
					order.setOrder_address2(rs.getString("order_address2"));
					order.setOrder_mobile(rs.getString("order_mobile"));
					order.setOrder_comment(rs.getString("order_comment"));
					order.setOrder_status(rs.getInt("order_status"));
					order.setOrder_date(rs.getDate("order_date"));
					orderMemberList.add(order);
					
				System.out.println("잘넘어오는지 확인하는 주문자 정보 " + orderMemberList);
			}
			
		} catch (SQLException e) {
			System.out.println("orderDAO - getOrderMemberList 구문오류");
			e.printStackTrace();
		} finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		
		return orderMemberList;
	} // getOrderMemberList
	
	// 결제 시 필요한 주문상품 정보 가져오는 메서드
		public List<cart_productBean> getOrderProductList(String id, int cart_code) {
			
			List<cart_productBean> orderProductList = null;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM cart_product_view WHERE member_id = ? AND cart_code = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, cart_code);
				rs = pstmt.executeQuery();
				
				orderProductList = new ArrayList<cart_productBean>();
				if(rs.next()) {
					cart_productBean product = new cart_productBean();
					product.setCart_code(rs.getInt("cart_code"));
					product.setMember_id(rs.getString("member_id"));
					product.setPro_code(rs.getInt("pro_code"));
					product.setCart_amount(rs.getInt("cart_amount"));
					product.setPro_name(rs.getString("pro_name"));
					product.setPro_brand(rs.getString("pro_brand"));
					product.setPro_price(rs.getInt("pro_price"));
					product.setPro_real_thumb(rs.getString("pro_real_thumb"));
					orderProductList.add(product);
					System.out.println("잘넘어오는지 확인하는 주문자 정보 " + orderProductList);
				}
				
			} catch (SQLException e) {
				System.out.println("orderDAO - selectMemberList 구문오류");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
			
			return orderProductList;
		} // getOrderProductList

		// orders 테이블 중복상품 확인 메서드
		public int selectCartOrder(int cart_code) {
			int selectCount = 0;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM order_product WHERE cart_code = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cart_code);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					selectCount++;
				}
			} catch (SQLException e) {
				System.out.println("orderDAO - SelectCartOrder()");
				e.printStackTrace();
			}
			
			return selectCount;
		} // selectCartOrder

		// 결제완료시 orders 테이블의 주문상태를 결제완료로 변경하는 메서드
		public int orderStatusUpdate(String id, int order_code) {
			int orderStatusUpdateCount = 0;
			
			PreparedStatement pstmt = null;
			
			try {
				String sql = "UPDATE orders SET order_status = 1 "
						+ "WHERE order_code = ? AND member_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, order_code);
				pstmt.setString(2, id);
				orderStatusUpdateCount = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 - orderDAO > orderStatusUpdate");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
			}
			return orderStatusUpdateCount;
		} // orderStatusUpdate

		// 결제완료시 cart 테이블의 정보를 업데이트하는 메서드
		public int cartInfoUpdate(String id, int cart_code) {
			int cartInfoUpdateCount = 0;
			
			PreparedStatement pstmt = null;
			
			try {
				String sql = "UPDATE cart SET cart_ischecked = 0 "
						+ "WHERE cart_code = ? "
						+ "AND member_id = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cart_code);
				pstmt.setString(2, id);
				cartInfoUpdateCount = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("SQL 구문오류 - orderDAO > cartInfoUpdate()");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
			}
			return cartInfoUpdateCount;
		}// cartInfoDelete

		// 결제 완료 시 payments 테이블에 정보 넣는 구문
		public int paymentInsertPro(paymentsBean payments) {
			int paymentInsertCount = 0;
			
			PreparedStatement pstmt = null;
		
			try {
				String sql = "INSERT INTO payments VALUES(?,?,?,'10OFF',0)";
				pstmt= con.prepareStatement(sql);
				pstmt.setInt(1, payments.getPay_number());
				pstmt.setInt(2, payments.getOrder_code());
				pstmt.setInt(3, payments.getPay_amount());
				paymentInsertCount = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 - orderDAO paymentInsertPro()");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
			}
				
			return paymentInsertCount;
		} // paymentInsert
		
		// 23-01-06 추가사항
		// 결제 완료시 주문상품 수량 업데이트 하는 구문
		public int productQtyUpdate(int order_code, int pro_code) {
			int productQtyUpdateCount = 0;
			
			PreparedStatement pstmt = null;
			
			try {
				String sql = "UPDATE product SET pro_qty = "
						+ "((SELECT pro_qty FROM (SELECT pro_qty, pro_code FROM product) AS pro_update_sample WHERE pro_code = ?) "
						+ "- (SELECT order_stock FROM order_product WHERE order_code = ?)) "
						+ "WHERE pro_code = (SELECT pro_code FROM order_product WHERE order_code = ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, pro_code);
				pstmt.setInt(2, order_code);
				pstmt.setInt(3, order_code);
				productQtyUpdateCount =  pstmt.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("orderdao - productQtyUpdate()");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
			}
			
			return productQtyUpdateCount;
		}// productQtyUpdate

		
		// 관리자 주문관리 페이지를 위한 리스트 생성하는 메서드
		public List<AdminOrderListBean> getAdminOrderList() {
			List<AdminOrderListBean> adminOrderList = null;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM admin_order_list_view";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();

				adminOrderList = new ArrayList<AdminOrderListBean>();
				
				while(rs.next()) {
					AdminOrderListBean adminOrderBean = new AdminOrderListBean();
					adminOrderBean.setOrder_code(rs.getInt("order_code"));
					adminOrderBean.setMember_id(rs.getString("member_id"));
					adminOrderBean.setOrder_name(rs.getString("order_name"));
					adminOrderBean.setOrder_postcode(rs.getString("order_postcode"));
					adminOrderBean.setOrder_address1(rs.getString("order_address1"));
					adminOrderBean.setOrder_address2(rs.getString("order_address2"));
					adminOrderBean.setOrder_mobile(rs.getString("order_mobile"));
					adminOrderBean.setOrder_comment(rs.getString("order_comment"));
					adminOrderBean.setOrder_status(rs.getInt("order_status"));
					adminOrderBean.setOrder_date(rs.getDate("order_date"));
					adminOrderBean.setPay_number(rs.getInt("pay_number"));
					adminOrderBean.setPay_amount(rs.getInt("pay_amount"));
					
					adminOrderList.add(adminOrderBean);
				}
				System.out.println("orderDAO 에서 나오는 " + adminOrderList);
			} catch (SQLException e) {
				System.out.println("SQL 구문 오류 - orderDAO > getAdminOrderList");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(pstmt);
				JdbcUtil.close(rs);
			}
			
			return adminOrderList;
		} //getAdminOrderList

		// 23/01/07 추가
		// 결제 정보 가져오는 메서드 (주문서 확인용)
		public List<paymentsBean> getOrderPaymentsList(int payNumber, int orderCode) {
			
			List<paymentsBean> orderPaymentsList = null;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM payments WHERE pay_number = ? AND order_code = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, payNumber);
				pstmt.setInt(2, orderCode);
				rs = pstmt.executeQuery();
				
				orderPaymentsList = new ArrayList<paymentsBean>();
				if(rs.next()) {
					paymentsBean payments = new paymentsBean();
					payments.setPay_number(rs.getInt("pay_number"));
					payments.setOrder_code(rs.getInt("order_code"));
					payments.setPay_amount(rs.getInt("pay_amount"));
					payments.setCp_code(rs.getString("cp_code"));
					payments.setCp_discount_amount(rs.getInt("cp_discount_amount"));
					orderPaymentsList.add(payments);
					System.out.println("ORDERDAO - 잘넘어오는지 확인하는 결제 정보 " + orderPaymentsList);
				}
				
			} catch (SQLException e) {
				System.out.println("orderDAO - selectMemberList 구문오류");
				e.printStackTrace();
			} finally {
				JdbcUtil.close(rs);
				JdbcUtil.close(pstmt);
			}
			
			return orderPaymentsList;
		} // getOrderProductList
		

	
	
}// OrderDAO
