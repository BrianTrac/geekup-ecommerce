package org.example.geekup.dto.request;

import lombok.*;
import org.antlr.v4.runtime.misc.NotNull;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductRequest {
    private String name;
    private String description;
    private UUID categoryId;
    private BigDecimal basePrice;
    private BigDecimal discountPercentage;
    private Boolean isVatIncluded;
    private String sku;
    private String brand;
    private String guaranteeInfo;
    private Boolean isActive;
}
