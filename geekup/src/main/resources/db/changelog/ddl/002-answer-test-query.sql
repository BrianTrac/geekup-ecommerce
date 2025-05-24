-- ========================================
-- PART B: Insert Order for User "assessment"
-- ========================================

-- First, let's insert the user if they don't exist
INSERT INTO users (name, email, phone, password_hash, created_at)
VALUES ('assessment', 'gu@gmail.com', '328355333', 'temp_hash', CURRENT_TIMESTAMP)
    ON CONFLICT (email) DO NOTHING;

-- Create a sequence for order numbers if it doesn't exist
CREATE SEQUENCE IF NOT EXISTS orders_seq START 1;

-- Get the user ID for reference
-- Note: In a real application, you'd handle this programmatically
WITH user_data AS (
    SELECT id as user_id FROM users WHERE email = 'gu@gmail.com'
),

-- Insert user address
     address_insert AS (
INSERT INTO user_addresses (
    user_id, province, district, commune, detailed_address,
    housing_type, is_default, created_at
)
SELECT
    user_id, 'Bắc Kạn', 'Ba Bể', 'Phúc Lộc',
    '73 tân hoà 2', 'nhà riêng', true, CURRENT_TIMESTAMP
FROM user_data
    ON CONFLICT DO NOTHING
    RETURNING id as address_id, user_id
),

-- Assuming we need to create the product and its variants
-- First, create a category for shoes if it doesn't exist
category_insert AS (
INSERT INTO categories (name, description, is_active, created_at)
VALUES ('Women Shoes', 'Women footwear category', true, CURRENT_TIMESTAMP)
ON CONFLICT DO NOTHING
    RETURNING id as category_id
    ),

-- Insert the product
    product_insert AS (
INSERT INTO products (
    name, description, category_id, base_price, sku,
    brand, is_active, created_at
)
SELECT
    'KAPPA Women''s Sneakers',
    'KAPPA brand women sneakers',
    COALESCE(ci.category_id, (SELECT id FROM categories WHERE name = 'Women Shoes' LIMIT 1)),
    980000.00,
    'KAPPA-WS-001',
    'KAPPA',
    true,
    CURRENT_TIMESTAMP
FROM (SELECT NULL) dummy
    LEFT JOIN category_insert ci ON true
    ON CONFLICT (sku) DO NOTHING
    RETURNING id as product_id
    ),

-- Create color attribute if it doesn't exist
    color_attr AS (
INSERT INTO product_attributes (attribute_name, attribute_type, is_active, created_at)
VALUES ('color', 'color', true, CURRENT_TIMESTAMP)
ON CONFLICT (attribute_name) DO NOTHING
    RETURNING id as color_attr_id
    ),

-- Create size attribute if it doesn't exist
    size_attr AS (
INSERT INTO product_attributes (attribute_name, attribute_type, is_active, created_at)
VALUES ('size', 'size', true, CURRENT_TIMESTAMP)
ON CONFLICT (attribute_name) DO NOTHING
    RETURNING id as size_attr_id
    ),

-- Insert color value (yellow)
    color_value AS (
INSERT INTO product_attribute_values (attribute_id, attribute_value, created_at)
SELECT
    COALESCE(ca.color_attr_id, (SELECT id FROM product_attributes WHERE attribute_name = 'color')),
    'yellow',
    CURRENT_TIMESTAMP
FROM (SELECT NULL) dummy
    LEFT JOIN color_attr ca ON true
    ON CONFLICT (attribute_id, attribute_value) DO NOTHING
    RETURNING id as color_value_id
    ),

-- Insert size value (36)
    size_value AS (
INSERT INTO product_attribute_values (attribute_id, attribute_value, created_at)
SELECT
    COALESCE(sa.size_attr_id, (SELECT id FROM product_attributes WHERE attribute_name = 'size')),
    '36',
    CURRENT_TIMESTAMP
FROM (SELECT NULL) dummy
    LEFT JOIN size_attr sa ON true
    ON CONFLICT (attribute_id, attribute_value) DO NOTHING
    RETURNING id as size_value_id
    ),

-- Create product variant
    variant_insert AS (
INSERT INTO product_variants (
    product_id, variant_sku, price_adjustment, is_active, created_at
)
SELECT
    COALESCE(pi.product_id, (SELECT id FROM products WHERE sku = 'KAPPA-WS-001')),
    'KAPPA-WS-001-YEL-36',
    0.00,
    true,
    CURRENT_TIMESTAMP
FROM (SELECT NULL) dummy
    LEFT JOIN product_insert pi ON true
    ON CONFLICT (variant_sku) DO NOTHING
    RETURNING id as variant_id, product_id
    ),

-- Link variant to color attribute
    variant_color AS (
INSERT INTO product_variant_attributes (variant_id, attribute_value_id, created_at)
SELECT
    COALESCE(vi.variant_id, (SELECT id FROM product_variants WHERE variant_sku = 'KAPPA-WS-001-YEL-36')),
    COALESCE(cv.color_value_id, (SELECT pav.id FROM product_attribute_values pav
    JOIN product_attributes pa ON pav.attribute_id = pa.id
    WHERE pa.attribute_name = 'color' AND pav.attribute_value = 'yellow')),
    CURRENT_TIMESTAMP
FROM (SELECT NULL) dummy
    LEFT JOIN variant_insert vi ON true
    LEFT JOIN color_value cv ON true
    ON CONFLICT (variant_id, attribute_value_id) DO NOTHING
    ),

-- Link variant to size attribute
    variant_size AS (
INSERT INTO product_variant_attributes (variant_id, attribute_value_id, created_at)
SELECT
    COALESCE(vi.variant_id, (SELECT id FROM product_variants WHERE variant_sku = 'KAPPA-WS-001-YEL-36')),
    COALESCE(sv.size_value_id, (SELECT pav.id FROM product_attribute_values pav
    JOIN product_attributes pa ON pav.attribute_id = pa.id
    WHERE pa.attribute_name = 'size' AND pav.attribute_value = '36')),
    CURRENT_TIMESTAMP
FROM (SELECT NULL) dummy
    LEFT JOIN variant_insert vi ON true
    LEFT JOIN size_value sv ON true
    ON CONFLICT (variant_id, attribute_value_id) DO NOTHING
    ),

-- Create order status if it doesn't exist
    order_status AS (
INSERT INTO order_statuses (status_name, created_at)
VALUES ('pending', CURRENT_TIMESTAMP)
ON CONFLICT (status_name) DO NOTHING
    RETURNING id as status_id
    ),

-- Create payment method if it doesn't exist
    payment_method AS (
INSERT INTO payment_methods (method_name, is_active, created_at)
VALUES ('cash', true, CURRENT_TIMESTAMP)
ON CONFLICT (method_name) DO NOTHING
    RETURNING id as payment_method_id
    ),

-- Insert the order
    order_insert AS (
INSERT INTO orders (
    order_number, user_id, shipping_address_id, subtotal,
    total_amount, order_status_id, payment_method_id,
    ordered_at, created_at
)
SELECT
    'ORD-' || TO_CHAR(CURRENT_TIMESTAMP, 'YYYYMMDD') || '-' || LPAD(NEXTVAL('orders_seq')::TEXT, 6, '0'),
    ud.user_id,
    COALESCE(ai.address_id, (SELECT id FROM user_addresses WHERE user_id = ud.user_id AND is_default = true LIMIT 1)),
    980000.00,
    980000.00,
    COALESCE(os.status_id, (SELECT id FROM order_statuses WHERE status_name = 'pending')),
    COALESCE(pm.payment_method_id, (SELECT id FROM payment_methods WHERE method_name = 'cash')),
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
FROM user_data ud
    LEFT JOIN address_insert ai ON ai.user_id = ud.user_id
    LEFT JOIN order_status os ON true
    LEFT JOIN payment_method pm ON true
    RETURNING id as order_id
    )

-- Insert order item
INSERT INTO order_items (
    order_id, product_variant_id, quantity, unit_price,
    total_price, created_at
)
SELECT
    oi.order_id,
    COALESCE(vi.variant_id, (SELECT id FROM product_variants WHERE variant_sku = 'KAPPA-WS-001-YEL-36')),
    1,
    980000.00,
    980000.00,
    CURRENT_TIMESTAMP
FROM order_insert oi
         LEFT JOIN variant_insert vi ON true;

-- ========================================
-- PART C: Average Order Value by Month
-- ========================================

SELECT
    DATE_TRUNC('month', o.ordered_at) as order_month,
    ROUND(AVG(o.total_amount), 2) as average_order_value,
    COUNT(o.id) as total_orders,
    ROUND(SUM(o.total_amount), 2) as total_revenue
FROM orders o
WHERE EXTRACT(YEAR FROM o.ordered_at) = EXTRACT(YEAR FROM CURRENT_DATE)
  AND o.is_deleted = FALSE
GROUP BY DATE_TRUNC('month', o.ordered_at)
ORDER BY order_month;


-- ========================================
-- PART D: Customer Churn Rate Calculation
-- ========================================

WITH customer_segments AS (
    -- Customers who made purchases in the last 6 months (active customers)
    SELECT DISTINCT user_id, 'active' as segment
    FROM orders
    WHERE ordered_at >= CURRENT_DATE - INTERVAL '6 months'
    AND is_deleted = FALSE

UNION

-- Customers who made purchases 6-12 months ago but not in last 6 months (churned)
SELECT DISTINCT o1.user_id, 'churned' as segment
FROM orders o1
WHERE o1.ordered_at >= CURRENT_DATE - INTERVAL '12 months'
  AND o1.ordered_at < CURRENT_DATE - INTERVAL '6 months'
  AND o1.is_deleted = FALSE
  AND NOT EXISTS (
    SELECT 1 FROM orders o2
    WHERE o2.user_id = o1.user_id
  AND o2.ordered_at >= CURRENT_DATE - INTERVAL '6 months'
  AND o2.is_deleted = FALSE
    )
    ),

    churn_metrics AS (
SELECT
    segment,
    COUNT(*) as customer_count
FROM customer_segments
GROUP BY segment
    )

SELECT
    COALESCE(active.customer_count, 0) as active_customers,
    COALESCE(churned.customer_count, 0) as churned_customers,
    COALESCE(active.customer_count, 0) + COALESCE(churned.customer_count, 0) as total_customers_base,
    CASE
        WHEN COALESCE(active.customer_count, 0) + COALESCE(churned.customer_count, 0) = 0 THEN 0
        ELSE ROUND(
                (COALESCE(churned.customer_count, 0)::DECIMAL /
             (COALESCE(active.customer_count, 0) + COALESCE(churned.customer_count, 0))) * 100,
                2
             )
        END as churn_rate_percentage
FROM (SELECT customer_count FROM churn_metrics WHERE segment = 'active') active
         FULL OUTER JOIN (SELECT customer_count FROM churn_metrics WHERE segment = 'churned') churned ON true;
