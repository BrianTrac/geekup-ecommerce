package org.example.geekup.service.impl;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.dto.request.ProductListRequest;
import org.example.geekup.dto.request.ProductSearchRequest;
import org.example.geekup.dto.response.PagedResponse;
import org.example.geekup.dto.response.ProductResponse;
import org.example.geekup.dto.response.ProductSearchResponse;
import org.example.geekup.entity.Product;
import org.example.geekup.mapper.ProductMapper;
import org.example.geekup.repository.ProductRepository;
import org.example.geekup.service.ProductService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final ProductMapper productMapper;

    @Override
    public PagedResponse<ProductResponse> getProductsByCategory(ProductListRequest request) {
        log.info("Fetching products for category: {}, page: {}, size: {}",
                request.getCategoryId(), request.getPage(), request.getSize());

        Sort.Direction sortDirection = "desc".equalsIgnoreCase(request.getDirection()) ?
                Sort.Direction.DESC : Sort.Direction.ASC;

        String sortField = request.getSort() != null ? request.getSort() : "name";
        int page = request.getPage() != null ? request.getPage() : 0;
        int size = request.getSize() != null ? request.getSize() : 5;
        boolean activeOnly = request.getActiveOnly() != null ? request.getActiveOnly() : true;

        Pageable pageable = PageRequest.of(page, size, Sort.by(sortDirection, sortField));
        Page<Product> productPage = productRepository.findProductsInCategoryTree(
                request.getCategoryId(), activeOnly, pageable);

        List<ProductResponse> productResponses = productMapper.toResponseList(productPage.getContent());

        return PagedResponse.<ProductResponse>builder()
                .content(productResponses)
                .page(page)
                .size(size)
                .totalElements(productPage.getTotalElements())
                .totalPages(productPage.getTotalPages())
                .hasNext(productPage.hasNext())
                .hasPrevious(productPage.hasPrevious())
                .build();
    }

    @Override
    public ProductSearchResponse searchProducts(ProductSearchRequest request) {
        log.info("Searching products with query: {}", request.getQuery());

        long startTime = System.currentTimeMillis();

        //Sort sort = Sort.by(Sort.Direction.DESC, "relevance");
        Sort sort = Sort.unsorted(); // Default to unsorted I will handle case relevance later
        if (!"relevance".equals(request.getSort())) {
            Sort.Direction direction = "desc".equalsIgnoreCase(request.getDirection()) ?
                    Sort.Direction.DESC : Sort.Direction.ASC;
            sort = Sort.by(direction, request.getSort());
        }

        int page = request.getPage() != null ? request.getPage() : 0;
        int size = request.getSize() != null ? request.getSize() : 5;

        Pageable pageable = PageRequest.of(page, size, sort);

        String categoryIdStr = request.getCategoryId() != null ?
                request.getCategoryId().toString() : null;

        Page<Product> productPage = productRepository.searchProductsTypoTolerant(
                request.getQuery(),
                categoryIdStr,
                request.getMinPrice(),
                request.getMaxPrice(),
                request.getBrand(),
                pageable
        );

        List<ProductResponse> productResponses = productMapper.toResponseList(productPage.getContent());

        long searchTime = System.currentTimeMillis() - startTime;

        return ProductSearchResponse.builder()
                .products(productResponses)
                .page(page)
                .size(size)
                .totalElements(productPage.getTotalElements())
                .totalPages(productPage.getTotalPages())
                .hasNext(productPage.hasNext())
                .hasPrevious(productPage.hasPrevious())
                .query(request.getQuery())
                .searchTimeMs(searchTime)
                .build();
    }

    @Override
    public ProductResponse getProductById(UUID productId) {
        log.info("Fetching product by id: {}", productId);

        Product product = productRepository.findActiveById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found with id: " + productId));

        return productMapper.toResponse(product);
    }

    @Override
    public Long getProductCountByCategory(UUID categoryId) {
        log.info("Counting active products for category: {}", categoryId);
        return productRepository.countActiveByCategoryId(categoryId);
    }
}