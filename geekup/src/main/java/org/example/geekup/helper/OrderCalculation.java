package org.example.geekup.helper;

import lombok.*;

import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderCalculation {
    private BigDecimal subtotal;
    private BigDecimal voucherDiscountAmount;
    private BigDecimal taxAmount;
    private BigDecimal baseShippingFee;
    private BigDecimal totalAmount;
    private List<OrderItemCalculation> itemCalculations;
}