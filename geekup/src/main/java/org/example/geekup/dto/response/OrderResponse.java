package org.example.geekup.dto.response;

import jakarta.persistence.Column;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderResponse {
    private UUID id;
    private String orderNumber;
    private UUID userId;
    private BigDecimal totalAmount;
    private String status;
    private LocalDateTime orderedAt;
    private List<OrderItemResponse> orderItems;
    private PaymentResponse payment;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
    private Boolean isDeleted;
}
