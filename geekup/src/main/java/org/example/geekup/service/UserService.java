package org.example.geekup.service;

import org.example.geekup.entity.User;

import java.util.UUID;

public interface UserService {
    boolean userExists(UUID userId);

    User getUser(UUID userId);

    boolean addressBelongsToUser(UUID addressId, UUID userId);

    String getFormattedAddress(UUID addressId);
}
