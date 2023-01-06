package vo;

public class paymentsBean {
	// 결제 정보를 저장하는 paymentsBean
	
	private int pay_number; // 최종주문번호
	private int order_code; // 주문번호(orders 테이블용)
	private int pay_amount; // 주문금액
	
	public int getPay_number() {
		return pay_number;
	}
	public void setPay_number(int pay_number) {
		this.pay_number = pay_number;
	}
	public int getOrder_code() {
		return order_code;
	}
	public void setOrder_code(int order_code) {
		this.order_code = order_code;
	}
	public int getPay_amount() {
		return pay_amount;
	}
	public void setPay_amount(int pay_amount) {
		this.pay_amount = pay_amount;
	}
	
	@Override
	public String toString() {
		return "paymentsBean [pay_number=" + pay_number + ", order_code=" + order_code + ", pay_amount=" + pay_amount
				+ "]";
	}

}
