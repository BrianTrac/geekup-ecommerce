package org.example.geekup.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.SuperBuilder;
import org.example.geekup.common.Auditable;
import org.hibernate.annotations.GenericGenerator;

import java.math.BigDecimal;
import java.util.UUID;

@Entity
@Table(name = "products")
@Getter
@Setter
@ToString
@SuperBuilder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class Product extends Auditable {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "name", nullable = false)
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "category_id", nullable = false)
    private UUID categoryId;

    @Column(name = "base_price", nullable = false, precision = 15, scale = 2)
    private BigDecimal basePrice;

    @Builder.Default
    @Column(name = "discount_percentage", precision = 5, scale = 2)
    private BigDecimal discountPercentage = BigDecimal.ZERO;

    @Builder.Default
    @Column(name = "is_vat_included")
    private Boolean isVatIncluded = false;

    @Column(name = "sku", unique = true)
    private String sku;

    @Column(name = "brand")
    private String brand;

    @Column(name = "guarantee_info")
    private String guaranteeInfo;

    @Builder.Default
    @Column(name = "likes_count")
    private Integer likesCount = 0;

    @Builder.Default
    @Column(name = "is_active")
    private Boolean isActive = true;

    // Calculated fields
    public BigDecimal getEffectivePrice() {
        if (discountPercentage != null && discountPercentage.compareTo(BigDecimal.ZERO) > 0) {
            BigDecimal discount = basePrice.multiply(discountPercentage).divide(BigDecimal.valueOf(100));
            return basePrice.subtract(discount);
        }
        return basePrice;
    }
}
