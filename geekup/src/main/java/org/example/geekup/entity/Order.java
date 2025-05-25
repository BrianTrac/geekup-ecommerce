package org.example.geekup.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;
import org.example.geekup.common.Auditable;
import org.hibernate.annotations.GenericGenerator;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@SuperBuilder
public class Order extends Auditable {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "order_number", unique = true, nullable = false)
    private String orderNumber;

    @Column(name = "user_id", nullable = false)
    private UUID userId;

    @Column(name = "shipping_address_id", nullable = false)
    private UUID shippingAddressId;

    @Column(name = "subtotal", nullable = false, precision = 15, scale = 2)
    private BigDecimal subtotal;

    @Column(name = "product_discount_amount", precision = 15, scale = 2)
    private BigDecimal productDiscountAmount = BigDecimal.ZERO;

    @Column(name = "voucher_discount_amount", precision = 15, scale = 2)
    private BigDecimal voucherDiscountAmount = BigDecimal.ZERO;

    @Column(name = "store_discount_amount", precision = 15, scale = 2)
    private BigDecimal storeDiscountAmount = BigDecimal.ZERO;

    @Column(name = "tax_amount", precision = 15, scale = 2)
    private BigDecimal taxAmount = BigDecimal.ZERO;

    @Column(name = "base_shipping_fee", precision = 15, scale = 2)
    private BigDecimal baseShippingFee = BigDecimal.ZERO;

    @Column(name = "shipping_discount_amount", precision = 15, scale = 2)
    private BigDecimal shippingDiscountAmount = BigDecimal.ZERO;

    @Column(name = "total_amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal totalAmount;

    @Column(name = "order_status_id", nullable = false)
    private UUID orderStatusId;

    @Column(name = "voucher_id")
    private UUID voucherId;

    private String notes;

    @Column(name = "ordered_at")
    private LocalDateTime orderedAt;

    @Column(name = "confirmed_at")
    private LocalDateTime confirmedAt;

    @Column(name = "shipped_at")
    private LocalDateTime shippedAt;

    @Column(name = "delivered_at")
    private LocalDateTime deliveredAt;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<OrderItem> orderItems = new ArrayList<>();
}