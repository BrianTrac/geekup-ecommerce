package org.example.geekup.dto.request;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryRequest {
    private String name;
    private String description;
    private UUID parentCategoryId;
    private String imageUrl;
    private Boolean isActive;
    private Integer sortOrder;
}
