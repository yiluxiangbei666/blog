package com.example.personinformation.controller;

import com.example.personinformation.bean.user;
import com.example.personinformation.love.RedisKeyUtils;
import com.example.personinformation.service.userservice;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class friends {
    @Resource
    RedisTemplate redisTemplate;
    @Resource
    userservice uservice;
    @RequestMapping("/addfriends")
    @ResponseBody
    public int addfridends(int userid,int addeduserid){
        String useridkey=RedisKeyUtils.getarticleid(userid);
        String addeduseridkey=RedisKeyUtils.getarticleid(addeduserid);
        String key=RedisKeyUtils.getLikedKey(userid,addeduserid);
        redisTemplate.opsForHash().put("useridaddfriend", key, "1");
        redisTemplate.opsForList().leftPush(useridkey+"addfriends",addeduseridkey);
        return 1;
    }
    @RequestMapping("/myaddfriendslist")
    @ResponseBody
    public List<String>  myaddfriendslist(int userid){
        String useridkey=RedisKeyUtils.getarticleid(userid);
        Set<String> useridaddfriend = redisTemplate.opsForHash().keys("useridaddfriend");
//        redisTemplate.opsForList().leftPush(useridkey+"addfriends",addeduseridkey);
        Iterator<String> iterator = useridaddfriend.iterator();
        List<String> list=new ArrayList<>();
        while (iterator.hasNext()){
            String next=iterator.next();
            String[] split = next.split("::");
            if(Integer.valueOf(split[0]).intValue()==userid){
                String value = (String)redisTemplate.opsForHash().get("useridaddfriend", next);
                user u = uservice.getuserbyId(Integer.valueOf(split[1]).intValue());
                if(value.equals("1")){
                    list.add(split[1]+":"+u.getUsername()+":待同意");
                }
                else if(value.equals("0")){
                    list.add(split[1]+":"+u.getUsername()+":已拒绝");
                }
                else{
                    list.add(split[1]+":"+u.getUsername()+":已同意");
                }
            }
        }
        list=list.stream()
                .distinct()
                .collect(Collectors.toList());
        return list;
    }
    @RequestMapping("/addmelist")
    @ResponseBody
    public List<String>  addmelist(int userid){
        String useridkey=RedisKeyUtils.getarticleid(userid);
        Set<String> useridaddfriend = redisTemplate.opsForHash().keys("useridaddfriend");
//        redisTemplate.opsForList().leftPush(useridkey+"addfriends",addeduseridkey);
        Iterator<String> iterator = useridaddfriend.iterator();
        List<String> list=new ArrayList<>();
        while (iterator.hasNext()){
            String next=iterator.next();
            String[] split = next.split("::");
            if(Integer.valueOf(split[1]).intValue()==userid){
                String value = (String)redisTemplate.opsForHash().get("useridaddfriend", next);
                user u = uservice.getuserbyId(Integer.valueOf(split[0]).intValue());
                if(value.equals("1")){
                    list.add(split[0]+":"+u.getUsername());
                }
            }
        }
        return list;
    }
    @RequestMapping("/agreeaddfriends")
    @ResponseBody
    public int agreeaddfriends(int userid,String agreeuserid){
        String key=RedisKeyUtils.getLikedKey(Integer.valueOf(agreeuserid).intValue(),userid);
        redisTemplate.opsForHash().put("useridaddfriend", key, "2");
        String useridkey=RedisKeyUtils.getarticleid(userid);
        redisTemplate.opsForList().leftPush(useridkey+"friends",agreeuserid);
        redisTemplate.opsForList().leftPush(agreeuserid+"friends",useridkey);
        return 1;
    }
    @RequestMapping("/refuseaddfriends")
    @ResponseBody
    public int refuseaddfriends(int userid,String agreeuserid){
        String key=RedisKeyUtils.getLikedKey(Integer.valueOf(agreeuserid).intValue(),userid);
        redisTemplate.opsForHash().put("useridaddfriend", key, "0");
        return 1;
    }
    @RequestMapping("/queryfridens")
    @ResponseBody
    public List<String> queryfridens(int userid){
        List<String> range = redisTemplate.opsForList().range(RedisKeyUtils.getarticleid(userid) + "friends", 0, 15);
        Iterator<String> iterator = range.iterator();
        List<String> list=new ArrayList<>();
        while (iterator.hasNext()){
            String next = iterator.next();
            user u = uservice.getuserbyId(Integer.valueOf(next).intValue());
            Boolean is = redisTemplate.opsForHash().hasKey("user_oonline", String.valueOf(u.getUserid()) + "online");
            if(is){
                String value = (String)redisTemplate.opsForHash().get("user_oonline", String.valueOf(u.getUserid()) + "online");
                if(value.equals("1")){
                    list.add(String.valueOf(u.getUserid())+":"+u.getUsername()+":"+"在线");
                }else {
                    list.add(String.valueOf(u.getUserid())+":"+u.getUsername()+":"+"离线");
                }
            }else {
                list.add(String.valueOf(u.getUserid())+":"+u.getUsername()+":"+"离线");
            }
        }
        list=list.stream()
                .distinct()
                .collect(Collectors.toList());
        return list;
    }
    @RequestMapping("/mayknowperson")
    @ResponseBody
    public List<String> mayknowperson(int userid){
        //我的朋友
        List<String> range = redisTemplate.opsForList().range(RedisKeyUtils.getarticleid(userid) + "friends", 0, 5);
        Iterator<String> iterator = range.iterator();
        List<String> list=new ArrayList<>();
        while (iterator.hasNext()){
            String next = iterator.next();
            //我的某个朋友
            user u = uservice.getuserbyId(Integer.valueOf(next).intValue());
            //我某个朋友的朋友
            List<String> range1 = redisTemplate.opsForList().range(RedisKeyUtils.getarticleid(u.getUserid()) + "friends", 0, 5);
            Iterator<String> iterator1 = range1.iterator();
            while (iterator1.hasNext()){
                String next1=iterator1.next();
                //我某个朋友的某个朋友
                user u1 = uservice.getuserbyId(Integer.valueOf(next1).intValue());
                //我某个朋友的某个朋友的朋友
                List<String> range2 = redisTemplate.opsForList().range(RedisKeyUtils.getarticleid(u1.getUserid()) + "friends", 0, 5);
                range2.retainAll(range);
                String totle=String.valueOf(range2.size());
                if(u1.getUserid()!=userid&&!range.contains(String.valueOf(u1.getUserid()))){
                    list.add(u1.getUserid()+":"+u1.getUsername()+":"+"您和她有"+totle+"位共同好友");
                }
            }
        }
        list=list.stream()
                .distinct()
                .collect(Collectors.toList());
        return list;
    }
}
