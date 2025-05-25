package org.example.geekup.dto.response;

import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductResponse {
    private UUID id;
    private String name;
    private String description;
    private UUID categoryId;
    private String categoryName;
    private BigDecimal basePrice;
    private BigDecimal discountPercentage;
    private BigDecimal effectivePrice;
    private Boolean isVatIncluded;
    private String sku;
    private String brand;
    private String guaranteeInfo;
    private Integer likesCount;
    private Boolean isActive;
    private List<String> imageUrls;
    private Double searchRelevance; // For search results
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private UUID createdBy;
    private UUID updatedBy;
}
