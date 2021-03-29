package com.example.personinformation.love;


import java.io.Serializable;

public class RedisKeyUtils implements Serializable {

    //保存用户点赞数据的key
    public static final String MAP_KEY_USER_LIKED = "MAP_USER_LIKED";
    //保存article被点赞数量的key
    public static final String article_user_like = "MAP_USER_LIKED_COUNT";

    /**
     * 拼接被点赞的用户id和点赞的人的id作为key。格式 222222::333333
     * @return
     */
    public static String getLikedKey(int userid, int articleid){
        String indexuserid=String.valueOf(userid);
        String indexarticleid=String.valueOf(articleid);
        System.out.println("indexuserid"+ indexuserid);
        StringBuilder builder = new StringBuilder();
        builder.append(indexuserid);
        builder.append("::");
        builder.append(indexarticleid);
        return builder.toString();
    }
    public static String getarticleid(int articleid){
        String indexarticleid=String.valueOf(articleid);
        StringBuilder builder = new StringBuilder();
        builder.append(indexarticleid);
        return builder.toString();
    }
    public static int getInteger(String money){
        int integer = Integer.parseInt(money);
        return integer;
    }
}