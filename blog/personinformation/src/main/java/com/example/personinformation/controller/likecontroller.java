package com.example.personinformation.controller;

import com.example.personinformation.bean.article;
import com.example.personinformation.bean.msg;
import com.example.personinformation.love.LikedStatusEnum;
import com.example.personinformation.love.RedisKeyUtils;
import com.example.personinformation.service.RedisService;
import com.example.personinformation.service.articleservice;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

@Controller
public class likecontroller {

    @Resource
    private articleservice aservice;
    @Resource
    RedisService redisService;
    @Resource
    RedisTemplate redisTemplate;

    @RequestMapping(value = "/article/addlike")
    @ResponseBody
    public msg userlikeartic(int userid, int articleid){
        System.out.println(userid+"   "+articleid);
        String key = RedisKeyUtils.getLikedKey(userid, articleid);
        redisTemplate.opsForHash().put(RedisKeyUtils.MAP_KEY_USER_LIKED, key, LikedStatusEnum.LIKE.getCode());
        String user_if_love = (String)redisTemplate.opsForHash().get(RedisKeyUtils.MAP_KEY_USER_LIKED, key);
        String articleidkey=RedisKeyUtils.getarticleid(articleid);
        redisTemplate.opsForHash().increment(RedisKeyUtils.article_user_like, articleidkey, 1);
        String article_love_amount= (String)redisTemplate.opsForHash().get(RedisKeyUtils.article_user_like, articleidkey);
        System.out.println("user_if_loveu:"+user_if_love+"article_love_amount:"+article_love_amount);
        msg m=new msg(user_if_love,article_love_amount);
        article a=new article(articleid,Integer.valueOf(article_love_amount).intValue());
        aservice.updatearticle(a);
        return m;
    }
    @RequestMapping(value = "/article/deletelike")
    @ResponseBody
    public msg userundolikeartic(int userid, int articleid){
        System.out.println(userid+"   "+articleid);
        String key = RedisKeyUtils.getLikedKey(userid, articleid);
        redisTemplate.opsForHash().put(RedisKeyUtils.MAP_KEY_USER_LIKED, key, LikedStatusEnum.UNLIKE.getCode());
        String user_if_love = (String)redisTemplate.opsForHash().get(RedisKeyUtils.MAP_KEY_USER_LIKED, key);
        String articleidkey=RedisKeyUtils.getarticleid(articleid);
        redisTemplate.opsForHash().increment(RedisKeyUtils.article_user_like, articleidkey, -1);
        String article_love_amount= (String)redisTemplate.opsForHash().get(RedisKeyUtils.article_user_like, articleidkey);
        System.out.println("user_if_loveu:"+user_if_love+"article_love_amount:"+article_love_amount);
        msg m=new msg(user_if_love,article_love_amount);
        article a=new article(articleid,Integer.valueOf(article_love_amount).intValue());
        aservice.updatearticle(a);
        return m;
    }
    @RequestMapping(value = "/article/useriflove")
    @ResponseBody
    public msg useriflove(int userid, int articleid){
        String key = RedisKeyUtils.getLikedKey(userid, articleid);
        String articleidkey=RedisKeyUtils.getarticleid(articleid);
        String user_if_love = (String)redisTemplate.opsForHash().get(RedisKeyUtils.MAP_KEY_USER_LIKED, key);
        String article_love_amount= (String)redisTemplate.opsForHash().get(RedisKeyUtils.article_user_like, articleidkey);
        msg m=new msg(user_if_love,article_love_amount);
        return m;
    }
    @RequestMapping(value = "/article/useridlike")
    @ResponseBody
    public List<String> useridlike(int userid){
        String useridkey = RedisKeyUtils.getarticleid(userid);
        List<String> list = redisTemplate.opsForList().range(useridkey + "lovearticle", 0, 9);
        if(list.size()==0){
            Set<String> map_key_user_liked = redisTemplate.opsForHash().keys(RedisKeyUtils.MAP_KEY_USER_LIKED);
            Iterator<String> iterator = map_key_user_liked.iterator();
            while (iterator.hasNext()){
                String next = iterator.next();
                String user_if_love = (String)redisTemplate.opsForHash().get(RedisKeyUtils.MAP_KEY_USER_LIKED, next);
                String[] split = next.split("::");
                if(user_if_love.equals("1")){
                    redisTemplate.opsForList().leftPush(split[0]+"lovearticle",split[1]);
                }
            }
        }
        list = redisTemplate.opsForList().range(useridkey + "lovearticle", 0, 9);
        return list;
    }

    @RequestMapping(value = "/article/useridedlike")
    @ResponseBody
    public List<String> useridedlike(int userid){
        String useridkey = RedisKeyUtils.getarticleid(userid);
        List<String> list = redisTemplate.opsForList().range(useridkey + "lovedarticle", 0, 9);
        if(list.size()==0){
            Set<String> map_key_user_liked = redisTemplate.opsForHash().keys(RedisKeyUtils.MAP_KEY_USER_LIKED);
            Iterator<String> iterator = map_key_user_liked.iterator();
            while (iterator.hasNext()){
                String next = iterator.next();
                String user_if_love = (String)redisTemplate.opsForHash().get(RedisKeyUtils.MAP_KEY_USER_LIKED, next);
                String[] split = next.split("::");
                int articleid = Integer.valueOf(split[1]).intValue();
                article a = aservice.getarticlebyarticleid(articleid);
                if(user_if_love.equals("1")){
                    redisTemplate.opsForList().leftPush(String.valueOf(a.getUserid())+"lovedarticle",next);
                }
            }
        }
        list = redisTemplate.opsForList().range(useridkey + "lovedarticle", 0, 9);
        return list;
    }

}
