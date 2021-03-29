package com.example.personinformation.bean;

public class msg {
    private String user_if_love;
    private String article_love_amount;
    private String money;

    public msg(String money) {
        this.money = money;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public msg() {
    }

    public msg(String user_if_love, String article_love_amount) {
        this.user_if_love = user_if_love;
        this.article_love_amount = article_love_amount;
    }

    public String getUser_if_love() {
        return user_if_love;
    }

    public void setUser_if_love(String user_if_love) {
        this.user_if_love = user_if_love;
    }

    public String getArticle_love_amount() {
        return article_love_amount;
    }

    public void setArticle_love_amount(String article_love_amount) {
        this.article_love_amount = article_love_amount;
    }

    @Override
    public String toString() {
        return "msg{" +
                "user_if_love='" + user_if_love + '\'' +
                ", article_love_amount='" + article_love_amount + '\'' +
                '}';
    }
}
