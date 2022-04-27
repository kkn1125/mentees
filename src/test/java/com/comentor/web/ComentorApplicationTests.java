package com.comentor.web;

import javax.servlet.http.HttpServletRequest;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

//@SpringBootTest(classes = ComentorApplicationTests.class,properties = {
//		"propertyTest.value=propertyTest",
//		"testValue=test"
//})
// classes는 테스트할 현재 클래스 추가
// 프로퍼티 직접설정하여 @Value로 받아 뿌릴수 있다.
@SpringBootTest(properties = { "spring.config.location=classpath:application-test.properties" },
classes = ComentorApplicationTests.class)
class ComentorApplicationTests {

//	@Value("${propertyTest.value}")
//	private String propertyTestValue;
//	
//	@Value("${testValue}")
//	private String value;
	
	@Autowired
	HttpServletRequest request;
	
	@Test
	void contextLoads(){
		String test = "test";
		System.out.println(request.getServletContext().getRealPath("classpath"));
	}
}
