package com.example.personinformation.service;

import com.example.personinformation.bean.replyperson;

import java.util.List;

public interface replypersonservice {
    public int addreplyperson(replyperson r);
    public List<replyperson> listreplyperson();
    public void deletereplyperson(int replypersonid);
    public List<replyperson> listreplypersonbyreplyid(int replyid);
}
