package com.example.personinformation.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class indexController {
    @RequestMapping(value = "/index")
    public String index(){
        return "index";
    }
    @RequestMapping(value = "/login")
    public String login(){
        return "login";
    }
    @RequestMapping(value = "/register")
    public String register(){
        return "register";
    }
    @RequestMapping(value = "/articlemanagement")
    public String articlemanagement(){
        return "articlemanagement";
    }
    @RequestMapping(value = "/books")
    public String books(){
        return "books";
    }
    @RequestMapping(value = "/writearicle")
    public String writearicle(){
        return "writearicle";
    }
    @RequestMapping(value = "/personinformation")
    public String personinformation(){
        return "personinformation";
    }
    @RequestMapping(value = "/person_article")
    public String person_article(){
        return "person_article";
    }
    @RequestMapping(value = "/article")
    public String article(){
        return "article";
    }
    @RequestMapping(value = "/mywallet")
    public String mywallet(){
        return "mywallet";
    }
    @RequestMapping(value = "/myreward")
    public String myreward(){
        return "myreward";
    }
    @RequestMapping(value = "/comment")
    public String comment(){
        return "comment";
    }
    @RequestMapping(value = "/mylovearticle")
    public String mylovearticle(){
        return "mylovearticle";
    }
    @RequestMapping(value = "/myfriend")
    public String myfriend(){
        return "myfriend";
    }
    @RequestMapping(value = "/mymayknowfriends")
    public String mymayknowfriends(){
        return "mymayknowfriends";
    }
    @RequestMapping(value = "/python")
    public String python(){
        return "python";
    }
    @RequestMapping(value = "/chat")
    public String chat(){
        return "chat";
    }
}
