package org.example.geekup.repository;

import org.example.geekup.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface CategoryRepository extends JpaRepository<Category, UUID> {
    @Query("SELECT c FROM Category c WHERE c.isDeleted = false AND (:activeOnly = false OR c.isActive = true) ORDER BY c.sortOrder, c.name")
    List<Category> findAllCategories(@Param("activeOnly") boolean activeOnly);

    @Query("SELECT c FROM Category c WHERE c.parentCategoryId = :parentId AND c.isDeleted = false AND (:activeOnly = false OR c.isActive = true) ORDER BY c.sortOrder, c.name")
    List<Category> findByParentCategoryId(@Param("parentId") UUID parentId, @Param("activeOnly") boolean activeOnly);

    @Query("SELECT c FROM Category c WHERE c.parentCategoryId IS NULL AND c.isDeleted = false AND (:activeOnly = false OR c.isActive = true) ORDER BY c.sortOrder, c.name")
    List<Category> findRootCategories(@Param("activeOnly") boolean activeOnly);

    @Query("SELECT c FROM Category c WHERE c.id = :id AND c.isDeleted = false")
    Optional<Category> findActiveById(@Param("id") UUID id);
}
