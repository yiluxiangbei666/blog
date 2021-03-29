package com.example.personinformation.service;

import com.example.personinformation.bean.article;

import java.util.List;

public interface articleservice {
    public int addarticle(article a);
    public article getarticle(String articletitle);
    public article getarticlebyarticleid(int articleid);
    public List<article> listarticle();
    public void updatearticle(article a);
    public void deletearticle(String title);
    public List<article> getuserarticle(int userid);
}
