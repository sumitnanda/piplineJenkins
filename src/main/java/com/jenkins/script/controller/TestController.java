package com.jenkins.script.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {
	
	
	@GetMapping(value = "/welcome-back")
	public String testing() {
		
		return "Working on 27-08 part 2";
	}

	

}
