package com.icia.stp.vo;

import java.sql.Date;

public class PaymentListVo {
	private int payment_balance;
	private int payment_state; // 0이면 포인트 결제, 1이면 페이 결제
	private String user_email;
	private Date entrance_date;
	private int payment_id;
	private String prkplcenm;
	private String lnmadr;
	public PaymentListVo() {
		super();
	}
	public PaymentListVo(int payment_balance, int payment_state, String user_email, Date entrance_date, int payment_id,
			String prkplcenm, String lnmadr) {
		super();
		this.payment_balance = payment_balance;
		this.payment_state = payment_state;
		this.user_email = user_email;
		this.entrance_date = entrance_date;
		this.payment_id = payment_id;
		this.prkplcenm = prkplcenm;
		this.lnmadr = lnmadr;
	}
	@Override
	public String toString() {
		return "PaymentListVo [payment_balance=" + payment_balance + ", payment_state=" + payment_state
				+ ", user_email=" + user_email + ", entrance_date=" + entrance_date + ", payment_id=" + payment_id
				+ ", prkplcenm=" + prkplcenm + ", lnmadr=" + lnmadr + "]";
	}
	public int getPayment_balance() {
		return payment_balance;
	}
	public void setPayment_balance(int payment_balance) {
		this.payment_balance = payment_balance;
	}
	public int getPayment_state() {
		return payment_state;
	}
	public void setPayment_state(int payment_state) {
		this.payment_state = payment_state;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public Date getEntrance_date() {
		return entrance_date;
	}
	public void setEntrance_date(Date entrance_date) {
		this.entrance_date = entrance_date;
	}
	public int getPayment_id() {
		return payment_id;
	}
	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}
	public String getPrkplcenm() {
		return prkplcenm;
	}
	public void setPrkplcenm(String prkplcenm) {
		this.prkplcenm = prkplcenm;
	}
	public String getLnmadr() {
		return lnmadr;
	}
	public void setLnmadr(String lnmadr) {
		this.lnmadr = lnmadr;
	}
	
	
	
	
	
}
