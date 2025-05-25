package org.example.geekup.dto.response;

import lombok.*;
import org.example.geekup.enums.PaymentStatus;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaymentResponse {
    private UUID id;
    private PaymentStatus status;
    private String transactionId;
    private BigDecimal amount;
    private LocalDateTime processedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
    private Boolean isDeleted;
}
