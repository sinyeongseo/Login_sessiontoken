package com.spring.login.member;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component	//직접 작성한 Class를 Bean으로 등록하기 위한 어노테이션
public class MemberRepository {	//맴버 정보를 list형태로 넣어줌

    private List<Member> membership = new ArrayList<>();

    public MemberRepository() {
        membership.add(new Member("HGD", "hgd100", "홍길동", 100));
        membership.add(new Member("KTH", "kth43", "김태희", 43));
        membership.add(new Member("GGD", "ggd77", "고길동", 77));
        membership.add(new Member("IU", "iu30", "아이유", 30));
    }

    public List<Member> getMembership() {
    	
        return membership;
    }
}