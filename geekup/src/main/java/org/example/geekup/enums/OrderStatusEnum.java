package org.example.geekup.enums;

import lombok.Getter;

@Getter
public enum OrderStatusEnum {
    PENDING("Pending"),
    CONFIRMED("Confirmed"),
    PROCESSING("Processing"),
    SHIPPED("Shipped"),
    DELIVERED("Delivered"),
    CANCELLED("Cancelled"),
    REFUNDED("Refunded");

    private final String displayName;

    OrderStatusEnum(String displayName) {
        this.displayName = displayName;
    }
}
