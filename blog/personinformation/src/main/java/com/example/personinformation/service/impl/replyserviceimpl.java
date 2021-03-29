package com.example.personinformation.service.impl;

import com.example.personinformation.bean.reply;
import com.example.personinformation.dao.replydao;
import com.example.personinformation.service.replyservice;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class replyserviceimpl implements replyservice {
    @Resource
    private replydao rdao;

    @Override
    public List<reply> listreplybyid(int articleid) {
        return rdao.listreplybyid(articleid);
    }

    @Override
    public List<reply> listreplybyuserid(int userid) {
        return rdao.listreplybyuserid(userid);
    }

    @Override
    public int addreply(reply r) {
        return rdao.addreply(r);
    }

    @Override
    public List<reply> listreply() {
        return rdao.listreply();
    }

    @Override
    public void deletereply(int replyid) {
        rdao.deletereply(replyid);
    }
}
