package org.example.geekup.service;

import org.example.geekup.helper.ProductVariant;

import java.util.UUID;

public interface ProductVariantService {
    boolean isVariantActiveAndAvailable(UUID variantId);

    ProductVariant getVariant(UUID variantId);
}
