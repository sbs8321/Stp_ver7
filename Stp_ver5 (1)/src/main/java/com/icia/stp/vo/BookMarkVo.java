package com.icia.stp.vo;

import java.sql.Date;

public class BookMarkVo {

	private String email;
	private String prkplceno;
	private String prkplcenm;
	private String lnmadr;
	private String parkimg;
	private int prkcmprt;
	@Override
	public String toString() {
		return "BookMarkVo [email=" + email + ", prkplceno=" + prkplceno + ", prkplcenm=" + prkplcenm + ", lnmadr="
				+ lnmadr + ", parkimg=" + parkimg + ", prkcmprt=" + prkcmprt + ", day=" + day + "]";
	}
	private Date day;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPrkplceno() {
		return prkplceno;
	}
	public void setPrkplceno(String prkplceno) {
		this.prkplceno = prkplceno;
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
	public String getParkimg() {
		return parkimg;
	}
	public void setParkimg(String parkimg) {
		this.parkimg = parkimg;
	}
	public int getPrkcmprt() {
		return prkcmprt;
	}
	public void setPrkcmprt(int prkcmprt) {
		this.prkcmprt = prkcmprt;
	}
	public Date getDay() {
		return day;
	}
	public void setDay(Date day) {
		this.day = day;
	}
	
}
