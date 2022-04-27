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
public class Product {
	private int num;
	private String tags;
	private String address;
	private String cover;
	private int view;
	private String type;
	private String id;
	private String title;
	private String content;
	private int capacity;
	private Timestamp start;
	private Timestamp end;
	private Timestamp until;
	private Timestamp regdate;
	private Timestamp updates;
}
