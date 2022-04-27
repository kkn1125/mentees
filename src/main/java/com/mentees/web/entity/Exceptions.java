package com.mentees.web.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Exceptions {
	private String status;
	private String code;
	private String message;
	
	public boolean isSameStatus(Object status) {
		boolean result = false;
		if(this.status.equals(status.toString())) {
			result = true;
		}
		return result;
	}
}
