package org.example.geekup.service;

import java.math.BigDecimal;
import java.util.UUID;

public interface VoucherService {
    BigDecimal calculateDiscount(UUID voucherId, BigDecimal subtotal);
}
