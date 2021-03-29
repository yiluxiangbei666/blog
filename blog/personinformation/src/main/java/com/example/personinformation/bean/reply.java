package com.example.personinformation.bean;

import java.io.Serializable;

public class reply implements Serializable {
    private int replyid;
    private int articleid;
    private int userid;
    private String content;
    private String username;

    public reply(int replyid, int articleid, int userid, String content, String username) {
        this.replyid = replyid;
        this.articleid = articleid;
        this.userid = userid;
        this.content = content;
        this.username = username;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public reply() {
    }

    public reply(int replyid, int articleid, int userid, String content) {
        this.replyid = replyid;
        this.articleid = articleid;
        this.userid = userid;
        this.content = content;
    }

    public int getReplyid() {
        return replyid;
    }

    public void setReplyid(int replyid) {
        this.replyid = replyid;
    }

    public int getArticleid() {
        return articleid;
    }

    public void setArticleid(int articleid) {
        this.articleid = articleid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public reply(int articleid, int userid, String content) {
        this.articleid = articleid;
        this.userid = userid;
        this.content = content;
    }

    @Override
    public String toString() {
        return "reply{" +
                "replyid=" + replyid +
                ", articleid=" + articleid +
                ", userid=" + userid +
                ", content='" + content + '\'' +
                ", username='" + username + '\'' +
                '}';
    }
}
