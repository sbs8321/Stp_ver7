package com.icia.stp.vo;

import java.sql.Date;

public class PointVo {
	private int pnum; // 포인트 번호, 프라이머리키
	private String user_email; // member 테이블의 id
	private int division; // 포인트 내역 구분
	private String booking_id;
	private int payment_id; //결제 내역 가져올 때 사용	
	private Date use_date;//사용 날짜
	
	
	private BookingVo booking;	//조인할 때 사용하기 위해서 선언


	public PointVo() {
		super();
	}


	public PointVo(int pnum, String user_email, int division, String booking_id, int payment_id, Date use_date,
			BookingVo booking) {
		super();
		this.pnum = pnum;
		this.user_email = user_email;
		this.division = division;
		this.booking_id = booking_id;
		this.payment_id = payment_id;
		this.use_date = use_date;
		this.booking = booking;
	}


	@Override
	public String toString() {
		return "PointVo [pnum=" + pnum + ", user_email=" + user_email + ", division=" + division + ", booking_id="
				+ booking_id + ", payment_id=" + payment_id + ", use_date=" + use_date + ", booking=" + booking + "]";
	}


	public int getPnum() {
		return pnum;
	}


	public void setPnum(int pnum) {
		this.pnum = pnum;
	}


	public String getUser_email() {
		return user_email;
	}


	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}


	public int getDivision() {
		return division;
	}


	public void setDivision(int division) {
		this.division = division;
	}


	public String getBooking_id() {
		return booking_id;
	}


	public void setBooking_id(String booking_id) {
		this.booking_id = booking_id;
	}


	public int getPayment_id() {
		return payment_id;
	}


	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}


	public Date getUse_date() {
		return use_date;
	}


	public void setUse_date(Date use_date) {
		this.use_date = use_date;
	}


	public BookingVo getBooking() {
		return booking;
	}


	public void setBooking(BookingVo booking) {
		this.booking = booking;
	}
	
	
	
	
	
	
}