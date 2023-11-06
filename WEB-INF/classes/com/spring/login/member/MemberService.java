package com.spring.login.member;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class MemberService {	//member인지 아닌지를 확인해주는 class

    private final MemberRepository memberRepository;

    public MemberService(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    public boolean validateLogin(String id, String password) {
        List<Member> membership = memberRepository.getMembership();
        
        for (Member member : membership) {	//membership에 든 내용들을 member에 대입하며 id, pw 값을 비교하여 로그인 가능 여부 확인
            if (member.getId().equals(id) && member.getPw().equals(password)) {
                return true; // 로그인 성공
            }
        }
        
        return false; // 로그인 실패
    }
}