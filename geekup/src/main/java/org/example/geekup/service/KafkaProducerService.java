package org.example.geekup.service;

import org.example.geekup.dto.message.OrderConfirmationMessage;

public interface KafkaProducerService {
    void sendOrderConfirmation(OrderConfirmationMessage message);
}
