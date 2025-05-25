package org.example.geekup.dto.request;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Valid
public class CreateOrderRequest {
    @NotNull(message = "User ID is required")
    private UUID userId;

    @NotNull(message = "Shipping address ID is required")
    private UUID shippingAddressId;

    @NotNull(message = "Payment method ID is required")
    private UUID paymentMethodId;

    private UUID voucherId;

    private String notes;

    @NotEmpty(message = "Order items cannot be empty")
    @Valid
    private List<OrderItemRequest> orderItems;

    @Valid
    private PaymentRequest paymentRequest;
}
