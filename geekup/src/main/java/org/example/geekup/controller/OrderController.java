package org.example.geekup.controller;

import jakarta.validation.Valid;
import jakarta.validation.ValidationException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.dto.request.CreateOrderRequest;
import org.example.geekup.dto.response.ApiResponse;
import org.example.geekup.dto.response.OrderResponse;
import org.example.geekup.exception.OrderProcessingException;
import org.example.geekup.service.OrderService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.UUID;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
@Slf4j
@Validated
public class OrderController {

    private final OrderService orderService;

    @PostMapping
    public ResponseEntity<ApiResponse<OrderResponse>> createOrder(
            @Valid @RequestBody CreateOrderRequest request) {

        log.info("Received order creation request for user: {}", request.getUserId());

        try {
            OrderResponse orderResponse = orderService.createOrderWithPayment(request);

            ApiResponse<OrderResponse> response = ApiResponse.<OrderResponse>builder()
                    .success(true)
                    .message("Order created successfully")
                    .data(orderResponse)
                    .build();

            return ResponseEntity.status(HttpStatus.CREATED).body(response);

        } catch (ValidationException e) {
            log.warn("Validation error creating order: {}", e.getMessage());
            throw e;
        } catch (OrderProcessingException e) {
            log.error("Error processing order: {}", e.getMessage(), e);
            throw e;
        }
    }

//    @GetMapping("/{orderId}")
//    public ResponseEntity<ApiResponse<OrderResponse>> getOrder(@PathVariable UUID orderId) {
//        OrderResponse orderResponse = orderService.getOrder(orderId);
//
//        ApiResponse<OrderResponse> response = ApiResponse.<OrderResponse>builder()
//                .success(true)
//                .message("Order retrieved successfully")
//                .data(orderResponse)
//                .build();
//
//        return ResponseEntity.ok(response);
//    }
//
//    @GetMapping("/user/{userId}")
//    public ResponseEntity<ApiResponse<Page<OrderResponse>>> getUserOrders(
//            @PathVariable UUID userId,
//            @RequestParam(defaultValue = "0") int page,
//            @RequestParam(defaultValue = "10") int size,
//            @RequestParam(defaultValue = "createdAt") String sortBy,
//            @RequestParam(defaultValue = "desc") String sortDir) {
//
//        Sort sort = sortDir.equalsIgnoreCase("desc") ?
//                Sort.by(sortBy).descending() :
//                Sort.by(sortBy).ascending();
//
//        Pageable pageable = PageRequest.of(page, size, sort);
//        Page<OrderResponse> orders = orderService.getUserOrders(userId, pageable);
//
//        ApiResponse<Page<OrderResponse>> response = ApiResponse.<Page<OrderResponse>>builder()
//                .success(true)
//                .message("User orders retrieved successfully")
//                .data(orders)
//                .build();
//
//        return ResponseEntity.ok(response);
//    }
}