package org.example.geekup.dto.response;

import lombok.*;
import org.example.geekup.enums.PaymentStatus;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentResult {
    private boolean success;
    private String transactionId;
    private String gatewayResponse;
    private PaymentStatus status;
    private String errorMessage;
}
