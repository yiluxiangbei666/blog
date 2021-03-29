package com.example.personinformation.dao;

import com.example.personinformation.bean.article;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface articledao {
    public int addarticle(article a);
    public article getarticle(String articletitle);
    public article getarticlebyarticleid(int articleid);
    public List<article> listarticle();
    public List<article> getuserarticle(int userid);
    public void updatearticle(article a);
    public void deletearticle(String articletitle);
}
