package com.example.personinformation.service.impl;

import com.example.personinformation.bean.user;
import com.example.personinformation.dao.userdao;
import com.example.personinformation.service.userservice;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class userserviceimpl implements userservice {
    @Resource
    private userdao udao;

    @Override
    public user getuserbyId(int userid) {
        return  udao.getuserbyid(userid);
    }

    @Override
    public int adduser(user u) {
        return udao.adduser(u);
    }

    @Override
    public user getuser(user u) {
        return udao.getuser(u);
    }

    @Override
    public List<user> listuser() {
        return udao.listuser();
    }

    @Override
    public void updateuser(user u) {
        udao.updateuser(u);
    }
    @Override
    public void deleteuser(String username) {
        udao.deleteuser(username);
    }
}
