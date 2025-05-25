package org.example.geekup.service;

import org.example.geekup.dto.request.ProductListRequest;
import org.example.geekup.dto.request.ProductSearchRequest;
import org.example.geekup.dto.response.PagedResponse;
import org.example.geekup.dto.response.ProductResponse;
import org.example.geekup.dto.response.ProductSearchResponse;

import java.util.UUID;

public interface ProductService {
    PagedResponse<ProductResponse> getProductsByCategory(ProductListRequest request);
    ProductSearchResponse searchProducts(ProductSearchRequest request);
    ProductResponse getProductById(UUID productId);
    Long getProductCountByCategory(UUID categoryId);
}
