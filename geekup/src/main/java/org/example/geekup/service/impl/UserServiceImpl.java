package org.example.geekup.service.impl;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.entity.User;
import org.example.geekup.repository.UserAddressRepository;
import org.example.geekup.repository.UserRepository;
import org.example.geekup.service.UserService;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UserAddressRepository userAddressRepository;

    public boolean userExists(UUID userId) {
        return userRepository.findByIdAndIsDeletedFalse(userId).isPresent();
    }

    public User getUser(UUID userId) {
        return userRepository.findByIdAndIsDeletedFalse(userId)
                .orElseThrow(() -> new EntityNotFoundException("User not found: " + userId));
    }

    public boolean addressBelongsToUser(UUID addressId, UUID userId) {
        return userAddressRepository.findByIdAndUserIdAndIsDeletedFalse(addressId, userId).isPresent();
    }

    public String getFormattedAddress(UUID addressId) {
        return userAddressRepository.findById(addressId)
                .map(address -> String.format("%s, %s, %s, %s",
                        address.getDetailedAddress(),
                        address.getCommune(),
                        address.getDistrict(),
                        address.getProvince()))
                .orElse("Address not found");
    }
}
