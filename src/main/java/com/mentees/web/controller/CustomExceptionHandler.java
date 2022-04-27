package com.mentees.web.controller;

import java.io.File;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mentees.web.entity.Exceptions;

@Controller
public class CustomExceptionHandler implements ErrorController
{
	final static private String ERROR_PATH = "error.exceptions";
	
	@GetMapping("/error")
	public String ExceptionHandler(HttpServletRequest request, Model model) {
		Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
		ObjectMapper mapper = new ObjectMapper();
		ClassLoader classLoader = getClass().getClassLoader();
		File file = new File(classLoader.getResource("exception.json").getFile());
		try {
			List<Exceptions> exceptionList = mapper.readValue(file, new TypeReference<List<Exceptions>>() {
			});
			model.addAttribute("list",exceptionList);
			exceptionList.forEach(ex->{
				if(ex.isSameStatus(status)) {
					model.addAttribute("exception", ex);
				}
			});
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return ERROR_PATH;
	}
}
