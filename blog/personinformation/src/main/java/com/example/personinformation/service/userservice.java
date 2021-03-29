package com.example.personinformation.service;

import com.example.personinformation.bean.user;

import java.util.List;

public interface userservice {
    public int adduser(user u);
    public user getuser(user u);
    public user getuserbyId(int userid);
    public List<user> listuser();
    public void updateuser(user u);
    public void deleteuser(String username);
}
