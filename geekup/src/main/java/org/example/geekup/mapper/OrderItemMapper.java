package org.example.geekup.mapper;

import org.example.geekup.dto.request.OrderItemRequest;
import org.example.geekup.dto.response.OrderItemResponse;
import org.example.geekup.entity.OrderItem;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface OrderItemMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "order", ignore = true)
    @Mapping(target = "unitPrice", ignore = true) // Will be calculated
    @Mapping(target = "totalPrice", ignore = true) // Will be calculated
    @Mapping(target = "discountAmount", constant = "0")
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "updatedBy", ignore = true)
    @Mapping(target = "isDeleted", constant = "false")
    OrderItem toEntity(OrderItemRequest request);

    OrderItemResponse toResponse(OrderItem orderItem);

    List<OrderItem> toEntityList(List<OrderItemRequest> requests);
    List<OrderItemResponse> toResponseList(List<OrderItem> orderItems);
}