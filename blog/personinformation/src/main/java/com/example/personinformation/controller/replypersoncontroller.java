package com.example.personinformation.controller;

import com.example.personinformation.bean.replyperson;
import com.example.personinformation.service.replypersonservice;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class replypersoncontroller {
    @Resource
    private replypersonservice rpservice;
    @RequestMapping(value = "/replyperson/create")
    @ResponseBody
    public int addreplyperson(replyperson r){
        int result = rpservice.addreplyperson(r);
        System.out.println("插入回复某人结果"+result);
        return result;
    }
    @RequestMapping(value = "/replyperson/listreplypersonbyreplyid")
    @ResponseBody
    public List<replyperson> listreplypersonbyreplyid(int replyid){
        List<replyperson> listreply = rpservice.listreplypersonbyreplyid(replyid);
        if(listreply!=null){
            System.out.println(listreply);
            return listreply;
        }
        return null;
    }
    @RequestMapping(value = "/replyperson/deletereplyperson")
    @ResponseBody
    public int deletereplyperson(int replypersonid){
        rpservice.deletereplyperson(replypersonid);
        return 1;
    }
}
