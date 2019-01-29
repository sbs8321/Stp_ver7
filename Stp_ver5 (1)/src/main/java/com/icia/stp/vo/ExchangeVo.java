package com.icia.stp.vo;

import java.sql.Date;

//환전 테이블
public class ExchangeVo {
	private int exchange_id;
	private String owner_id;
	private int balance;
	private Date apply_date;
	
	private OwnerVo owner;

	public ExchangeVo() {
		super();
	}

	public ExchangeVo(int exchange_id, String owner_id, int balance, Date apply_date, OwnerVo owner) {
		super();
		this.exchange_id = exchange_id;
		this.owner_id = owner_id;
		this.balance = balance;
		this.apply_date = apply_date;
		this.owner = owner;
	}

	@Override
	public String toString() {
		return "ExchangeVo [exchange_id=" + exchange_id + ", owner_id=" + owner_id + ", balance=" + balance
				+ ", apply_date=" + apply_date + ", owner=" + owner + "]";
	}

	public int getExchange_id() {
		return exchange_id;
	}

	public void setExchange_id(int exchange_id) {
		this.exchange_id = exchange_id;
	}

	public String getOwner_id() {
		return owner_id;
	}

	public void setOwner_id(String owner_id) {
		this.owner_id = owner_id;
	}

	public int getBalance() {
		return balance;
	}

	public void setBalance(int balance) {
		this.balance = balance;
	}

	public Date getApply_date() {
		return apply_date;
	}

	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}

	public OwnerVo getOwner() {
		return owner;
	}

	public void setOwner(OwnerVo owner) {
		this.owner = owner;
	}
	
}
