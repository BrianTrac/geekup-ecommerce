package org.example.geekup.dto.request;



import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CategoryListRequest {
    private UUID parentId;
    private Boolean activeOnly;
}
