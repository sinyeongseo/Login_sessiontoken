package com.spring.login.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;



@Controller
public class LoginController{
	
	
	@GetMapping(value = "/")	//처음에 login 페이지 띄워주는 메소드
	public String main() { 
		
		return "index";
	}
	
	@RequestMapping(value = "/return.do")	//login 페이지로 다시 돌아가는 메소드
	public String returnmain() { 
		return "index";
	}
	
	
	
	@RequestMapping(value="/MoveLogin.do") //세션로그인 성공했을때 id, name, age 넘겨주는 메서드
	 public String moveToLogin(Model model, @RequestParam("id") String id, @RequestParam("name") String name
			 , @RequestParam("age") String age) {
        // 데이터를 Model에 추가하여 뷰로 전달
        model.addAttribute("receivedId", id);
        model.addAttribute("receivedName", name);
        model.addAttribute("receivedAge", age);
      
        return "Login"; // loginView는 실제 JSP 파일의 이름
	}

	@RequestMapping(value="/TokenMoveLogin.do") //토큰로그인 성공했을때 id, name, age tokenkey 넘겨주는 메서드
	 public String moveToTokenLogin(Model model, @RequestParam("result") String result, @RequestParam("name") String name
			 , @RequestParam("age") String age,@RequestParam("token")String tokenkey) {
        // 데이터를 Model에 추가하여 뷰로 전달
		model.addAttribute("receivedToken", tokenkey);
        model.addAttribute("receivedResult", result);
        model.addAttribute("receivedName", name);
        model.addAttribute("receivedAge", age);
       
        return "TokenLogin"; // loginView는 실제 JSP 파일의 이름
	}
	 
	@GetMapping("/logout.do") //세션 로그인 로그아웃
	public String logout(HttpServletRequest request) {
		  HttpSession session = request.getSession();

		  session.invalidate();
	    
		  return "index";
	}
	
	@GetMapping("/Tokenlogout.do") //토큰 로그인 로그아웃
	public String tokenlogout(HttpServletRequest request, HttpServletResponse response) {
        new SecurityContextLogoutHandler().logout(request, response, 
        		SecurityContextHolder.getContext().getAuthentication());
        
        return "index";
    }
	
}