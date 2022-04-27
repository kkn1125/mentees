package com.mentees.web.entity;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Member {
	private int num;
	private String name;
	private int gender;
	private String jumin;
	private String id;
	private String email;
	private String pw;
	private String msg;
	private String address;
	private int zip;
	private String interest;
	private Timestamp regdate;
	private Timestamp updates;
	public boolean checkPw(String pw) {
		if(this.pw.equals(pw)) {
			return true;
		}
		return false;
	}
	public void initImportant() {
		this.setPw("");
		this.setAddress("");
		this.setZip(0);
		this.setJumin("");
	}
}