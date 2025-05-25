package org.example.geekup.service;

import org.example.geekup.dto.request.CategoryListRequest;
import org.example.geekup.dto.response.CategoryResponse;

import java.util.List;
import java.util.UUID;

public interface CategoryService {
    List<CategoryResponse> getAllCategories(CategoryListRequest request);
    CategoryResponse getCategoryById(UUID categoryId);
    List<CategoryResponse> getRootCategories(boolean activeOnly);
    List<CategoryResponse> getSubCategories(UUID parentId, boolean activeOnly);
}
