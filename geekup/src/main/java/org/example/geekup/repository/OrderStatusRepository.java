package org.example.geekup.repository;

import org.example.geekup.entity.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface OrderStatusRepository extends JpaRepository<OrderStatus, UUID> {
    Optional<OrderStatus> findByStatusNameAndIsDeletedFalse(String statusName);
}