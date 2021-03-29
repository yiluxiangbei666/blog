package com.example.personinformation.config;



import javax.annotation.PreDestroy;


public class TestImplDisposableBean{

    @PreDestroy
    public void preDestroy() {
        System.out.println("TerminalBean is destroyed");
    }
}