package com.example.personinformation.service.impl;

import com.example.personinformation.bean.replyperson;
import com.example.personinformation.dao.replypersondao;
import com.example.personinformation.service.replypersonservice;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class replypersonserivceimpl implements replypersonservice {

    @Resource
    private replypersondao rpdao;

    @Override
    public int addreplyperson(replyperson r) {
        return rpdao.addreplyperson(r);
    }

    @Override
    public List<replyperson> listreplyperson() {
        return rpdao.listreplyperson();
    }

    @Override
    public void deletereplyperson(int replypersonid) {
        rpdao.deletereplyperson(replypersonid);
    }

    @Override
    public List<replyperson> listreplypersonbyreplyid(int replyid) {
        return rpdao.listreplypersonbyreplyid(replyid);
    }
}
