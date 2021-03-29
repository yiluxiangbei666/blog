package com.example.personinformation.service;

public interface RedisService {

    /**
     * 点赞。状态为1
     */
    void saveLiked2Redis(int userid, int articleid);

    /**
     * 取消点赞。将状态改变为0
     */
    void unlikeFromRedis(int userid, int articleid);

    /**
     * 从Redis中删除一条点赞数据
     */
    void deleteLikedFromRedis(int userid, int articleid);

    /**
     * 该用户的点赞数加1
     */
    void incrementLikedarticleCount(int articleid);

    /**
     * 该用户的点赞数减1
     */
    void decrementLikedarticleCount(int articleid);

}
