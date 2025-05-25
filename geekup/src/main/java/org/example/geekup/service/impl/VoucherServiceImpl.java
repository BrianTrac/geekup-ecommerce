package org.example.geekup.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.example.geekup.service.VoucherService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.UUID;

@Service
@Slf4j
public class VoucherServiceImpl implements VoucherService {

    public BigDecimal calculateDiscount(UUID voucherId, BigDecimal subtotal) {
        // Mock implementation - 10% discount
        return subtotal.multiply(BigDecimal.valueOf(0.1));
    }
}