package com.example.personinformation.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ShutDownConfig {

    @Bean
    public TestImplDisposableBean getTerminateBean() {
        return new TestImplDisposableBean();
    }

}
