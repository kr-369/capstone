package com.example.common.enums;

public enum LikesModuleEnum {
    POST("Post"),
    ITEM("Item");

    private String value;

    public String getValue() {
        return value;
    }

    LikesModuleEnum(String value) {
        this.value = value;
    }
}
