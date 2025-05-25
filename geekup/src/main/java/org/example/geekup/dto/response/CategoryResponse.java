package org.example.geekup.dto.response;

import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryResponse {
    private UUID id;
    private String name;
    private String description;
    private UUID parentCategoryId;
    private String imageUrl;
    private Boolean isActive;
    private Integer sortOrder;
    private List<CategoryResponse> subCategories;
    private Integer productCount;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
    private Boolean isDeleted;
}
