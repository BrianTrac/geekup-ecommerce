package org.example.geekup.repository;

import org.example.geekup.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ProductRepository extends JpaRepository<Product, UUID> {

    @Query("SELECT p FROM Product p WHERE p.categoryId = :categoryId AND p.isDeleted = false AND (:activeOnly = false OR p.isActive = true)")
    Page<Product> findByCategoryId(@Param("categoryId") UUID categoryId, @Param("activeOnly") boolean activeOnly, Pageable pageable);

    @Query(value = """
    WITH RECURSIVE category_tree AS (
        SELECT id FROM categories WHERE id = :parentId
        UNION ALL
        SELECT c.id FROM categories c
        INNER JOIN category_tree ct ON c.parent_category_id = ct.id
    )
    SELECT * FROM products p
    WHERE p.category_id IN (SELECT id FROM category_tree)
      AND p.is_deleted = false
      AND (:activeOnly = false OR p.is_active = true)
    """, nativeQuery = true)
    Page<Product> findProductsInCategoryTree(@Param("parentId") UUID parentId,
                                             @Param("activeOnly") boolean activeOnly,
                                             Pageable pageable);



    @Query(value = """
        SELECT p.*, 
               ts_rank(to_tsvector('english', p.name || ' ' || COALESCE(p.description, '') || ' ' || COALESCE(p.brand, '')), 
                      plainto_tsquery('english', :query)) as relevance
        FROM products p 
        WHERE p.is_deleted = false 
          AND p.is_active = true
          AND to_tsvector('english', p.name || ' ' || COALESCE(p.description, '') || ' ' || COALESCE(p.brand, '')) 
              @@ plainto_tsquery('english', :query)
          AND (:categoryId IS NULL OR p.category_id = CAST(:categoryId AS UUID))
          AND (:minPrice IS NULL OR p.base_price >= :minPrice)
          AND (:maxPrice IS NULL OR p.base_price <= :maxPrice)
          AND (:brand IS NULL OR LOWER(p.brand) LIKE LOWER(CONCAT('%', :brand, '%')))
        """,
                countQuery = """
        SELECT COUNT(*) 
        FROM products p 
        WHERE p.is_deleted = false 
          AND p.is_active = true
          AND to_tsvector('english', p.name || ' ' || COALESCE(p.description, '') || ' ' || COALESCE(p.brand, '')) 
              @@ plainto_tsquery('english', :query)
          AND (:categoryId IS NULL OR p.category_id = CAST(:categoryId AS UUID))
          AND (:minPrice IS NULL OR p.base_price >= :minPrice)
          AND (:maxPrice IS NULL OR p.base_price <= :maxPrice)
          AND (:brand IS NULL OR LOWER(p.brand) LIKE LOWER(CONCAT('%', :brand, '%')))
        """,
                nativeQuery = true)
        Page<Product> searchProducts(@Param("query") String query,
                                     @Param("categoryId") String categoryId,
                                     @Param("minPrice") BigDecimal minPrice,
                                     @Param("maxPrice") BigDecimal maxPrice,
                                     @Param("brand") String brand,
                                     Pageable pageable);


    @Query(value = """
        SELECT p.*, 
               similarity(p.name, :query) AS relevance
        FROM products p 
        WHERE p.is_deleted = false 
          AND p.is_active = true
          AND (
              p.name % :query OR
              p.description % :query OR
              p.brand % :query
          )
          AND (:categoryId IS NULL OR p.category_id = CAST(:categoryId AS UUID))
          AND (:minPrice IS NULL OR p.base_price >= :minPrice)
          AND (:maxPrice IS NULL OR p.base_price <= :maxPrice)
          AND (:brand IS NULL OR LOWER(p.brand) LIKE LOWER(CONCAT('%', :brand, '%')))
        ORDER BY relevance DESC, p.name ASC
        """,
                countQuery = """
        SELECT COUNT(*) 
        FROM products p 
        WHERE p.is_deleted = false 
          AND p.is_active = true
          AND (
              p.name % :query OR
              p.description % :query OR
              p.brand % :query
          )
          AND (:categoryId IS NULL OR p.category_id = CAST(:categoryId AS UUID))
          AND (:minPrice IS NULL OR p.base_price >= :minPrice)
          AND (:maxPrice IS NULL OR p.base_price <= :maxPrice)
          AND (:brand IS NULL OR LOWER(p.brand) LIKE LOWER(CONCAT('%', :brand, '%')))
        """,
                nativeQuery = true)
        Page<Product> searchProductsTypoTolerant(@Param("query") String query,
                                                 @Param("categoryId") String categoryId,
                                                 @Param("minPrice") BigDecimal minPrice,
                                                 @Param("maxPrice") BigDecimal maxPrice,
                                                 @Param("brand") String brand,
                                                 Pageable pageable);



    @Query("SELECT p FROM Product p WHERE p.id = :id AND p.isDeleted = false")
    Optional<Product> findActiveById(@Param("id") UUID id);

    @Query("SELECT COUNT(p) FROM Product p WHERE p.categoryId = :categoryId AND p.isDeleted = false AND p.isActive = true")
    Long countActiveByCategoryId(@Param("categoryId") UUID categoryId);
}