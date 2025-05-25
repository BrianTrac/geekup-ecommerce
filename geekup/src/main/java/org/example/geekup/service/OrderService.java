package org.example.geekup.service;

import org.example.geekup.dto.request.CreateOrderRequest;
import org.example.geekup.dto.response.OrderResponse;

public interface OrderService {

    OrderResponse createOrderWithPayment(CreateOrderRequest request);


}
