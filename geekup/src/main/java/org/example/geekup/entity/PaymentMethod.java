package org.example.geekup.entity;

import jakarta.persistence.*;
import lombok.*;
import org.example.geekup.common.Auditable;
import org.hibernate.annotations.GenericGenerator;

import java.util.UUID;

@Entity
@Table(name = "payment_methods")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PaymentMethod extends Auditable {
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(name = "UUID", strategy = "org.hibernate.id.UUIDGenerator")
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "method_name", unique = true, nullable = false)
    private String methodName;

    @Column(name = "is_active")
    private Boolean isActive = true;
}