package org.example.geekup.repository;

import org.example.geekup.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, UUID> {
    Optional<Payment> findByOrderIdAndIsDeletedFalse(UUID orderId);
    List<Payment> findByOrderIdAndIsDeletedFalseOrderByCreatedAtDesc(UUID orderId);
}
