package org.example.geekup.controller;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.dto.request.CategoryListRequest;
import org.example.geekup.dto.request.ProductListRequest;
import org.example.geekup.dto.request.ProductSearchRequest;
import org.example.geekup.dto.response.*;
import org.example.geekup.service.CategoryService;
import org.example.geekup.service.ProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1")
@RequiredArgsConstructor
@Slf4j
public class ProductController {
    private final CategoryService categoryService;
    private final ProductService productService;

    @GetMapping("/categories")
    public ResponseEntity<ApiResponse<List<CategoryResponse>>> getAllCategories(
            @RequestParam(value = "parent_id", required = false) UUID parentId,
            @RequestParam(value = "active_only", defaultValue = "true") boolean activeOnly) {

        log.info("GET /api/v1/categories - parentId: {}, activeOnly: {}", parentId, activeOnly);

        CategoryListRequest request = CategoryListRequest.builder()
                .parentId(parentId)
                .activeOnly(activeOnly)
                .build();

        List<CategoryResponse> categories = categoryService.getAllCategories(request);
        return ResponseEntity.ok(ApiResponse.success(categories, "Categories retrieved successfully"));
    }

    @GetMapping("/categories/{categoryId}")
    public ResponseEntity<ApiResponse<CategoryResponse>> getCategoryById(
            @PathVariable UUID categoryId) {

        log.info("GET /api/v1/categories/{}", categoryId);

        CategoryResponse category = categoryService.getCategoryById(categoryId);
        return ResponseEntity.ok(ApiResponse.success(category, "Category retrieved successfully"));
    }

    @GetMapping("/categories/{categoryId}/products")
    public ResponseEntity<ApiResponse<PagedResponse<ProductResponse>>> getProductsByCategory(
            @Valid
            @PathVariable UUID categoryId,
            @RequestParam(value = "page", defaultValue = "0") @Min(0) int page,
            @RequestParam(value = "size", defaultValue = "5") @Min(1) int size,
            @RequestParam(value = "sort", defaultValue = "name") String sort,
            @RequestParam(value = "direction", defaultValue = "asc") String direction,
            @RequestParam(value = "active_only", defaultValue = "true") boolean activeOnly) {

        log.info("GET /api/v1/categories/{}/products - page: {}, size: {}", categoryId, page, size);

        ProductListRequest request = ProductListRequest.builder()
                .categoryId(categoryId)
                .page(page)
                .size(size)
                .sort(sort)
                .direction(direction)
                .activeOnly(activeOnly)
                .build();

        PagedResponse<ProductResponse> products = productService.getProductsByCategory(request);
        return ResponseEntity.ok(ApiResponse.success(products, "Products retrieved successfully"));
    }

    @GetMapping("/products/{productId}")
    public ResponseEntity<ApiResponse<ProductResponse>> getProductById(
            @PathVariable UUID productId) {

        log.info("GET /api/v1/products/{}", productId);

        ProductResponse product = productService.getProductById(productId);
        return ResponseEntity.ok(ApiResponse.success(product, "Product retrieved successfully"));
    }

    @GetMapping("/products/search")
    public ResponseEntity<ApiResponse<ProductSearchResponse>> searchProducts(
            @Valid
            @RequestParam(value = "q") @NotBlank String query,
            @RequestParam(value = "category_id", required = false) UUID categoryId,
            @RequestParam(value = "min_price", required = false) BigDecimal minPrice,
            @RequestParam(value = "max_price", required = false) BigDecimal maxPrice,
            @RequestParam(value = "brand", required = false) String brand,
            @RequestParam(value = "page", defaultValue = "0") @Min(0) Integer page,
            @RequestParam(value = "size", defaultValue = "5") @Min(1) Integer size,
            @RequestParam(value = "sort", defaultValue = "relevance") String sort,
            @RequestParam(value = "direction", defaultValue = "desc") String direction) {

        log.info("GET /api/v1/products/search - query: {}, categoryId: {}", query, categoryId);

        ProductSearchRequest request = ProductSearchRequest.builder()
                .query(query)
                .categoryId(categoryId)
                .minPrice(minPrice)
                .maxPrice(maxPrice)
                .brand(brand)
                .page(page)
                .size(size)
                .sort(sort)
                .direction(direction)
                .build();

        ProductSearchResponse searchResults = productService.searchProducts(request);
        return ResponseEntity.ok(ApiResponse.success(searchResults, "Search results retrieved successfully"));

    }
}