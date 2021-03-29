package com.example.personinformation.controller;

import com.example.personinformation.love.RedisKeyUtils;
import com.example.personinformation.service.impl.JDsearch;
import org.apache.commons.lang3.ArrayUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.*;

@Controller
public class JDController {
    @Autowired
    JDsearch jDsearch;
    @Resource
    private RedisTemplate redisTemplate;



    @GetMapping("/search/{keyword}/{pageNo}/{pageSize}")
    @ResponseBody
    public List<Map<String,Object>> searchlist(@PathVariable("keyword")String keyword, @PathVariable("pageNo")int pageNo, @PathVariable("pageSize")int pageSize) throws Exception {
        return jDsearch.searchPage(keyword,pageNo,pageSize);
    }
    @PostMapping("/addbook")
    public String addbook(String price, String title, MultipartFile[] multipart, HttpServletRequest request) throws Exception {
        MultipartFile[] multipartFiles = multipart;
        System.out.println(price+" "+title+" "+multipart);
        if(ArrayUtils.isNotEmpty(multipartFiles)) {

            Arrays.stream(multipartFiles).forEach((MultipartFile multipartFile)->{
                        if (!multipartFile.isEmpty()) {
                            try {
                                String dir = "upload/";
//                                String targetDir = request.getSession().getServletContext().getRealPath(dir);
                                String targetDir = "D:\\学习资料\\框架实验\\com.fuguanzheng\\carplat\\personinformation\\src\\main\\webapp\\img";
                                Path targetDirFile = Paths.get(targetDir); // File new File()-->Path  Paths.get() 新的对象
                                if (Files.notExists(targetDirFile)) {
                                    Files.createDirectories(targetDirFile);
                                }
                                String fileName = multipartFile.getOriginalFilename();
                                Path target = Paths.get(targetDir, fileName);
                                multipartFile.transferTo(target.toFile());
                                jDsearch.addbook(price,title,"//img//"+fileName);
                            } catch (IOException e) {
                                e.printStackTrace();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    }
            );
        }
        return "books";
    }

    @GetMapping("/buybook/{userid}/{booktitle}/{bookprice}")
    @ResponseBody
    public int buybook(@PathVariable("userid")Integer userid,@PathVariable("booktitle")String booktitle,@PathVariable("bookprice")String bookprice ) throws Exception {
        String useridkey = RedisKeyUtils.getarticleid(userid);
        String o = (String)redisTemplate.opsForValue().get(useridkey + "money");
        String[] ￥s = bookprice.split("￥");
        float i = Float.valueOf(o).floatValue() - Float.valueOf(￥s[1]).floatValue();
        if(i>=0){
           redisTemplate.opsForValue().set(useridkey + "money",String.valueOf(i));
            redisTemplate.opsForList().leftPush(useridkey+"buyedbook",booktitle+":"+bookprice);
            System.out.println(userid+","+bookprice+","+booktitle);
            return 1;
        }
        else{
            return 0;
        }
    }
    @GetMapping("/addbookcar/{userid}/{booktitle}/{bookprice}")
    @ResponseBody
    public int addbookcar(@PathVariable("userid")Integer userid,@PathVariable("booktitle")String booktitle,@PathVariable("bookprice")String bookprice ) throws Exception {
        String useridkey = RedisKeyUtils.getarticleid(userid);
        Set range = redisTemplate.opsForZSet().range(useridkey + "bookcar", 0, -1);
        Iterator iterator = range.iterator();
        boolean is_same=false;
        while (iterator.hasNext()){
            String next = (String)iterator.next();
            if(next.equals(booktitle+":"+bookprice)){
                is_same=true;
            }
        }
        if(is_same){
            redisTemplate.opsForZSet().incrementScore(useridkey+"bookcar",booktitle+":"+bookprice,1);
        }else {
            redisTemplate.opsForZSet().add(useridkey+"bookcar",booktitle+":"+bookprice,1);
        }
        System.out.println(userid+","+bookprice+","+booktitle);
        return 1;
    }
    @GetMapping("/querymybuyedbook")
    @ResponseBody
    public  List<String>  querymybuyedbook(int userid) throws Exception {
        String useridkey= RedisKeyUtils.getarticleid(userid);
        List<String> range = redisTemplate.opsForList().range(useridkey + "buyedbook", 0, 15);
        return range;
    }
    @GetMapping("/querymybookcar")
    @ResponseBody
    public  List<String>  querymybookcar(int userid) throws Exception {
        String useridkey = RedisKeyUtils.getarticleid(userid);
        Set range = redisTemplate.opsForZSet().range(useridkey + "bookcar", 0, 15);
        Iterator iterator = range.iterator();
        List<String> list=new ArrayList<>();
        while (iterator.hasNext()){
            String next = (String)iterator.next();
            Double score = redisTemplate.opsForZSet().score(useridkey + "bookcar", next);
            System.out.println(score);
            StringBuffer value=new StringBuffer();
            value.append(next);
            value.append(":");
            value.append(String.valueOf(score));
            list.add(value.toString());
        }
        return list;
    }
    @GetMapping("/deletemybookcar")
    @ResponseBody
    public  int deletemybookcar(int userid,String title,String price) throws Exception {
        System.out.println(userid+" "+title+" "+price);
        String useridkey = RedisKeyUtils.getarticleid(userid);
        Double score = redisTemplate.opsForZSet().score(useridkey + "bookcar", title+":"+price);
        System.out.println(score);
        if(score>1){
            redisTemplate.opsForZSet().incrementScore(useridkey+"bookcar",title+":"+price,-1);
        }else {
            redisTemplate.opsForZSet().remove(useridkey+"bookcar",title+":"+price);
        }
        return 1;
    }
}
