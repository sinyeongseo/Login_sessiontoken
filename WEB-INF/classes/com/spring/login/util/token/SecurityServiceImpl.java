package com.spring.login.util.token;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Service;
 
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;
import java.util.Date;
 
@Service
public class SecurityServiceImpl implements SecurityService {
   
	private static final String SECRET_KEY = "aasjjkjaskjdl1k2naskjkdakj34c8sa";
 
    @Override
    public String createToken(String subject, long ttlMillis) { //토큰을 만들어서 발행하는 역할
    	System.out.println("토큰 생성하기");
        if (ttlMillis <= 0) {
            throw new RuntimeException("Expiry time must be greater than Zero : ["+ttlMillis+"] ");
        }
        // 토큰을 서명하기 위해 사용해야할 알고리즘 선택
        SignatureAlgorithm  signatureAlgorithm= SignatureAlgorithm.HS256;
        
        byte[] secretKeyBytes = DatatypeConverter.parseBase64Binary(SECRET_KEY);
        Key signingKey = new SecretKeySpec(secretKeyBytes, signatureAlgorithm.getJcaName());
       
        return Jwts.builder()
		.setSubject(subject)
		.signWith(signatureAlgorithm, signingKey)
		.setExpiration(new Date(System.currentTimeMillis()+ttlMillis))
		.compact();
    }
 
    @Override
    public String getSubject(String token) {	//비밀키로 풀어서 값을 가져오는 역할
    	System.out.println("토큰 값 가져오기");
    	Claims claims = Jwts.parser()
    			.setSigningKey(DatatypeConverter.parseBase64Binary(SECRET_KEY))
    			.parseClaimsJws(token)
    			.getBody();
    	return claims.getSubject();  
    }
}
