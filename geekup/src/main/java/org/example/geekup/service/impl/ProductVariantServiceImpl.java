package org.example.geekup.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.example.geekup.helper.ProductVariant;
import org.example.geekup.service.ProductVariantService;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.UUID;

// Mock services for demo purposes
@Service
@Slf4j
public class ProductVariantServiceImpl implements ProductVariantService {

    @Override
    public boolean isVariantActiveAndAvailable(UUID variantId) {
        // Mock implementation
        return true;
    }

    @Override
    public ProductVariant getVariant(UUID variantId) {
        // Mock implementation
        return ProductVariant.builder()
                .id(variantId)
                .productName("Sample Product")
                .finalPrice(BigDecimal.valueOf(50.00))
                .build();
    }
}
