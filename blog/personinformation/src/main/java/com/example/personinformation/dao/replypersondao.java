package com.example.personinformation.dao;

import com.example.personinformation.bean.reply;
import com.example.personinformation.bean.replyperson;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface replypersondao {
    public int addreplyperson(replyperson r);
    public List<replyperson> listreplyperson();
    public void deletereplyperson(int replypersonid);
    public List<replyperson> listreplypersonbyreplyid(int replyid);
}
