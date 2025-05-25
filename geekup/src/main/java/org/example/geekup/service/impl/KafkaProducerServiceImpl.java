package org.example.geekup.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.dto.message.OrderConfirmationMessage;
import org.example.geekup.service.KafkaProducerService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.stereotype.Service;

import java.util.concurrent.CompletableFuture;


@Service
@RequiredArgsConstructor
@Slf4j
public class KafkaProducerServiceImpl implements KafkaProducerService {

    private final KafkaTemplate<String, OrderConfirmationMessage> orderKafkaTemplate;

    @Value("${app.kafka.topics.order-confirmation}")
    private String orderConfirmationTopic;

    public void sendOrderConfirmation(OrderConfirmationMessage message) {
        orderKafkaTemplate.send(orderConfirmationTopic, message.getOrderId().toString(), message)
                .whenComplete((result, ex) -> {
                    if (ex == null) {
                        log.info("Order confirmation message sent for order: {}", message.getOrderNumber());
                    } else {
                        log.error("Failed to send order confirmation message for order: {}",
                                message.getOrderNumber(), ex);
                    }
                });
    }
}

