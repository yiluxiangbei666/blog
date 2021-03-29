package com.example.personinformation.service;

import com.example.personinformation.bean.usermsg;

import java.util.List;


public interface usermsgservice {
    public int addusermsg(usermsg umsg);
    public void deleteusermsg(int userid);
    public List<usermsg> getMsglist(int toUser);
}
