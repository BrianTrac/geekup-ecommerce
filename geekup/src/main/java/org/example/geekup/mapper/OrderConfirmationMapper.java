package org.example.geekup.mapper;

import org.example.geekup.dto.message.OrderConfirmationMessage;
import org.example.geekup.dto.message.OrderItemMessage;
import org.example.geekup.entity.Order;
import org.example.geekup.entity.OrderItem;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface OrderConfirmationMapper {

    @Mapping(target = "userEmail", ignore = true) // Will be set from User entity
    @Mapping(target = "userName", ignore = true) // Will be set from User entity
    @Mapping(target = "orderItems", ignore = true) // Will be mapped separately
    @Mapping(target = "shippingAddress", ignore = true) // Will be formatted separately
    @Mapping(target = "paymentMethod", ignore = true) // Will be mapped separately
    OrderConfirmationMessage toMessage(Order order);

    @Mapping(target = "productName", ignore = true) // Will be set from ProductVariant
    OrderItemMessage toItemMessage(OrderItem orderItem);

    List<OrderItemMessage> toItemMessageList(List<OrderItem> orderItems);
}