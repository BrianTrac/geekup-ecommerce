package org.example.geekup.mapper;

import org.example.geekup.dto.request.ProductRequest;
import org.example.geekup.dto.response.ProductResponse;
import org.example.geekup.entity.Product;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface ProductMapper {
    @Mapping(target = "categoryName", ignore = true)
    @Mapping(target = "effectivePrice", source = "effectivePrice")
    @Mapping(target = "imageUrls", ignore = true)
    @Mapping(target = "searchRelevance", ignore = true)
    ProductResponse toResponse(Product product);

    List<ProductResponse> toResponseList(List<Product> products);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "updatedBy", ignore = true)
    @Mapping(target = "isDeleted", ignore = true)
    @Mapping(target = "likesCount", ignore = true)
    Product toEntity(ProductRequest productRequest);

    @AfterMapping
    default void calculateEffectivePrice(@MappingTarget ProductResponse productResponse, Product product) {
        productResponse.setEffectivePrice(product.getEffectivePrice());
    }
}
