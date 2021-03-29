package com.example.personinformation.controller;

import com.example.personinformation.bean.msg;
import com.example.personinformation.love.LikedStatusEnum;
import com.example.personinformation.love.RedisKeyUtils;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;


@Controller
public class usermoney {
    @Resource
    RedisTemplate redisTemplate;
    @Resource
    HttpSession session;

    @RequestMapping(value = "/usermoney/addmoney")
    @ResponseBody
    public List<String> addmoney(String date, int userid,String money){
        String useridkey=RedisKeyUtils.getarticleid(userid);
        redisTemplate.opsForList().leftPush(useridkey,date+":"+money);
        List<String> addmoneylist = (List<String>)redisTemplate.opsForList().range(useridkey, 0, 9);
        System.out.println(addmoneylist);
        String o = (String)redisTemplate.opsForValue().get(useridkey + "money");
        System.out.println();
        int indexmoney;
        if(o!=null){
            indexmoney=RedisKeyUtils.getInteger(o)+RedisKeyUtils.getInteger(money);
        }
        else {
            indexmoney=RedisKeyUtils.getInteger(money);
        }
        String textmoney=RedisKeyUtils.getarticleid(indexmoney);
        redisTemplate.opsForValue().set(useridkey + "money",textmoney);
        return addmoneylist;
    }
    @RequestMapping(value = "/usermoney/querymoneyrecord")
    @ResponseBody
    public List<String> querymoneyrecord(int userid){
        String useridkey=RedisKeyUtils.getarticleid(userid);
        List<String> addmoneylist = (List<String>)redisTemplate.opsForList().range(useridkey, 0, 9);
        System.out.println(addmoneylist);
        return addmoneylist;
    }
    @RequestMapping(value = "/usermoney/querymoney")
    @ResponseBody
    public msg querymoney(int userid){
        String useridkey=RedisKeyUtils.getarticleid(userid);
        String o = (String)redisTemplate.opsForValue().get(useridkey + "money");
        msg m=new msg(o);
        return m;
    }
    @RequestMapping(value = "/usermoney/queryrewardrecord")
    @ResponseBody
    public List<String> queryrewardrecord(int userid){
        String key=RedisKeyUtils.getarticleid(userid);
        Set<String> keys = redisTemplate.keys(key+"::*");
        for(String key1 : keys){
            System.out.println("key1=========="+key1);
        }
        System.out.println("aaaaaa");
        return null;
    }
}
