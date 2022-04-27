package com.mentees.web.entity;


import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Recommend {
	private int num;
	private int recommender; // 추천한 사람
	private int referral; // 추천받은 사람 
	private Timestamp regdate;
}