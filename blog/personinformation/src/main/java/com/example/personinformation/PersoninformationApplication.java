package com.example.personinformation;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import javax.annotation.PreDestroy;

@SpringBootApplication
@EnableCaching
public class PersoninformationApplication {
    public static void main(String[] args)
    {
        SpringApplication.run(PersoninformationApplication.class, args);
    }
    
}
