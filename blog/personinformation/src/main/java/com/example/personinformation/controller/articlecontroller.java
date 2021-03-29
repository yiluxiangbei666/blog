package com.example.personinformation.controller;

import com.example.personinformation.bean.user;
import com.example.personinformation.bean.article;
import com.example.personinformation.love.RedisKeyUtils;
import com.example.personinformation.service.articleservice;
import com.example.personinformation.service.userservice;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class articlecontroller {
    @Resource
    RedisTemplate redisTemplate;
    @Resource
    private articleservice aservice;
    @Resource
    private userservice uservice;
    @Resource
    private HttpSession session;

    @RequestMapping(value = "/article/create")
    @ResponseBody
    public int addarticle(article a){
        int result= aservice.addarticle(a);
        System.out.println("插入结果"+result);
        return result;
    }
    @RequestMapping(value = "/article/listarticle")
    @ResponseBody
    public List<article> listarticle(){
        List<article> listarticle = aservice.listarticle();
        if(listarticle!=null){
            session.setAttribute("listarticle",listarticle);
            return listarticle;
        }
        else {
            return null;
        }
    }
    @RequestMapping(value = "/article/getuserarticle")
    @ResponseBody
    public List<article> getuserarticle(int userid){
        List<article> userarticle = aservice.getuserarticle(userid);
        if(userarticle!=null){
            session.setAttribute("userarticle",userarticle);
            return userarticle;
        }
        else {
            return null;
        }
    }
    @RequestMapping(value = "/article/getarticle")
    public String getarticle(String articletitle){
        article article = aservice.getarticle(articletitle);
        if(article!=null){
            session.setAttribute("article",article);
            System.out.println("查询文章结果"+article);
            user user = uservice.getuserbyId(article.getUserid());
            session.setAttribute("user_article_name",user.getUsername());
        }
        else {
            session.removeAttribute("article");
        }
        return "article";
    }
    @RequestMapping(value = "/article/updatearticle")
    @ResponseBody
    public int updatearticle(article r){
        System.out.println(r);
        aservice.updatearticle(r);
        return 1;
    }
    @RequestMapping(value = "/article/rewardarticlemoney")
    @ResponseBody
    public int rewardarticlemoney(int articleid,int userid,int rewardmoney, String rewarddescribe){
        System.out.println(articleid+"  "+userid+"  "+rewardmoney+"  "+rewarddescribe);
        String rewardhashkey= RedisKeyUtils.getLikedKey(userid,articleid);
        redisTemplate.opsForHash().put(rewardhashkey,"rewardmoney",String.valueOf(rewardmoney));
        redisTemplate.opsForHash().put(rewardhashkey,"rewarddescribe",String.valueOf(rewarddescribe));
        String useridkey=RedisKeyUtils.getarticleid(userid);
        String o = (String)redisTemplate.opsForValue().get(useridkey + "money");
        int balance=Integer.valueOf(o).intValue()-rewardmoney;
        if(balance>=0){
            redisTemplate.opsForValue().set(useridkey+"money",String.valueOf(balance));
            article a = aservice.getarticlebyarticleid(articleid);
            String rewarduseridkey=RedisKeyUtils.getarticleid(a.getUserid());
            String rewardo = (String)redisTemplate.opsForValue().get(rewarduseridkey+"money");
            int rewardbalance=Integer.valueOf(rewardo).intValue()+rewardmoney;
            redisTemplate.opsForValue().set(rewarduseridkey+"money",String.valueOf(rewardbalance));
            return 1;
        }
        return 0;
    }
    @RequestMapping(value = "/article/ifuserreward")
    @ResponseBody
    public int ifuserreward(int articleid,int userid){
        String key= RedisKeyUtils.getLikedKey(userid,articleid);
        Boolean hasKey = redisTemplate.hasKey(key);
        if(hasKey==true){
            return 1;
        }
        else {
            return 0;
        }
    }
    @RequestMapping(value = "/article/getarticlebyarticleid")
    @ResponseBody
    public article getarticlebyarticleid(int articleid){
        article article = aservice.getarticlebyarticleid(articleid);
        if(article!=null){
            return article;
        }
        else {
            return null;
        }
    }
}
