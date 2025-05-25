package org.example.geekup.service;

import org.example.geekup.enums.OrderStatusEnum;

import java.util.UUID;

public interface OrderStatusService {
    UUID getStatusId(OrderStatusEnum statusEnum);

    String getStatusName(UUID statusId);
}
