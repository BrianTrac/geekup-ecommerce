-- E-commerce Database Schema for PostgreSQL

-- Enable UUID extension for uuid_generate_v4()
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- users table
CREATE TABLE IF NOT EXISTS users (
                       id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                       name VARCHAR(255) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       phone VARCHAR(20),
                       password_hash VARCHAR(255) NOT NULL,
                       gender VARCHAR(10),
                       date_of_birth DATE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       created_by UUID,
                       updated_by UUID,
                       is_deleted BOOLEAN DEFAULT FALSE,
                       CONSTRAINT chk_gender CHECK (gender IN ('male', 'female', 'other')),
                       CONSTRAINT fk_users_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                       CONSTRAINT fk_users_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- user_addresses table
CREATE TABLE IF NOT EXISTS user_addresses (
                                id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                user_id UUID NOT NULL,
                                province VARCHAR(100) NOT NULL,
                                district VARCHAR(100) NOT NULL,
                                commune VARCHAR(100) NOT NULL,
                                detailed_address TEXT NOT NULL,
                                housing_type VARCHAR(20),
                                is_default BOOLEAN DEFAULT FALSE,
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                created_by UUID,
                                updated_by UUID,
                                is_deleted BOOLEAN DEFAULT FALSE,
                                CONSTRAINT chk_housing_type CHECK (housing_type IN ('nhà riêng', 'chung cư', 'văn phòng', 'khác')),
                                CONSTRAINT fk_user_addresses_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                                CONSTRAINT fk_user_addresses_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                CONSTRAINT fk_user_addresses_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- categories table
CREATE TABLE IF NOT EXISTS categories (
                            id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                            name VARCHAR(255) NOT NULL,
                            description TEXT,
                            parent_category_id UUID DEFAULT NULL,
                            image_url TEXT,
                            is_active BOOLEAN DEFAULT TRUE,
                            sort_order INTEGER DEFAULT 0,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            created_by UUID,
                            updated_by UUID,
                            is_deleted BOOLEAN DEFAULT FALSE,
                            CONSTRAINT fk_categories_parent FOREIGN KEY (parent_category_id) REFERENCES categories(id),
                            CONSTRAINT fk_categories_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                            CONSTRAINT fk_categories_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- store operating hours table
CREATE TABLE IF NOT EXISTS store_operating_hours (
                                       id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                       day_of_week INTEGER NOT NULL,
                                       open_time TIME NOT NULL,
                                       close_time TIME NOT NULL,
                                       is_closed BOOLEAN DEFAULT FALSE,
                                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                       updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                       created_by UUID,
                                       updated_by UUID,
                                       is_deleted BOOLEAN DEFAULT FALSE,
                                       CONSTRAINT chk_day_of_week CHECK (day_of_week BETWEEN 0 AND 6),
                                       CONSTRAINT fk_operating_hours_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                       CONSTRAINT fk_operating_hours_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- stores table
CREATE TABLE IF NOT EXISTS stores (
                        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                        name VARCHAR(255) NOT NULL,
                        phone VARCHAR(20),
                        email VARCHAR(255),
                        is_active BOOLEAN DEFAULT TRUE,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        created_by UUID,
                        updated_by UUID,
                        is_deleted BOOLEAN DEFAULT FALSE,
                        CONSTRAINT fk_stores_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                        CONSTRAINT fk_stores_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- store addresses table
CREATE TABLE IF NOT EXISTS store_addresses (
                                 id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                 store_id UUID NOT NULL,
                                 province VARCHAR(100) NOT NULL,
                                 district VARCHAR(100) NOT NULL,
                                 commune VARCHAR(100) NOT NULL,
                                 detailed_address TEXT NOT NULL,
                                 is_main_address BOOLEAN DEFAULT FALSE,
                                 latitude DECIMAL(10, 7),
                                 longitude DECIMAL(10, 7),
                                 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 created_by UUID,
                                 updated_by UUID,
                                 is_deleted BOOLEAN DEFAULT FALSE,
                                 CONSTRAINT fk_store_addresses_store FOREIGN KEY (store_id) REFERENCES stores(id) ON DELETE CASCADE,
                                 CONSTRAINT fk_store_addresses_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                 CONSTRAINT fk_store_addresses_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- store operating schedule table
CREATE TABLE IF NOT EXISTS store_operating_schedule (
                                          id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                          store_id UUID NOT NULL,
                                          operating_hour_id UUID NOT NULL,
                                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          created_by UUID,
                                          updated_by UUID,
                                          is_deleted BOOLEAN DEFAULT FALSE,
                                          CONSTRAINT fk_store_schedule_store FOREIGN KEY (store_id) REFERENCES stores(id) ON DELETE CASCADE,
                                          CONSTRAINT fk_store_schedule_hours FOREIGN KEY (operating_hour_id) REFERENCES store_operating_hours(id),
                                          CONSTRAINT fk_store_schedule_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                          CONSTRAINT fk_store_schedule_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),
                                          CONSTRAINT uq_store_schedule UNIQUE (store_id, operating_hour_id)
);

-- products table
CREATE TABLE IF NOT EXISTS products (
                          id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                          name VARCHAR(255) NOT NULL,
                          description TEXT,
                          category_id UUID NOT NULL,
                          base_price DECIMAL(15,2) NOT NULL,
                          discount_percentage DECIMAL(5,2) DEFAULT 0.00,
                          is_vat_included BOOLEAN DEFAULT FALSE,
                          sku VARCHAR(100) UNIQUE,
                          brand VARCHAR(255),
                          guarantee_info TEXT,
                          likes_count INTEGER DEFAULT 0,
                          is_active BOOLEAN DEFAULT TRUE,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          created_by UUID,
                          updated_by UUID,
                          is_deleted BOOLEAN DEFAULT FALSE,
                          CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(id),
                          CONSTRAINT fk_products_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                          CONSTRAINT fk_products_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),
                          CONSTRAINT chk_products_base_price CHECK (base_price >= 0),
                          CONSTRAINT chk_products_discount_percentage CHECK (discount_percentage >= 0 AND discount_percentage <= 100)
);

-- product attributes table
CREATE TABLE IF NOT EXISTS product_attributes (
                                    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                    attribute_name VARCHAR(50) NOT NULL UNIQUE,
                                    attribute_type VARCHAR(20) DEFAULT 'text',
                                    is_active BOOLEAN DEFAULT TRUE,
                                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                    created_by UUID,
                                    updated_by UUID,
                                    is_deleted BOOLEAN DEFAULT FALSE,
                                    CONSTRAINT fk_product_attributes_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                    CONSTRAINT fk_product_attributes_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),
                                    CONSTRAINT chk_product_attributes_type CHECK (attribute_type IN ('text', 'number', 'color', 'size'))
);

-- Product attribute values
CREATE TABLE IF NOT EXISTS product_attribute_values (
                                          id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                          attribute_id UUID NOT NULL,
                                          attribute_value VARCHAR(100) NOT NULL,
                                          display_order INTEGER DEFAULT 0,
                                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                          created_by UUID,
                                          updated_by UUID,
                                          is_deleted BOOLEAN DEFAULT FALSE,
                                          CONSTRAINT fk_attr_values_attribute FOREIGN KEY (attribute_id) REFERENCES product_attributes(id),
                                          CONSTRAINT fk_attr_values_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                          CONSTRAINT fk_attr_values_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),
                                          CONSTRAINT uq_attr_values_attribute_value UNIQUE(attribute_id, attribute_value)
);

-- Product variants
CREATE TABLE IF NOT EXISTS product_variants (
                                  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                  product_id UUID NOT NULL,
                                  variant_sku VARCHAR(100) UNIQUE,
                                  price_adjustment DECIMAL(15,2) DEFAULT 0.00,
                                  is_active BOOLEAN DEFAULT TRUE,
                                  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                  created_by UUID,
                                  updated_by UUID,
                                  is_deleted BOOLEAN DEFAULT FALSE,
                                  CONSTRAINT fk_product_variants_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
                                  CONSTRAINT fk_product_variants_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                  CONSTRAINT fk_product_variants_updated_by FOREIGN KEY (updated_by) REFERENCES users(id)
);

-- Product variant attribute mapping
CREATE TABLE IF NOT EXISTS product_variant_attributes (
                                            id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                            variant_id UUID NOT NULL,
                                            attribute_value_id UUID NOT NULL,
                                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                            created_by UUID,
                                            updated_by UUID,
                                            is_deleted BOOLEAN DEFAULT FALSE,
                                            CONSTRAINT fk_variant_attrs_variant FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE CASCADE,
                                            CONSTRAINT fk_variant_attrs_value FOREIGN KEY (attribute_value_id) REFERENCES product_attribute_values(id),
                                            CONSTRAINT fk_variant_attrs_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                            CONSTRAINT fk_variant_attrs_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),
                                            CONSTRAINT uq_variant_attribute UNIQUE(variant_id, attribute_value_id)
);

-- Product images
CREATE TABLE IF NOT EXISTS product_images (
                                id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                product_id UUID,
                                variant_id UUID,
                                image_url TEXT NOT NULL,
                                alt_text VARCHAR(255),
                                is_primary BOOLEAN DEFAULT FALSE,
                                display_order INTEGER DEFAULT 0,
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                created_by UUID,
                                updated_by UUID,
                                is_deleted BOOLEAN DEFAULT FALSE,
                                CONSTRAINT fk_product_images_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
                                CONSTRAINT fk_product_images_variant FOREIGN KEY (variant_id) REFERENCES product_variants(id) ON DELETE CASCADE,
                                CONSTRAINT fk_product_images_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                CONSTRAINT fk_product_images_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),
                                CONSTRAINT chk_product_images_product_or_variant CHECK ((product_id IS NOT NULL AND variant_id IS NULL) OR (product_id IS NULL AND variant_id IS NOT NULL))
);

-- Store inventory
CREATE TABLE IF NOT EXISTS store_inventory (
                                 id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                 store_id UUID NOT NULL,
                                 product_variant_id UUID NOT NULL,
                                 quantity INTEGER NOT NULL DEFAULT 0,
                                 reserved_quantity INTEGER NOT NULL DEFAULT 0,
                                 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 created_by UUID,
                                 updated_by UUID,
                                 is_deleted BOOLEAN DEFAULT FALSE,
                                 CONSTRAINT fk_store_inventory_store FOREIGN KEY (store_id) REFERENCES stores(id) ON DELETE CASCADE,
                                 CONSTRAINT fk_store_inventory_variant FOREIGN KEY (product_variant_id) REFERENCES product_variants(id),
                                 CONSTRAINT fk_store_inventory_created_by FOREIGN KEY (created_by) REFERENCES users(id),
                                 CONSTRAINT fk_store_inventory_updated_by FOREIGN KEY (updated_by) REFERENCES users(id),
                                 CONSTRAINT uq_store_inventory UNIQUE(store_id, product_variant_id),
                                 CONSTRAINT chk_reserved_le_quantity CHECK (quantity >= 0 AND reserved_quantity >= 0 AND reserved_quantity <= quantity)
);

-- Voucher types table
CREATE TABLE IF NOT EXISTS voucher_types (
                               id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                               type_name VARCHAR(50) NOT NULL UNIQUE,
                               description TEXT,
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               created_by UUID REFERENCES users(id),
                               updated_by UUID REFERENCES users(id),
                               is_deleted BOOLEAN DEFAULT FALSE
);

-- Vouchers table
CREATE TABLE IF NOT EXISTS vouchers (
                          id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                          code VARCHAR(50) NOT NULL,
                          name VARCHAR(255) NOT NULL,
                          voucher_type_id UUID NOT NULL,
                          discount_value DECIMAL(15,2) NOT NULL,
                          minimum_order_amount DECIMAL(15,2) DEFAULT 0.00,
                          maximum_discount_amount DECIMAL(15,2),
                          usage_limit INTEGER,
                          used_count INTEGER DEFAULT 0,
                          valid_from TIMESTAMP NOT NULL,
                          valid_until TIMESTAMP NOT NULL,
                          is_active BOOLEAN DEFAULT TRUE,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          created_by UUID REFERENCES users(id),
                          updated_by UUID REFERENCES users(id),
                          is_deleted BOOLEAN DEFAULT FALSE,
                          CONSTRAINT uq_vouchers_code UNIQUE (code),
                          CONSTRAINT fk_vouchers_type FOREIGN KEY (voucher_type_id) REFERENCES voucher_types(id),
                          CONSTRAINT chk_vouchers_discount CHECK (discount_value >= 0),
                          CONSTRAINT chk_vouchers_validity CHECK (valid_from < valid_until),
                          CONSTRAINT chk_vouchers_usage CHECK (used_count <= COALESCE(usage_limit, used_count + 1))
);

-- User vouchers table
CREATE TABLE IF NOT EXISTS user_vouchers (
                               id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                               user_id UUID NOT NULL,
                               voucher_id UUID NOT NULL,
                               obtained_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               used_at TIMESTAMP,
                               is_used BOOLEAN DEFAULT FALSE,
                               created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                               created_by UUID REFERENCES users(id),
                               updated_by UUID REFERENCES users(id),
                               is_deleted BOOLEAN DEFAULT FALSE,
                               CONSTRAINT fk_user_vouchers_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                               CONSTRAINT fk_user_vouchers_voucher FOREIGN KEY (voucher_id) REFERENCES vouchers(id) ON DELETE CASCADE,
                               CONSTRAINT uq_user_voucher UNIQUE(user_id, voucher_id)
);

-- Order statuses
CREATE TABLE IF NOT EXISTS order_statuses (
                                id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                status_name VARCHAR(50) NOT NULL,
                                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                created_by UUID REFERENCES users(id),
                                updated_by UUID REFERENCES users(id),
                                is_deleted BOOLEAN DEFAULT FALSE,
                                CONSTRAINT uq_order_status_name UNIQUE(status_name)
);

-- Payment methods
CREATE TABLE IF NOT EXISTS payment_methods (
                                 id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                 method_name VARCHAR(50) NOT NULL,
                                 is_active BOOLEAN DEFAULT TRUE,
                                 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 created_by UUID REFERENCES users(id),
                                 updated_by UUID REFERENCES users(id),
                                 is_deleted BOOLEAN DEFAULT FALSE,
                                 CONSTRAINT uq_payment_method_name UNIQUE(method_name)
);

-- Orders table
CREATE TABLE IF NOT EXISTS orders (
                        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                        order_number VARCHAR(50) NOT NULL,
                        user_id UUID NOT NULL,
                        shipping_address_id UUID NOT NULL,
                        subtotal DECIMAL(15,2) NOT NULL,
                        product_discount_amount DECIMAL(15,2) DEFAULT 0.00,
                        voucher_discount_amount DECIMAL(15,2) DEFAULT 0.00,
                        store_discount_amount DECIMAL(15,2) DEFAULT 0.00,
                        tax_amount DECIMAL(15,2) DEFAULT 0.00,
                        base_shipping_fee DECIMAL(15,2) DEFAULT 0.00,
                        shipping_discount_amount DECIMAL(15,2) DEFAULT 0.00,
                        total_amount DECIMAL(15,2) NOT NULL,
                        order_status_id UUID NOT NULL,
                        voucher_id UUID,
                        notes TEXT,
                        ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        confirmed_at TIMESTAMP,
                        shipped_at TIMESTAMP,
                        delivered_at TIMESTAMP,
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        created_by UUID REFERENCES users(id),
                        updated_by UUID REFERENCES users(id),
                        is_deleted BOOLEAN DEFAULT FALSE,
                        CONSTRAINT uq_order_number UNIQUE(order_number),
                        CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id),
                        CONSTRAINT fk_orders_status FOREIGN KEY (order_status_id) REFERENCES order_statuses(id),
                        CONSTRAINT fk_orders_shipping_address FOREIGN KEY (shipping_address_id) REFERENCES user_addresses(id),
                        CONSTRAINT fk_orders_voucher FOREIGN KEY (voucher_id) REFERENCES vouchers(id),
                        CONSTRAINT chk_orders_subtotal CHECK (subtotal >= 0),
                        CONSTRAINT chk_orders_product_discount CHECK (product_discount_amount >= 0),
                        CONSTRAINT chk_orders_voucher_discount CHECK (voucher_discount_amount >= 0),
                        CONSTRAINT chk_orders_store_discount CHECK (store_discount_amount >= 0),
                        CONSTRAINT chk_orders_tax CHECK (tax_amount >= 0),
                        CONSTRAINT chk_orders_shipping_fee CHECK (base_shipping_fee >= 0),
                        CONSTRAINT chk_orders_shipping_discount CHECK (shipping_discount_amount >= 0),
                        CONSTRAINT chk_orders_total_amount CHECK (total_amount >= 0)
);

-- Order items table
CREATE TABLE IF NOT EXISTS order_items (
                             id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                             order_id UUID NOT NULL,
                             product_variant_id UUID NOT NULL,
                             quantity INTEGER NOT NULL,
                             unit_price DECIMAL(15,2) NOT NULL,
                             discount_amount DECIMAL(15,2) DEFAULT 0.00,
                             total_price DECIMAL(15,2) NOT NULL,
                             created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                             created_by UUID REFERENCES users(id),
                             updated_by UUID REFERENCES users(id),
                             is_deleted BOOLEAN DEFAULT FALSE,
                             CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
                             CONSTRAINT fk_order_items_variant FOREIGN KEY (product_variant_id) REFERENCES product_variants(id),
                             CONSTRAINT chk_order_items_quantity CHECK (quantity > 0),
                             CONSTRAINT chk_order_items_unit_price CHECK (unit_price >= 0),
                             CONSTRAINT chk_order_items_discount CHECK (discount_amount >= 0),
                             CONSTRAINT chk_order_items_total CHECK (total_price >= 0)
);

-- Order fees table
CREATE TABLE IF NOT EXISTS order_fees (
                            id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                            order_id UUID NOT NULL,
                            fee_type VARCHAR(50) NOT NULL,
                            fee_name VARCHAR(255) NOT NULL,
                            amount DECIMAL(15,2) NOT NULL,
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            created_by UUID REFERENCES users(id),
                            updated_by UUID REFERENCES users(id),
                            is_deleted BOOLEAN DEFAULT FALSE,
                            CONSTRAINT fk_order_fees_order FOREIGN KEY (order_id) REFERENCES orders(id),
                            CONSTRAINT chk_order_fees_amount CHECK (amount >= 0)
);

-- Payments table
CREATE TABLE IF NOT EXISTS payments (
                                        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
                                        order_id UUID NOT NULL,
                                        payment_method_id UUID NOT NULL,
                                        amount DECIMAL(15,2) NOT NULL,
                                        status VARCHAR(50) NOT NULL,
                                        transaction_id VARCHAR(100),
                                        payment_gateway VARCHAR(100),
                                        gateway_response TEXT,
                                        processed_at TIMESTAMP,
                                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                        created_by UUID REFERENCES users(id),
                                        updated_by UUID REFERENCES users(id),
                                        is_deleted BOOLEAN DEFAULT FALSE,
                                        CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
                                        CONSTRAINT fk_payments_method FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id),
                                        CONSTRAINT chk_payments_amount CHECK (amount >= 0),
                                        CONSTRAINT chk_payments_status CHECK (
                                            status IN (
                                                       'PENDING',
                                                       'SUCCESS',
                                                       'FAILED',
                                                       'CANCELLED',
                                                       'TIMEOUT',
                                                       'REFUNDED'
                                                )
                                            ),
                                        CONSTRAINT uq_transaction_id UNIQUE(transaction_id)
);


-- Trigger to ensure shipping address belongs to the order user
CREATE OR REPLACE FUNCTION check_shipping_address_user()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM user_addresses
        WHERE id = NEW.shipping_address_id
        AND user_id = NEW.user_id
        AND is_deleted = FALSE
    ) THEN
        RAISE EXCEPTION 'Shipping address must belong to the order user';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_shipping_address_user
    BEFORE INSERT OR UPDATE ON orders
                         FOR EACH ROW EXECUTE FUNCTION check_shipping_address_user();


-- Users
CREATE INDEX idx_users_email ON users(email) WHERE is_deleted = FALSE;

-- User addresses
CREATE INDEX idx_user_addresses_user_id ON user_addresses(user_id) WHERE is_deleted = FALSE;
CREATE INDEX idx_user_addresses_id_user_id ON user_addresses(id, user_id) WHERE is_deleted = FALSE;

-- Products
CREATE INDEX idx_products_category_id ON products(category_id) WHERE is_deleted = FALSE;

-- Full-text search index for products
-- Replace the problematic index with a simpler version
-- Instead of this complex weighted index:
-- CREATE INDEX idx_products_fts_weighted ON products USING gin (
--     setweight(to_tsvector('english', name), 'A') ||
--     setweight(to_tsvector('english', COALESCE(description, '')), 'B') ||
--     setweight(to_tsvector('english', COALESCE(brand, '')), 'C')
--     ) WHERE is_deleted = FALSE;

-- Use this simpler approach:
CREATE INDEX idx_products_name_fts ON products USING gin (to_tsvector('english', name)) WHERE is_deleted = FALSE;
CREATE INDEX idx_products_description_fts ON products USING gin (to_tsvector('english', description)) WHERE is_deleted = FALSE AND description IS NOT NULL;
CREATE INDEX idx_products_brand_fts ON products USING gin (to_tsvector('english', brand)) WHERE is_deleted = FALSE AND brand IS NOT NULL;

-- Product variants
CREATE INDEX idx_product_variants_product_id ON product_variants(product_id) WHERE is_deleted = FALSE;

-- Store inventory (composite index for faster lookups on store and product variant)
CREATE INDEX idx_store_inventory_address_variant ON store_inventory(store_id, product_variant_id) WHERE is_deleted = FALSE;

-- Orders
CREATE INDEX idx_orders_user_id ON orders(user_id) WHERE is_deleted = FALSE;
CREATE INDEX idx_orders_order_number ON orders(order_number) WHERE is_deleted = FALSE;
CREATE INDEX idx_orders_ordered_at ON orders(ordered_at) WHERE is_deleted = FALSE;

-- Order items
CREATE INDEX idx_order_items_order_id ON order_items(order_id) WHERE is_deleted = FALSE;

-- User vouchers
CREATE INDEX idx_user_vouchers_user_id ON user_vouchers(user_id) WHERE is_deleted = FALSE;

-- Vouchers
CREATE INDEX idx_vouchers_code ON vouchers(code) WHERE is_deleted = FALSE;

-- Payments
CREATE INDEX idx_payments_order_id ON payments(order_id) WHERE is_deleted = FALSE;