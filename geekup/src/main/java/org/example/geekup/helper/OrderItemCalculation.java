package org.example.geekup.helper;

import lombok.*;

import java.math.BigDecimal;
import java.util.UUID;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemCalculation {
    private UUID variantId;
    private Integer quantity;
    private BigDecimal unitPrice;
    private BigDecimal totalPrice;
}