package com.icia.stp.vo;

import java.sql.Date;

public class ReplyVo {
	private int reply_num;
	private String reply_id;
	private String reply_content;
	private String reply_bNum;
	private Date reply_date;
	
	public ReplyVo() {
	
	}

	public ReplyVo(int reply_num, String reply_id, String reply_content, String reply_bNum, Date reply_date) {
		super();
		this.reply_num = reply_num;
		this.reply_id = reply_id;
		this.reply_content = reply_content;
		this.reply_bNum = reply_bNum;
		this.reply_date = reply_date;
	}

	public int getReply_num() {
		return reply_num;
	}

	public void setReply_num(int reply_num) {
		this.reply_num = reply_num;
	}

	public String getReply_id() {
		return reply_id;
	}

	public void setReply_id(String reply_id) {
		this.reply_id = reply_id;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public String getReply_bNum() {
		return reply_bNum;
	}

	public void setReply_bNum(String reply_bNum) {
		this.reply_bNum = reply_bNum;
	}

	public Date getReply_date() {
		return reply_date;
	}

	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}

	
}
