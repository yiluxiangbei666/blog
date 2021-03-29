package com.example.personinformation.dao;


import com.example.personinformation.bean.usermsg;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface usermsgdao {
    public int addusermsg(usermsg umsg);
    public void deleteusermsg(int userid);
    public List<usermsg> getMsglist(int toUser);
}
