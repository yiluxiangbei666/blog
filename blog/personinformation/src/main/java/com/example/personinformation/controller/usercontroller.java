package com.example.personinformation.controller;

import com.example.personinformation.bean.user;
import com.example.personinformation.SerializableConvert.serializableconver;
import com.example.personinformation.love.RedisKeyUtils;
import com.example.personinformation.service.userservice;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.Jedis;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.List;
import java.util.concurrent.TimeUnit;

@RestController
public class usercontroller {
    private serializableconver s=new serializableconver();
    @Resource
    private HttpSession session;
    @Resource
    private userservice uservice;
    @Resource
    RedisTemplate redisTemplate;

    @RequestMapping(value = "/user/create")
    @ResponseBody
    public int adduser(user u){
        Jedis jedis= new Jedis("127.0.0.1",6379);
        int result= uservice.adduser(u);
        System.out.println("插入结果"+result);
        jedis.set(u.getUsername().getBytes(),s.serialize(u));
        jedis.expire(u.getUsername().getBytes(),30);
        return result;
    }
    @RequestMapping(value = "/user/login")
    @ResponseBody
    public boolean login(user u){
        user sessionu = (user)session.getAttribute("user");
        Jedis jedis= new Jedis("127.0.0.1",6379);
        byte[] bytes = jedis.get(u.getUsername().getBytes());
        user if_u=null;
        long beginTime = System.currentTimeMillis();
        if(bytes!=null){
            if_u= (user) s.unsterilized(bytes);
            String newuserid=RedisKeyUtils.getarticleid(if_u.getUserid())+"online";
            if(sessionu!=null){
                String olduserid= RedisKeyUtils.getarticleid(sessionu.getUserid())+"online";
                System.out.println(newuserid+" "+olduserid);
                if(sessionu.getUserid()!=if_u.getUserid()){
                    redisTemplate.opsForHash().put("user_oonline",newuserid,"1");
                    redisTemplate.opsForHash().put("user_oonline",olduserid,"0");
                    redisTemplate.expire("user_oonline",30, TimeUnit.MINUTES);
                }
            }else {
                redisTemplate.opsForHash().put("user_oonline",newuserid,"1");
                redisTemplate.expire("user_oonline",30, TimeUnit.MINUTES);
            }
            session.setAttribute("user",if_u);
            long time=System.currentTimeMillis()-beginTime;
            System.out.println("缓存中得到"+time+" "+if_u);
            return true;
        }
        else {
            if_u= uservice.getuser(u);
            if(if_u!=null){
                String newuserid=RedisKeyUtils.getarticleid(if_u.getUserid())+"online";
                if(sessionu!=null){
                    String olduserid= RedisKeyUtils.getarticleid(sessionu.getUserid())+"online";
                    System.out.println(newuserid+" "+olduserid);
                    if(sessionu.getUserid()!=if_u.getUserid()){
                        redisTemplate.opsForHash().put("user_oonline",newuserid,"1");
                        redisTemplate.opsForHash().put("user_oonline",olduserid,"0");
                        redisTemplate.expire("user_oonline",30, TimeUnit.MINUTES);
                    }
                }else {
                    redisTemplate.opsForHash().put("user_oonline",newuserid,"1");
                    redisTemplate.expire("user_oonline",30, TimeUnit.MINUTES);
                }
                session.setAttribute("user",if_u);
                long time=System.currentTimeMillis()-beginTime;
                System.out.println("mysql中得到"+time+" "+if_u);
                jedis.set(if_u.getUsername().getBytes(),s.serialize(if_u));
                jedis.expire(if_u.getUsername().getBytes(),30);
                return true;
            }
            else {
                System.out.println("no");
                return false;
            }
        }
    }
    @RequestMapping(value = "/user/update")
    @ResponseBody
    public boolean update(user u){
        Jedis jedis= new Jedis("127.0.0.1",6379);
        uservice.updateuser(u);
        jedis.set(u.getUsername().getBytes(),s.serialize(u));
        jedis.expire(u.getUsername().getBytes(),30);
        return true;
    }
    @RequestMapping(value = "/user/listuser")
    @ResponseBody
    public boolean listuser(){
        Jedis jedis= new Jedis("127.0.0.1",6379);
        byte[] bytes = jedis.get("listuser".getBytes());
        List<user> listuser=null;
        if(bytes!=null){
            listuser = (List<user>) s.unsterilized(bytes);
            session.setAttribute("listuser",listuser);
            return true;
        }
        else {
            listuser = uservice.listuser();
            if(listuser!=null){
                jedis.set("listuser".getBytes(),s.serialize(listuser));
                jedis.expire("listuser".getBytes(),30);
                session.setAttribute("listuser",listuser);
                return true;
            }
            else {
                return false;
            }
        }
    }
    @RequestMapping(value = "/user/getuser")
    @ResponseBody
    public user getuser(int userid){
        System.out.println(userid);
        user u = uservice.getuserbyId(userid);
        System.out.println(u);
        return u;
    }
}
