package org.example.geekup.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.example.geekup.service.InventoryService;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@Slf4j
public class InventoryServiceImpl implements InventoryService {

    public boolean isQuantityAvailable(UUID variantId, Integer quantity) {
        // Mock implementation
        return true;
    }

    public void reserveQuantity(UUID variantId, Integer quantity) {
        // Mock implementation
        log.info("Reserved {} units of variant {}", quantity, variantId);
    }
}
