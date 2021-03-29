package com.example.personinformation.bean;

import java.io.Serializable;

public class user implements Serializable {
    private int userid;
    private String username;
    private String password;
    private String phone;
    private String netname;
    private String position;
    private String corporation;
    private String introduction;

    public user(int userid, String username, String password, String phone, String netname, String position, String corporation, String introduction) {
        this.userid = userid;
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.netname = netname;
        this.position = position;
        this.corporation = corporation;
        this.introduction = introduction;
    }

    public user() {
    }

    public user(String username, String password, String phone, String netname, String position, String corporation, String introduction) {
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.netname = netname;
        this.position = position;
        this.corporation = corporation;
        this.introduction = introduction;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNetname() {
        return netname;
    }

    public void setNetname(String netname) {
        this.netname = netname;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCorporation() {
        return corporation;
    }

    public void setCorporation(String corporation) {
        this.corporation = corporation;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    @Override
    public String toString() {
        return "user{" +
                "userid='" + userid + '\'' +
                "username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", phone='" + phone + '\'' +
                ", netname='" + netname + '\'' +
                ", position='" + position + '\'' +
                ", corporation='" + corporation + '\'' +
                ", introduction='" + introduction + '\'' +
                '}';
    }
}
