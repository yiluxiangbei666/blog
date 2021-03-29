package com.example.personinformation.controller;

import com.example.personinformation.bean.usermsg;
import com.example.personinformation.service.usermsgservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class usermsgcontroller {
    @Autowired
    usermsgservice uservice;
    @RequestMapping("/addusermsgtodb")
    public void  addusermsg(usermsg msg){

         uservice.addusermsg(msg);
    }
    @RequestMapping("/deleteusermsg")
    @ResponseBody
    public int  delete(int toUser){
         uservice.deleteusermsg(toUser);
         return 1;
    }
    @RequestMapping("/getusermsglist")
    @ResponseBody
    public List<usermsg>  getuserlist(int toUser){
        List<usermsg> msglist = uservice.getMsglist(toUser);
        return msglist;
    }
}
