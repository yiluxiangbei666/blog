package com.example.personinformation.bean;

public class replyperson {

    private int replypersonid;
    private int replyid;
    private int userid;
    private String username;
    private String replycontent;

    public replyperson() {
    }

    public replyperson(int replyid, int userid, String username, String replycontent) {
        this.replyid = replyid;
        this.userid = userid;
        this.username = username;
        this.replycontent = replycontent;
    }

    public replyperson(int replypersonid, int replyid, int userid, String username, String replycontent) {
        this.replypersonid = replypersonid;
        this.replyid = replyid;
        this.userid = userid;
        this.username = username;
        this.replycontent = replycontent;
    }

    public int getReplypersonid() {
        return replypersonid;
    }

    public void setReplypersonid(int replypersonid) {
        this.replypersonid = replypersonid;
    }

    public int getReplyid() {
        return replyid;
    }

    public void setReplyid(int replyid) {
        this.replyid = replyid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getReplycontent() {
        return replycontent;
    }

    public void setReplycontent(String replycontent) {
        this.replycontent = replycontent;
    }

    @Override
    public String toString() {
        return "replyperson{" +
                "replypersonid=" + replypersonid +
                ", replyid=" + replyid +
                ", userid=" + userid +
                ", username='" + username + '\'' +
                ", replycontent='" + replycontent + '\'' +
                '}';
    }
}
