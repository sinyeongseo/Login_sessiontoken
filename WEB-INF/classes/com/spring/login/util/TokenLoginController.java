package com.spring.login.util;


import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.login.member.Member;
import com.spring.login.member.MemberRepository;
import com.spring.login.member.MemberService;
import com.spring.login.util.token.SecurityService;


@Controller
public class TokenLoginController {
	
	 @Autowired
	 private MemberRepository memberRepository;
	 
	 @Autowired
	    private SecurityService securityService;
	 
	 @Autowired
	 private MemberService memberService;
	

	@PostMapping(value="/TokenLogin.do") //토큰방식 로그인
	@ResponseBody
	public Map<String,Object> loginSuccess(@RequestParam("user_id")String id,
			@RequestParam("user_pw")String pw, HttpServletRequest request) {
			System.out.println("Token");
			System.out.println(id);
			System.out.println(pw);
			
			Map<String, Object> map = new LinkedHashMap<>();
			 
			 if (memberService.validateLogin(id, pw)) {
				 System.out.println("회원입니다.");
				 String token = securityService.createToken(id, (1 * 1000 * 10)); //토큰 생성
			     map.put("result", token);
			     System.out.println(token);
			     System.out.println("토큰 넘어옴");
	        } else {
	        	System.out.println("회원이 아닙니다.");
	        	 map.put("result", null);
	        } 
			 return map;
	    }	

	
	 @PostMapping("/LoginAfter.do") //로그인후 정보 띄워주기
	 @ResponseBody
	 public Map<String, Object> getSubject(@RequestParam("user_id") String id,
			 @RequestParam("token") String token) {
	     String subject = securityService.getSubject(token);
	    
	     Map<String, Object> response = new HashMap<>();
	     List<Member> membership = memberRepository.getMembership();
	     
	     for (Member member : membership) {
	         if (member.getId().equals(id)) {
	             response.put("result", subject);
	             response.put("age", member.getAge());
	             response.put("name", member.getName());
	             break; // 일치하는 회원을 찾았으면 루프 종료
	         }
	     }
	     
	     return response;
	 }
}
