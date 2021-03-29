package com.example.personinformation.bean;

import java.io.Serializable;

public class book1 implements Serializable {
    private int bookid;
    private String booktitle;
    private String bookinductor;
    private int userid;

    public book1(int bookid, String booktitle, String bookinductor, int userid) {
        this.bookid = bookid;
        this.booktitle = booktitle;
        this.bookinductor = bookinductor;
        this.userid = userid;
    }

    public book1() {
    }

    public book1(String booktitle, String bookinductor, int userid) {
        this.booktitle = booktitle;
        this.bookinductor = bookinductor;
        this.userid = userid;
    }

    public String getBooktitle() {
        return booktitle;
    }

    public int getBookid() {
        return bookid;
    }

    public void setBookid(int bookid) {
        this.bookid = bookid;
    }

    public void setBooktitle(String booktitle) {
        this.booktitle = booktitle;
    }

    public String getBookinductor() {
        return bookinductor;
    }

    public void setBookinductor(String bookinductor) {
        this.bookinductor = bookinductor;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    @Override
    public String toString() {
        return "book{" +
                "booktitle='" + booktitle + '\'' +
                ", bookinductor='" + bookinductor + '\'' +
                ", userid=" + userid +
                '}';
    }
}
