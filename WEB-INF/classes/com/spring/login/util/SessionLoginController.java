package com.spring.login.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import com.spring.login.member.MemberRepository;
import com.spring.login.member.Member;


@Controller
public class SessionLoginController {
	   
	
	@Autowired
	private MemberRepository memberRepository;
	
	@PostMapping(value="/SessionLogin.do") //session login 처리하는 메서드
	@ResponseBody
	public Map<String, Object> SessionLogin(@RequestParam("user_id") String id, @RequestParam("user_pw") String pw,
			HttpServletRequest request) {
			System.out.println("Session");
	    List<Member> membership = memberRepository.getMembership();
	    Map<String, Object> response = new HashMap<>();
	    
	    for (Member member : membership) {
	        if (member.getId().equals(id) && member.getPw().equals(pw)) { // 회원일 경우
	            System.out.println("회원입니다");
	            HttpSession session = request.getSession();
	            session.setAttribute("loginUser", id);
	            session.setMaxInactiveInterval(60*1);
 	            response.put("age", member.getAge());
	            response.put("name", member.getName());
	            response.put("id", id);
	              
	            return response;
	        }
	    }

	    // 회원이 아닐 경우
	    System.out.println("회원이 아닙니다.");
	    response.put("age",null);
        response.put("name",null);
        response.put("id",null);
        
	    return response;
	}
	
	@RequestMapping(value = "/sessiondata.do", produces = "text/plain;charset=UTF-8")	//session 남은 시간 띄워주는 메서드
	@ResponseBody
	public String sessiondata(@SessionAttribute(name = "loginUser",required = false) String id,HttpSession session) { 
		//SessionAttribute를 사용하여 session에서 값을 꺼내올 수 있음
		String result = " ";
		  if (id == null) {
		        System.out.println("로그인 하지 않음");
		    } else {
		        System.out.println("로그인 유저의 Id: " + id);
		        long currentTime = System.currentTimeMillis();
		        long sessionTimeout = session.getMaxInactiveInterval() * 1000;
		        long timeRemaining = sessionTimeout - (currentTime - session.getCreationTime());

		        if (timeRemaining > 0) {
		            long seconds = timeRemaining / 1000;
		            long minutes = seconds / 60;
		            long hours = minutes / 60;

		            result = hours + " 시간, " + (minutes % 60) + " 분, " + (seconds % 60) + " 초 남았습니다.";
		            System.out.println(result);
		            return result;
		        } else {
		            System.out.println("세션이 만료되었습니다.");
		        }
		    }
		    return result;
	}
	

	
	@GetMapping(value="/checksession.do") //session 유효성 체크하는 메서드
	@ResponseBody
    public Map<String, Boolean> checkSession(HttpSession session) {
        Map<String, Boolean> response = new HashMap<>();
        
        boolean sessionExpired = false;
        
        if (session.getAttribute("loginUser") == null) {
            sessionExpired = true;
        } else {
            long currentTimeMillis = System.currentTimeMillis();
            long sessionCreationTimeMillis = session.getCreationTime();
            long sessionTimeoutInMillis = session.getMaxInactiveInterval() * 1000;
            long sessionExpirationTimeInMillis = sessionCreationTimeMillis + sessionTimeoutInMillis;

            if (currentTimeMillis > sessionExpirationTimeInMillis) {
                sessionExpired = true;
            }
        }
        
        response.put("sessionExpired", sessionExpired);
        return response;
    }
}
