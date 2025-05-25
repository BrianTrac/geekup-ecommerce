package org.example.geekup.service;

import org.example.geekup.dto.request.PaymentRequest;
import org.example.geekup.dto.response.PaymentResult;

import java.math.BigDecimal;

public interface PaymentGatewayService {
    PaymentResult processPayment(PaymentRequest paymentRequest, BigDecimal amount, String orderId);
}