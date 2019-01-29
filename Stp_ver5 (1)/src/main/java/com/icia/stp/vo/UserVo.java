package com.icia.stp.vo;

public class UserVo {
	private String email;
	private String password;
	private String name;
	private String phone_front;
	private String phone_mid;
	private String phone_end;
	private String addr1;
	private String addr2;
	private String addr3;
	private int point;
	private int memberType;
	private String authkey = "";
	private int state = 0;
	private int balance = 0; // admin용 계좌

	public UserVo() {
		super();
	}

	public UserVo(String email, String password, String name, String phone_front, String phone_mid, String phone_end,
			String addr1, String addr2, String addr3, int point, int memberType, String authkey, int state,
			int balance) {
		super();
		this.email = email;
		this.password = password;
		this.name = name;
		this.phone_front = phone_front;
		this.phone_mid = phone_mid;
		this.phone_end = phone_end;
		this.addr1 = addr1;
		this.addr2 = addr2;
		this.addr3 = addr3;
		this.point = point;
		this.memberType = memberType;
		this.authkey = authkey;
		this.state = state;
		this.balance = balance;
	}

	@Override
	public String toString() {
		return "UserVo [email=" + email + ", password=" + password + ", name=" + name + ", phone_front=" + phone_front
				+ ", phone_mid=" + phone_mid + ", phone_end=" + phone_end + ", addr1=" + addr1 + ", addr2=" + addr2
				+ ", addr3=" + addr3 + ", point=" + point + ", memberType=" + memberType + ", authkey=" + authkey
				+ ", state=" + state + ", balance=" + balance + "]";
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone_front() {
		return phone_front;
	}

	public void setPhone_front(String phone_front) {
		this.phone_front = phone_front;
	}

	public String getPhone_mid() {
		return phone_mid;
	}

	public void setPhone_mid(String phone_mid) {
		this.phone_mid = phone_mid;
	}

	public String getPhone_end() {
		return phone_end;
	}

	public void setPhone_end(String phone_end) {
		this.phone_end = phone_end;
	}

	public String getAddr1() {
		return addr1;
	}

	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}

	public String getAddr2() {
		return addr2;
	}

	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}

	public String getAddr3() {
		return addr3;
	}

	public void setAddr3(String addr3) {
		this.addr3 = addr3;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getMemberType() {
		return memberType;
	}

	public void setMemberType(int memberType) {
		this.memberType = memberType;
	}

	public String getAuthkey() {
		return authkey;
	}

	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getBalance() {
		return balance;
	}

	public void setBalance(int balance) {
		this.balance = balance;
	}

}