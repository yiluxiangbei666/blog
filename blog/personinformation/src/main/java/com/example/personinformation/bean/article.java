package com.example.personinformation.bean;

import java.io.Serializable;

public class article implements Serializable {
    private int articleid;
    private String articletitle;
    private String articlecontent;
    private int userid;
    private String date;
    private int loveamount;

    public article(int articleid, int loveamount) {
        this.articleid = articleid;
        this.loveamount = loveamount;
    }

    public article() {
    }

    public article(int articleid, String articletitle, String articlecontent, int userid, String date, int loveamount) {
        this.articleid = articleid;
        this.articletitle = articletitle;
        this.articlecontent = articlecontent;
        this.userid = userid;
        this.date = date;
        this.loveamount = loveamount;
    }

    public article(String articletitle, String articlecontent, int userid, String date, int loveamount) {
        this.articletitle = articletitle;
        this.articlecontent = articlecontent;
        this.userid = userid;
        this.date = date;
        this.loveamount = loveamount;
    }

    public int getArticleid() {
        return articleid;
    }

    public void setArticleid(int articleid) {
        this.articleid = articleid;
    }

    public String getArticletitle() {
        return articletitle;
    }

    public void setArticletitle(String articletitle) {
        this.articletitle = articletitle;
    }

    public String getArticlecontent() {
        return articlecontent;
    }

    public void setArticlecontent(String articlecontent) {
        this.articlecontent = articlecontent;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getLoveamount() {
        return loveamount;
    }

    public void setLoveamount(int loveamount) {
        this.loveamount = loveamount;
    }

    @Override
    public String toString() {
        return "article{" +
                "articletitle='" + articletitle + '\'' +
                ", articlecontent='" + articlecontent + '\'' +
                ", userid=" + userid +
                ", date='" + date + '\'' +
                ", loveamount=" + loveamount +
                '}';
    }
}
