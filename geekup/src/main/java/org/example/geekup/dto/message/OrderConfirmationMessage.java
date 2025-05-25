package org.example.geekup.dto.message;


import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderConfirmationMessage {
    private UUID orderId;
    private String orderNumber;
    private UUID userId;
    private String userEmail;
    private String userName;
    private BigDecimal totalAmount;
    private LocalDateTime orderedAt;
    private List<OrderItemMessage> orderItems;
    private String shippingAddress;
    private String paymentMethod;
}
