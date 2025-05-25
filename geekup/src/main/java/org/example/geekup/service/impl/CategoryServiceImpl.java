package org.example.geekup.service.impl;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.geekup.dto.request.CategoryListRequest;
import org.example.geekup.dto.response.CategoryResponse;
import org.example.geekup.entity.Category;
import org.example.geekup.mapper.CategoryMapper;
import org.example.geekup.repository.CategoryRepository;
import org.example.geekup.service.CategoryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional(readOnly = true)
public class CategoryServiceImpl implements CategoryService {

    private final CategoryRepository categoryRepository;
    private final CategoryMapper categoryMapper;

    @Override
    public List<CategoryResponse> getAllCategories(CategoryListRequest request) {
        log.info("Fetching categories with parentId: {}, activeOnly: {}",
                request.getParentId(), request.getActiveOnly());

        List<Category> categories;
        boolean activeOnly = request.getActiveOnly() != null ? request.getActiveOnly() : true;

        if (request.getParentId() != null) {
            categories = categoryRepository.findByParentCategoryId(request.getParentId(), activeOnly);
        } else {
            log.info("Fetching all categories, activeOnly: {}", activeOnly);
            categories = categoryRepository.findAllCategories(activeOnly);

            // For root categories, you might want to filter them separately
            // categories = categoryRepository.findRootCategories(activeOnly);
        }

        return categoryMapper.toResponseList(categories);
    }

    @Override
    public CategoryResponse getCategoryById(UUID categoryId) {
        log.info("Fetching category by id: {}", categoryId);

        Category category = categoryRepository.findActiveById(categoryId)
                .orElseThrow(() -> new RuntimeException("Category not found with id: " + categoryId));

        return categoryMapper.toResponse(category);
    }

    @Override
    public List<CategoryResponse> getRootCategories(boolean activeOnly) {
        log.info("Fetching root categories, activeOnly: {}", activeOnly);

        List<Category> categories = categoryRepository.findRootCategories(activeOnly);
        return categoryMapper.toResponseList(categories);
    }

    @Override
    public List<CategoryResponse> getSubCategories(UUID parentId, boolean activeOnly) {
        log.info("Fetching subcategories for parent: {}, activeOnly: {}", parentId, activeOnly);

        List<Category> categories = categoryRepository.findByParentCategoryId(parentId, activeOnly);
        return categoryMapper.toResponseList(categories);
    }
}
