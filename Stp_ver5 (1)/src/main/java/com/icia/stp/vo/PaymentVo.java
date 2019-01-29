package com.icia.stp.vo;

public class PaymentVo {
	private int payment_id;
	private int payment_balance;
	private int payment_state; //0이면 포인트 결제, 1이면 페이 결제
	private String user_email;
	private String booking_id;
	
	private BookingVo booking;
	private MeetyouallParkVo parking;
	
	public PaymentVo() {
		super();
	}
	public PaymentVo(int payment_id, int payment_balance, int payment_state, String user_email, String booking_id,
			BookingVo booking, MeetyouallParkVo parking) {
		super();
		this.payment_id = payment_id;
		this.payment_balance = payment_balance;
		this.payment_state = payment_state;
		this.user_email = user_email;
		this.booking_id = booking_id;
		this.booking = booking;
		this.parking = parking;
	}
	@Override
	public String toString() {
		return "PaymentVo [payment_id=" + payment_id + ", payment_balance=" + payment_balance + ", payment_state="
				+ payment_state + ", user_email=" + user_email + ", booking_id=" + booking_id + ", booking=" + booking
				+ ", parking=" + parking + "]";
	}
	public int getPayment_id() {
		return payment_id;
	}
	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
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
	public String getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(String booking_id) {
		this.booking_id = booking_id;
	}
	public BookingVo getBooking() {
		return booking;
	}
	public void setBooking(BookingVo booking) {
		this.booking = booking;
	}
	public MeetyouallParkVo getParking() {
		return parking;
	}
	public void setParking(MeetyouallParkVo parking) {
		this.parking = parking;
	}
	
	

}
