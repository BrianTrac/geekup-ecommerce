package org.example.geekup.dto.request;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductListRequest {
    private UUID categoryId;
    private Integer page;
    private Integer size;
    private String sort;
    private String direction;
    private Boolean activeOnly;
}
