package org.example.geekup.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.entity.OrderStatus;
import org.example.geekup.enums.OrderStatusEnum;
import org.example.geekup.repository.OrderStatusRepository;
import org.example.geekup.service.OrderStatusService;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderStatusServiceImpl implements OrderStatusService {

    private final OrderStatusRepository orderStatusRepository;

    public UUID getStatusId(OrderStatusEnum statusEnum) {
        return orderStatusRepository.findByStatusNameAndIsDeletedFalse(statusEnum.getDisplayName())
                .map(OrderStatus::getId)
                .orElseThrow(() -> new IllegalStateException("Order status not found: " + statusEnum.getDisplayName()));
    }

    public String getStatusName(UUID statusId) {
        return orderStatusRepository.findById(statusId)
                .map(OrderStatus::getStatusName)
                .orElse("Unknown");
    }
}
