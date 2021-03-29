package com.example.personinformation.service.impl;

import com.example.personinformation.love.LikedStatusEnum;
import com.example.personinformation.love.RedisKeyUtils;
import com.example.personinformation.service.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
@Slf4j
public class RedisServiceImpl implements RedisService {

    @Resource
    RedisTemplate redisTemplate;

    @Override
    public void saveLiked2Redis(int userid, int articleid) {
        String key = RedisKeyUtils.getLikedKey(userid, articleid);
        redisTemplate.opsForHash().put(RedisKeyUtils.MAP_KEY_USER_LIKED, key, LikedStatusEnum.LIKE.getCode());
    }

    @Override
    public void unlikeFromRedis(int userid, int articleid) {
        String key = RedisKeyUtils.getLikedKey(userid, articleid);
        redisTemplate.opsForHash().put(RedisKeyUtils.MAP_KEY_USER_LIKED, key, LikedStatusEnum.UNLIKE.getCode());
    }

    @Override
    public void deleteLikedFromRedis(int userid, int articleid) {
        String key = RedisKeyUtils.getLikedKey(userid, articleid);
        redisTemplate.opsForHash().delete(RedisKeyUtils.MAP_KEY_USER_LIKED, key);
    }

    @Override
    public void incrementLikedarticleCount(int articleid) {
        redisTemplate.opsForHash().increment(RedisKeyUtils.article_user_like, articleid, 1);
    }

    @Override
    public void decrementLikedarticleCount(int articleid) {
        redisTemplate.opsForHash().increment(RedisKeyUtils.article_user_like, articleid, -1);
    }
}
