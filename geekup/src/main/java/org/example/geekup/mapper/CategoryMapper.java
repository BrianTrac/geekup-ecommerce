package org.example.geekup.mapper;

import org.example.geekup.dto.request.CategoryRequest;
import org.example.geekup.dto.response.CategoryResponse;
import org.example.geekup.entity.Category;
import org.mapstruct.*;

import java.util.List;

@Mapper(componentModel = "spring", unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface CategoryMapper {
    @Mapping(target = "subCategories", ignore = true)
    @Mapping(target = "productCount", ignore = true)
    CategoryResponse toResponse(Category category);

    List<CategoryResponse> toResponseList(List<Category> categories);

    @Mapping(target = "id", ignore = true)
    @Mapping(target = "products", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "updatedAt", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "updatedBy", ignore = true)
    @Mapping(target = "isDeleted", ignore = true)
    Category toEntity(CategoryRequest categoryRequest);

    @AfterMapping
    default void setProductCount(@MappingTarget CategoryResponse categoryResponse, Category category) {
        if (category.getProducts() != null) {
            categoryResponse.setProductCount((int) category.getProducts().stream()
                    .filter(p -> !p.getIsDeleted() && p.getIsActive())
                    .count());
        }
    }
}
