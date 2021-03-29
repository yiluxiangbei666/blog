package com.example.personinformation.love;

import lombok.Getter;

import java.io.Serializable;

@Getter
public enum LikedStatusEnum implements Serializable {
    LIKE("1", "点赞"),
    UNLIKE("0", "取消点赞/未点赞"),
    ;

    private String code;

    private String msg;

    LikedStatusEnum(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
