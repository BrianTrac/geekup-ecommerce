package org.example.geekup.helper;

import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class OrderNumberGenerator {
    private static final String ORDER_PREFIX = "ORD";

    public String generateOrderNumber() {
        String timestamp = String.valueOf(System.currentTimeMillis());
        String randomSuffix = String.format("%04d", new Random().nextInt(10000));
        return ORDER_PREFIX + timestamp + randomSuffix;
    }
}
