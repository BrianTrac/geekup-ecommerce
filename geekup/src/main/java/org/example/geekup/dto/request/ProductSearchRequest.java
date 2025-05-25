package org.example.geekup.dto.request;

import lombok.*;

import java.math.BigDecimal;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductSearchRequest {
    private String query;
    private UUID categoryId;
    private BigDecimal minPrice;
    private BigDecimal maxPrice;
    private String brand;
    private Integer page;
    private Integer size;
    private String sort;
    private String direction;
}
