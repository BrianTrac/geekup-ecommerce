package org.example.geekup.service.impl;

import org.example.geekup.dto.request.PaymentRequest;
import org.example.geekup.dto.response.PaymentResult;
import org.example.geekup.enums.PaymentStatus;
import org.example.geekup.service.PaymentGatewayService;
import org.springframework.context.annotation.Primary;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.UUID;

// Mock Payment Gateway Implementation
@Service
@Primary
public class MockPaymentGatewayService implements PaymentGatewayService {

    @Override
    public PaymentResult processPayment(PaymentRequest paymentRequest, BigDecimal amount, String orderId) {
        // Simulate payment processing delay
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }

        // Mock payment logic - 95% success rate
        boolean success = Math.random() > 0.05;

        if (success) {
            return PaymentResult.builder()
                    .success(true)
                    .transactionId("TXN_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase())
                    .status(PaymentStatus.COMPLETED)
                    .gatewayResponse("Payment processed successfully")
                    .build();
        } else {
            return PaymentResult.builder()
                    .success(false)
                    .status(PaymentStatus.FAILED)
                    .errorMessage("Payment failed - Insufficient funds")
                    .gatewayResponse("DECLINE")
                    .build();
        }
    }
}