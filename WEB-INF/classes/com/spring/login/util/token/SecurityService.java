package com.spring.login.util.token;

import org.springframework.stereotype.Service;

@Service
public interface SecurityService {
    String createToken(String subject, long ttlMillis);
 
    String getSubject(String token);
}
