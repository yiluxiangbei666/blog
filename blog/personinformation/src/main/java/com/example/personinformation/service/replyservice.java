package com.example.personinformation.service;

import com.example.personinformation.bean.reply;

import java.util.List;

public interface replyservice {
    public int addreply(reply r);
    public List<reply> listreply();
    public void deletereply(int replyid);
    public List<reply> listreplybyid(int articleid);
    public List<reply> listreplybyuserid(int userid);
}
