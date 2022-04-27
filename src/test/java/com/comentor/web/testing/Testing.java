package com.comentor.web.testing;

import java.util.HashSet;
import java.util.Set;

import org.junit.jupiter.api.Test;

public class Testing {
	@Test
	public void testing() {
		String[] strings = {"김","박","김"};
		Set<String> set = new HashSet<String>();
		System.out.println(set);
		for(String s : strings) {
			set.add(s);
		}
		System.out.println(set);
	}
}
