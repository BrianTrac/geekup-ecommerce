package org.example.geekup.dto.request;

import jakarta.validation.Valid;
import lombok.*;

import java.util.Map;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Valid
public class PaymentRequest {
    private String cardToken;
    private String cardNumber;
    private String expiryMonth;
    private String expiryYear;
    private String cvv;
    private String cardHolderName;
    private Map<String, String> additionalData;
}
