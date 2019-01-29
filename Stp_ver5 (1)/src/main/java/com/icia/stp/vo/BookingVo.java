package com.icia.stp.vo;

import java.sql.Date;

public class BookingVo {
	private String booking_id;
	private String parking_id;
	private String user_id;
	private Date entrance_date;
	private int entrance_time;
	private Date exit_date;
	private int exit_time;
	private int area_able;
	private int payment_flag;
	private int payment_id;
	private int parking_time;
	private int price;
	
	private MeetyouallParkVo parking;

	public BookingVo() {
		super();
	}

	public BookingVo(String booking_id, String parking_id, String user_id, Date entrance_date, int entrance_time,
			Date exit_date, int exit_time, int area_able, int payment_flag, int payment_id, int parking_time, int price,
			MeetyouallParkVo parking) {
		super();
		this.booking_id = booking_id;
		this.parking_id = parking_id;
		this.user_id = user_id;
		this.entrance_date = entrance_date;
		this.entrance_time = entrance_time;
		this.exit_date = exit_date;
		this.exit_time = exit_time;
		this.area_able = area_able;
		this.payment_flag = payment_flag;
		this.payment_id = payment_id;
		this.parking_time = parking_time;
		this.price = price;
		this.parking = parking;
	}

	@Override
	public String toString() {
		return "BookingVo [booking_id=" + booking_id + ", parking_id=" + parking_id + ", user_id=" + user_id
				+ ", entrance_date=" + entrance_date + ", entrance_time=" + entrance_time + ", exit_date=" + exit_date
				+ ", exit_time=" + exit_time + ", area_able=" + area_able + ", payment_flag=" + payment_flag
				+ ", payment_id=" + payment_id + ", parking_time=" + parking_time + ", price=" + price + ", parking="
				+ parking + "]";
	}

	public String getBooking_id() {
		return booking_id;
	}

	public void setBooking_id(String booking_id) {
		this.booking_id = booking_id;
	}

	public String getParking_id() {
		return parking_id;
	}

	public void setParking_id(String parking_id) {
		this.parking_id = parking_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Date getEntrance_date() {
		return entrance_date;
	}

	public void setEntrance_date(Date entrance_date) {
		this.entrance_date = entrance_date;
	}

	public int getEntrance_time() {
		return entrance_time;
	}

	public void setEntrance_time(int entrance_time) {
		this.entrance_time = entrance_time;
	}

	public Date getExit_date() {
		return exit_date;
	}

	public void setExit_date(Date exit_date) {
		this.exit_date = exit_date;
	}

	public int getExit_time() {
		return exit_time;
	}

	public void setExit_time(int exit_time) {
		this.exit_time = exit_time;
	}

	public int getArea_able() {
		return area_able;
	}

	public void setArea_able(int area_able) {
		this.area_able = area_able;
	}

	public int getPayment_flag() {
		return payment_flag;
	}

	public void setPayment_flag(int payment_flag) {
		this.payment_flag = payment_flag;
	}

	public int getPayment_id() {
		return payment_id;
	}

	public void setPayment_id(int payment_id) {
		this.payment_id = payment_id;
	}

	public int getParking_time() {
		return parking_time;
	}

	public void setParking_time(int parking_time) {
		this.parking_time = parking_time;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public MeetyouallParkVo getParking() {
		return parking;
	}

	public void setParking(MeetyouallParkVo parking) {
		this.parking = parking;
	}


	
	
}
