package org.example.geekup.mapper;

import org.example.geekup.dto.request.PaymentRequest;
import org.example.geekup.dto.response.PaymentResponse;
import org.example.geekup.entity.Payment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface PaymentMapper {

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "isDeleted", constant = "false")
    Payment toEntity(PaymentRequest request);

    PaymentResponse toResponse(Payment payment);

    List<PaymentResponse> toResponseList(List<Payment> payments);
}
