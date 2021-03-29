package com.example.personinformation.dao;


import com.example.personinformation.bean.reply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface replydao {
    public int addreply(reply r);
    public List<reply> listreply();
    public void deletereply(int replyid);
    public List<reply> listreplybyid(int articleid);
    public List<reply> listreplybyuserid(int userid);
}
