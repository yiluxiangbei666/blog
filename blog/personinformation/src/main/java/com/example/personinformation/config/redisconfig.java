package com.example.personinformation.config;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.CachingConfigurerSupport;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;

/**
 * redis配置类
 *
 **/
@Configuration
@EnableCaching//开启注解
public class redisconfig extends CachingConfigurerSupport {
    @Bean
    public CacheManager cacheManager(@SuppressWarnings("rawtypes") RedisConnectionFactory redisTemplate) {
        RedisCacheManager cacheManager = RedisCacheManager.create(redisTemplate);

        return cacheManager;
    }
    // 以下两种redisTemplate自由根据场景选择
    @Bean
    public RedisTemplate<String, String> redisTemplate(RedisConnectionFactory connectionFactory) {
        StringRedisTemplate template = new StringRedisTemplate(connectionFactory);
        @SuppressWarnings({ "rawtypes", "unchecked" })
        Jackson2JsonRedisSerializer jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer(Object.class);
        ObjectMapper om = new ObjectMapper();
        om.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        om.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        jackson2JsonRedisSerializer.setObjectMapper(om);
        template.setValueSerializer(jackson2JsonRedisSerializer);
        template.afterPropertiesSet();
//        template.setEnableTransactionSupport(true);
        return template;
    }
    @Bean
    public JedisConnectionFactory redisConnectionFactory() {
          JedisConnectionFactory factory = new JedisConnectionFactory();
          factory.setHostName("127.0.0.1");
          factory.setPort(6379);
          factory.setTimeout(3000); //设置连接超时时间
          return factory;
    }
}