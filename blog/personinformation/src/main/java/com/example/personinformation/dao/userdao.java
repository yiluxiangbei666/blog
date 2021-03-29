package com.example.personinformation.dao;

import com.example.personinformation.bean.user;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface userdao {
    public int adduser(user u);
    public user getuser(user u);
    public user getuserbyid(int userid);
    public List<user> listuser();
    public void updateuser(user u);
    public void deleteuser(String username);
}
