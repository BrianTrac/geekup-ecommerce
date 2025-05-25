package org.example.geekup.service;

import java.util.UUID;

public interface InventoryService {
    boolean isQuantityAvailable(UUID variantId, Integer quantity);

    void reserveQuantity(UUID variantId, Integer quantity);
}
