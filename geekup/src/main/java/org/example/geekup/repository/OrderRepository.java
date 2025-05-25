package org.example.geekup.repository;

import org.example.geekup.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface OrderRepository extends JpaRepository<Order, UUID> {
    Optional<Order> findByOrderNumberAndIsDeletedFalse(String orderNumber);
    List<Order> findByUserIdAndIsDeletedFalseOrderByCreatedAtDesc(UUID userId);

    @Query("SELECT o FROM Order o WHERE o.userId = :userId AND o.isDeleted = false ORDER BY o.createdAt DESC")
    Page<Order> findUserOrders(@Param("userId") UUID userId, Pageable pageable);
}
