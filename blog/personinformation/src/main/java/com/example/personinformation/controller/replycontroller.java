package com.example.personinformation.controller;

import com.example.personinformation.bean.article;
import com.example.personinformation.bean.reply;
import com.example.personinformation.love.RedisKeyUtils;
import com.example.personinformation.service.articleservice;
import com.example.personinformation.service.replyservice;
import com.example.personinformation.service.userservice;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class replycontroller {
    @Resource
    private replyservice rservice;
    @Resource
    private HttpSession session;
    @Resource
    private userservice uservice;
    @Resource
    private articleservice aservice;
    @Resource
    private RedisTemplate redisTemplate;

    @RequestMapping(value = "/reply/create")
    @ResponseBody
    public int addreply(reply r){
        String useridkey= RedisKeyUtils.getarticleid(r.getUserid());
        String articleid= RedisKeyUtils.getarticleid(r.getArticleid());
        int result = rservice.addreply(r);
        redisTemplate.opsForList().leftPush(useridkey+ "commont",articleid+":"+r.getContent());
        article commontedarticle = aservice.getarticlebyarticleid(r.getArticleid());
        String  commonteduseridkey= RedisKeyUtils.getarticleid(commontedarticle.getUserid());
        redisTemplate.opsForList().leftPush(commonteduseridkey+ "commonted",articleid+":"+r.getContent());
        System.out.println("插入结果"+result);
        return result;
    }
    @RequestMapping(value = "/reply/listreplybyid")
    @ResponseBody
    public int listreplybyid(int articleid){
        List<reply> listreplybyid = rservice.listreplybyid(articleid);
        System.out.println("查询结果"+listreplybyid);
        session.setAttribute("listreplybyid",listreplybyid);
        return 1;
    }
    @RequestMapping(value = "/reply/delete")
    @ResponseBody
    public int repalydelete(int replyid){
        rservice.deletereply(replyid);
        return 1;
    }
    @RequestMapping(value = "/reply/queryreplaybyuserid")
    @ResponseBody
    public List<String> queryreplaybyuserid(int userid){
        String useridkey= RedisKeyUtils.getarticleid(userid);
        List<String> range = redisTemplate.opsForList().range(useridkey + "commont", 0, 9);
        if(range.size()==0){
            List<reply> replyList = rservice.listreplybyuserid(userid);
            System.out.println(replyList);
            for(reply r: replyList){
                String articleid= RedisKeyUtils.getarticleid(r.getArticleid());
                redisTemplate.opsForList().leftPush(useridkey+ "commont",articleid+":"+r.getContent());
                range.add(r.getArticleid()+":"+r.getContent());
            }
        }
        return range;
    }
    @RequestMapping(value = "/reply/queryreplayedbyuserid")
    @ResponseBody
    public List<String> queryreplayedbyuserid(int userid){
        String useridkey= RedisKeyUtils.getarticleid(userid);
        List<String> range = redisTemplate.opsForList().range(useridkey + "commonted", 0, 9);

        if(range.size()==0){
            List<article> articles = aservice.getuserarticle(userid);
            List<reply> alllist=new ArrayList<reply>();
            for(article a:articles){
                List<reply> replyedList = rservice.listreplybyid(a.getArticleid());
                for(reply r:replyedList){
                    String articleid= RedisKeyUtils.getarticleid(r.getArticleid());
                    redisTemplate.opsForList().leftPush(useridkey+ "commonted",articleid+":"+r.getContent());
                    range.add(r.getArticleid()+":"+r.getContent());
                }
            }
        }
        return range;
    }
}
