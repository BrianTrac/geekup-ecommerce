package org.example.geekup.service.impl;

import jakarta.validation.Valid;
import jakarta.validation.ValidationException;
import jakarta.validation.constraints.NotNull;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.dto.message.OrderConfirmationMessage;
import org.example.geekup.dto.message.OrderItemMessage;
import org.example.geekup.dto.request.CreateOrderRequest;
import org.example.geekup.dto.request.OrderItemRequest;
import org.example.geekup.dto.request.PaymentRequest;
import org.example.geekup.dto.response.OrderItemResponse;
import org.example.geekup.dto.response.OrderResponse;
import org.example.geekup.dto.response.PaymentResponse;
import org.example.geekup.dto.response.PaymentResult;
import org.example.geekup.entity.*;
import org.example.geekup.enums.OrderStatusEnum;
import org.example.geekup.exception.OrderProcessingException;
import org.example.geekup.helper.OrderCalculation;
import org.example.geekup.helper.OrderItemCalculation;
import org.example.geekup.helper.OrderNumberGenerator;
import org.example.geekup.helper.ProductVariant;
import org.example.geekup.mapper.OrderConfirmationMapper;
import org.example.geekup.mapper.OrderItemMapper;
import org.example.geekup.mapper.OrderMapper;
import org.example.geekup.mapper.PaymentMapper;
import org.example.geekup.repository.OrderRepository;
import org.example.geekup.repository.PaymentMethodRepository;
import org.example.geekup.repository.PaymentRepository;
import org.example.geekup.service.*;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final PaymentRepository paymentRepository;
    private final PaymentMethodRepository paymentMethodRepository;
    private final PaymentGatewayService paymentGatewayService;
    private final KafkaProducerService kafkaProducerService;
    private final OrderNumberGenerator orderNumberGenerator;

    // MapStruct mappers
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final PaymentMapper paymentMapper;
    private final OrderConfirmationMapper orderConfirmationMapper;

    // Other services
    private final ProductVariantService productVariantService;
    private final InventoryService inventoryService;
    private final UserService userService;
    private final VoucherService voucherService;
    private final OrderStatusService orderStatusService;

    public OrderResponse createOrderWithPayment(CreateOrderRequest request) {
        log.info("Creating order for user: {}", request.getUserId());

        try {
            // 1. Validate request and check inventory
            validateOrderRequest(request);

            // 2. Calculate order totals
            OrderCalculation calculation = calculateOrderTotals(request);

            // 3. Create order entity using MapStruct
            Order order = createOrderEntityWithMapper(request, calculation);

            // 4. Save order
            order = orderRepository.save(order);

            // 5. Process payment
            PaymentResult paymentResult = processOrderPayment(order, request.getPaymentRequest());

            // 6. Create payment record
            Payment payment = createPaymentRecord(order, paymentResult, request.getPaymentMethodId());

            // 7. Update order status based on payment result
            updateOrderStatusAfterPayment(order, paymentResult);

            // 8. Reserve inventory if payment successful
            if (paymentResult.isSuccess()) {
                reserveOrderInventory(order);

                // 9. Send order confirmation message to Kafka (async)
                sendOrderConfirmationMessageWithMapper(order, payment);
            }

            // 10. Build and return response using MapStruct
            return buildOrderResponseWithMapper(order, payment);

        } catch (Exception e) {
            log.error("Error creating order for user: {}", request.getUserId(), e);
            throw new OrderProcessingException("Failed to create order: " + e.getMessage());
        }
    }

    private Order createOrderEntityWithMapper(CreateOrderRequest request, OrderCalculation calculation) {
        // Use MapStruct to create base order
        Order order = orderMapper.toEntity(request);

        // Set calculated values
        order.setOrderNumber(orderNumberGenerator.generateOrderNumber());
        order.setSubtotal(calculation.getSubtotal());
        order.setVoucherDiscountAmount(calculation.getVoucherDiscountAmount());
        order.setTaxAmount(calculation.getTaxAmount());
        order.setBaseShippingFee(calculation.getBaseShippingFee());
        order.setTotalAmount(calculation.getTotalAmount());
        order.setOrderStatusId(orderStatusService.getStatusId(OrderStatusEnum.PENDING));
        order.setCreatedBy(request.getUserId());

        // Create order items using MapStruct and set calculated prices
        List<OrderItem> orderItems = new ArrayList<>();
        for (int i = 0; i < request.getOrderItems().size(); i++) {
            OrderItemRequest itemRequest = request.getOrderItems().get(i);
            OrderItemCalculation itemCalc = calculation.getItemCalculations().get(i);

            OrderItem orderItem = orderItemMapper.toEntity(itemRequest);
            orderItem.setOrder(order);
            orderItem.setUnitPrice(itemCalc.getUnitPrice());
            orderItem.setTotalPrice(itemCalc.getTotalPrice());
            orderItem.setCreatedBy(request.getUserId());

            orderItems.add(orderItem);
        }

        order.setOrderItems(orderItems);
        return order;
    }

    private void sendOrderConfirmationMessageWithMapper(Order order, Payment payment) {
        try {
            // Get user information
            User user = userService.getUser(order.getUserId());

            // Get shipping address
            String shippingAddress = userService.getFormattedAddress(order.getShippingAddressId());

            // Get payment method name
            // CHECK LATER
            String paymentMethodName = getPaymentMethodName(payment.getPaymentMethodId());

            // Use MapStruct to create base message
            OrderConfirmationMessage message = orderConfirmationMapper.toMessage(order);

            // Set additional fields that couldn't be mapped directly
            message.setOrderId(order.getId());
            message.setUserEmail(user.getEmail());
            message.setUserName(user.getName());
            message.setShippingAddress(shippingAddress);
            message.setPaymentMethod(paymentMethodName);

            // Map order items with product names
            List<OrderItemMessage> orderItemMessages = order.getOrderItems().stream()
                    .map(item -> {
                        OrderItemMessage itemMessage = orderConfirmationMapper.toItemMessage(item);
                        ProductVariant variant = productVariantService.getVariant(item.getProductVariantId());
                        itemMessage.setProductName(variant.getProductName());
                        return itemMessage;
                    })
                    .collect(Collectors.toList());

            message.setOrderItems(orderItemMessages);

            kafkaProducerService.sendOrderConfirmation(message);

        } catch (Exception e) {
            log.error("Failed to send order confirmation message for order: {}", order.getOrderNumber(), e);
        }
    }

    private OrderResponse buildOrderResponseWithMapper(Order order, Payment payment) {
        // Use MapStruct to create base response
        OrderResponse response = orderMapper.toResponse(order);

        // Set status name
        response.setStatus(orderStatusService.getStatusName(order.getOrderStatusId()));

        // Set payment response if payment exists
        if (payment != null) {
            PaymentResponse paymentResponse = paymentMapper.toResponse(payment);
            response.setPayment(paymentResponse);
        }

        // Map order items
        List<OrderItemResponse> itemResponses = orderItemMapper.toResponseList(order.getOrderItems());
        response.setOrderItems(itemResponses);

        return response;
    }

    private String getPaymentMethodName(UUID paymentMethodId) {
        return paymentMethodRepository.findByIdAndIsDeletedFalse(paymentMethodId)
                .map(PaymentMethod::getMethodName)
                .orElse("Unknown Payment Method");
    }


    private void validateOrderRequest(CreateOrderRequest request) {
        if (!userService.userExists(request.getUserId())) {
            throw new ValidationException("User not found");
        }

        if (!userService.addressBelongsToUser(request.getShippingAddressId(), request.getUserId())) {
            throw new ValidationException("Invalid shipping address");
        }

        for (OrderItemRequest item : request.getOrderItems()) {
            if (!productVariantService.isVariantActiveAndAvailable(item.getProductVariantId())) {
                throw new ValidationException("Product variant not available: " + item.getProductVariantId());
            }
        }

        for (OrderItemRequest item : request.getOrderItems()) {
            if (!inventoryService.isQuantityAvailable(item.getProductVariantId(), item.getQuantity())) {
                throw new ValidationException("Insufficient inventory for product: " + item.getProductVariantId());
            }
        }
    }

    private OrderCalculation calculateOrderTotals(CreateOrderRequest request) {
        BigDecimal subtotal = BigDecimal.ZERO;
        List<OrderItemCalculation> itemCalculations = new ArrayList<>();

        for (OrderItemRequest itemRequest : request.getOrderItems()) {
            ProductVariant variant = productVariantService.getVariant(itemRequest.getProductVariantId());
            BigDecimal unitPrice = variant.getFinalPrice();
            BigDecimal itemTotal = unitPrice.multiply(BigDecimal.valueOf(itemRequest.getQuantity()));

            itemCalculations.add(OrderItemCalculation.builder()
                    .variantId(itemRequest.getProductVariantId())
                    .quantity(itemRequest.getQuantity())
                    .unitPrice(unitPrice)
                    .totalPrice(itemTotal)
                    .build());

            subtotal = subtotal.add(itemTotal);
        }

        BigDecimal voucherDiscount = BigDecimal.ZERO;
        if (request.getVoucherId() != null) {
            voucherDiscount = voucherService.calculateDiscount(request.getVoucherId(), subtotal);
        }

        BigDecimal shippingFee = calculateShippingFee(request.getShippingAddressId(), subtotal);
        BigDecimal taxAmount = subtotal.subtract(voucherDiscount).multiply(BigDecimal.valueOf(0.1));
        BigDecimal totalAmount = subtotal.subtract(voucherDiscount).add(taxAmount).add(shippingFee);

        return OrderCalculation.builder()
                .subtotal(subtotal)
                .voucherDiscountAmount(voucherDiscount)
                .taxAmount(taxAmount)
                .baseShippingFee(shippingFee)
                .totalAmount(totalAmount)
                .itemCalculations(itemCalculations)
                .build();
    }

    private BigDecimal calculateShippingFee(UUID shippingAddressId, BigDecimal subtotal) {
        if (subtotal.compareTo(BigDecimal.valueOf(100)) >= 0) {
            return BigDecimal.ZERO;
        }
        return BigDecimal.valueOf(10.00);
    }

    private PaymentResult processOrderPayment(Order order, @Valid PaymentRequest paymentRequest) {
        log.info("Processing payment for order: {}", order.getOrderNumber());
        return paymentGatewayService.processPayment(paymentRequest, order.getTotalAmount(), order.getOrderNumber());
    }

    private Payment createPaymentRecord(Order order, PaymentResult paymentResult, @NotNull(message = "Payment method ID is required") UUID paymentMethodId) {
        Payment payment = Payment.builder()
                .orderId(order.getId())
                .paymentMethodId(paymentMethodId)
                .amount(order.getTotalAmount())
                .status(paymentResult.getStatus())
                .transactionId(paymentResult.getTransactionId())
                .paymentGateway("MOCK_GATEWAY")
                .gatewayResponse(paymentResult.getGatewayResponse())
                .processedAt(paymentResult.isSuccess() ? LocalDateTime.now() : null)
                .build();

        return paymentRepository.save(payment);
    }

    private void updateOrderStatusAfterPayment(Order order, PaymentResult paymentResult) {
        if (paymentResult.isSuccess()) {
            UUID confirmedStatusId = orderStatusService.getStatusId(OrderStatusEnum.CONFIRMED);
            order.setOrderStatusId(confirmedStatusId);
            order.setConfirmedAt(LocalDateTime.now());
        } else {
            UUID cancelledStatusId = orderStatusService.getStatusId(OrderStatusEnum.CANCELLED);
            order.setOrderStatusId(cancelledStatusId);
        }

        orderRepository.save(order);
    }

    private void reserveOrderInventory(Order order) {
        for (OrderItem item : order.getOrderItems()) {
            inventoryService.reserveQuantity(item.getProductVariantId(), item.getQuantity());
        }
    }
}

