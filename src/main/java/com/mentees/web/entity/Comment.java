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
public class Comment {
	private int num;
	private int pnum;
	private int cnum;
	private int order;
	private int layer;
	private String author;
	private String content;
	private int visible;
	private Timestamp regdate;
}
