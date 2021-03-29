package com.example.personinformation.service.impl;

import com.example.personinformation.bean.article;
import com.example.personinformation.dao.articledao;
import com.example.personinformation.service.articleservice;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class articleserviceimpl  implements articleservice {
    @Resource
    private articledao adao;

    @Override
    public List<article> getuserarticle(int userid) {
        return adao.getuserarticle(userid);
    }

    @Override
    public article getarticlebyarticleid(int articleid) {
        return adao.getarticlebyarticleid(articleid);
    }

    @Override
    public int addarticle(article a) {
        return adao.addarticle(a);
    }

    @Override
    public article getarticle(String articletitle) {
        return adao.getarticle(articletitle);
    }

    @Override
    public List<article> listarticle() {
        return adao.listarticle();
    }

    @Override
    public void updatearticle(article a) {
        adao.updatearticle(a);
    }

    @Override
    public void deletearticle(String title) {
        adao.deletearticle(title);
    }
}
