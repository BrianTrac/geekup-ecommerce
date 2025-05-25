package org.example.geekup.repository;

import org.example.geekup.entity.UserAddress;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;

@Repository
public interface UserAddressRepository extends JpaRepository<UserAddress, UUID> {
    Optional<UserAddress> findByIdAndUserIdAndIsDeletedFalse(UUID id, UUID userId);
}
