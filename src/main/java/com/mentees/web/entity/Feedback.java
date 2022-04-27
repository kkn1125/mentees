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
public class Feedback {
	private int num;
	private int view;
	private String title;
	private String content;
	private String author;
	private String tags;
	private Timestamp regdate;
	private Timestamp updates;
}