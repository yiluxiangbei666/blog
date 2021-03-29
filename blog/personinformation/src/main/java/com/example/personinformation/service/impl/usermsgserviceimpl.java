package com.example.personinformation.service.impl;

import com.example.personinformation.bean.usermsg;
import com.example.personinformation.dao.usermsgdao;
import com.example.personinformation.service.usermsgservice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("usermsgserviceimpl")
public class usermsgserviceimpl implements usermsgservice {
    @Autowired
    usermsgdao umsgdao;
    @Override
    public int addusermsg(usermsg umsg) {
        return umsgdao.addusermsg(umsg);
    }

    @Override
    public void deleteusermsg(int userid) {
        umsgdao.deleteusermsg(userid);
    }

    @Override
    public List<usermsg> getMsglist(int toUser) {
        return umsgdao.getMsglist(toUser);
    }
}
