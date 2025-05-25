package org.example.geekup.mapper;

import org.example.geekup.dto.request.CreateOrderRequest;
import org.example.geekup.dto.response.OrderResponse;
import org.example.geekup.entity.Order;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Named;
import org.mapstruct.NullValuePropertyMappingStrategy;

import java.util.List;
import java.util.UUID;

@Mapper(componentModel = "spring", uses = {OrderItemMapper.class},
        nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
public interface OrderMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "orderNumber", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "orderItems", source = "orderItems")
    @Mapping(target = "orderedAt", expression = "java(java.time.LocalDateTime.now())")
    @Mapping(target = "isDeleted", constant = "false")
    Order toEntity(CreateOrderRequest request);

    @Mapping(target = "status", source = "orderStatusId", qualifiedByName = "mapOrderStatus")
    @Mapping(target = "payment", ignore = true) // Will be set separately
    OrderResponse toResponse(Order order);

    @Named("mapOrderStatus")
    default String mapOrderStatus(UUID orderStatusId) {
        // This will be injected by the service
        return null;
    }

    List<OrderResponse> toResponseList(List<Order> orders);
}