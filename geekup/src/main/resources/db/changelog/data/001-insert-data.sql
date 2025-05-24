-- Sample Data for E-commerce Database
-- Note: Replace uuid_generate_v4() with actual UUIDs in production

-- Insert sample users
INSERT INTO users (id, name, email, phone, password_hash, gender, date_of_birth, created_at) VALUES
                                                                                                 ('550e8400-e29b-41d4-a716-446655440001', 'John Doe', 'john.doe@email.com', '+84901234567', '$2b$10$rQ5K5X5X5X5X5X5X5X5X5u', 'male', '1990-05-15', '2024-01-01 10:00:00'),
                                                                                                 ('550e8400-e29b-41d4-a716-446655440002', 'Jane Smith', 'jane.smith@email.com', '+84901234568', '$2b$10$rQ5K5X5X5X5X5X5X5X5X5v', 'female', '1992-08-22', '2024-01-02 11:00:00'),
                                                                                                 ('550e8400-e29b-41d4-a716-446655440003', 'Mike Johnson', 'mike.johnson@email.com', '+84901234569', '$2b$10$rQ5K5X5X5X5X5X5X5X5X5w', 'male', '1988-12-10', '2024-01-03 09:30:00'),
                                                                                                 ('550e8400-e29b-41d4-a716-446655440004', 'Sarah Wilson', 'sarah.wilson@email.com', '+84901234570', '$2b$10$rQ5K5X5X5X5X5X5X5X5X5x', 'female', '1995-03-18', '2024-01-04 14:15:00'),
                                                                                                 ('550e8400-e29b-41d4-a716-446655440005', 'Admin User', 'admin@ecommerce.com', '+84901234571', '$2b$10$rQ5K5X5X5X5X5X5X5X5X5y', 'other', '1985-07-07', '2024-01-01 08:00:00');

-- Insert user addresses
INSERT INTO user_addresses (id, user_id, province, district, commune, detailed_address, housing_type, is_default, created_by) VALUES
                                                                                                                                  ('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Ho Chi Minh City', 'District 1', 'Ben Nghe Ward', '123 Nguyen Hue Street, Apartment 501', 'chung cư', true, '550e8400-e29b-41d4-a716-446655440001'),
                                                                                                                                  ('650e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440002', 'Hanoi', 'Hoan Kiem District', 'Hang Bac Ward', '456 Hang Bac Street', 'nhà riêng', true, '550e8400-e29b-41d4-a716-446655440002'),
                                                                                                                                  ('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440003', 'Da Nang', 'Hai Chau District', 'Thach Thang Ward', '789 Bach Dang Street, Floor 3', 'văn phòng', true, '550e8400-e29b-41d4-a716-446655440003'),
                                                                                                                                  ('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440004', 'Ho Chi Minh City', 'District 7', 'Tan Phu Ward', '321 Nguyen Thi Thap Street', 'nhà riêng', true, '550e8400-e29b-41d4-a716-446655440004'),
                                                                                                                                  ('650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440001', 'Ho Chi Minh City', 'District 3', 'Ward 12', '88 Vo Van Tan Street', 'nhà riêng', false, '550e8400-e29b-41d4-a716-446655440001');

-- Insert categories
INSERT INTO categories (id, name, description, parent_category_id, image_url, is_active, sort_order, created_by) VALUES
                                                                                                                     ('750e8400-e29b-41d4-a716-446655440001', 'Electronics', 'Electronic devices and gadgets', NULL, 'https://example.com/images/electronics.jpg', true, 1, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                     ('750e8400-e29b-41d4-a716-446655440002', 'Fashion', 'Clothing and accessories', NULL, 'https://example.com/images/fashion.jpg', true, 2, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                     ('750e8400-e29b-41d4-a716-446655440003', 'Home & Garden', 'Home improvement and garden supplies', NULL, 'https://example.com/images/home-garden.jpg', true, 3, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                     ('750e8400-e29b-41d4-a716-446655440004', 'Smartphones', 'Mobile phones and accessories', '750e8400-e29b-41d4-a716-446655440001', 'https://example.com/images/smartphones.jpg', true, 1, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                     ('750e8400-e29b-41d4-a716-446655440005', 'Laptops', 'Portable computers', '750e8400-e29b-41d4-a716-446655440001', 'https://example.com/images/laptops.jpg', true, 2, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                     ('750e8400-e29b-41d4-a716-446655440006', 'Men''s Clothing', 'Clothing for men', '750e8400-e29b-41d4-a716-446655440002', 'https://example.com/images/mens-clothing.jpg', true, 1, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                     ('750e8400-e29b-41d4-a716-446655440007', 'Women''s Clothing', 'Clothing for women', '750e8400-e29b-41d4-a716-446655440002', 'https://example.com/images/womens-clothing.jpg', true, 2, '550e8400-e29b-41d4-a716-446655440005');

-- Insert store operating hours
INSERT INTO store_operating_hours (id, day_of_week, open_time, close_time, created_by) VALUES
                                                                                           ('850e8400-e29b-41d4-a716-446655440001', 1, '08:00', '22:00', '550e8400-e29b-41d4-a716-446655440005'), -- Monday
                                                                                           ('850e8400-e29b-41d4-a716-446655440002', 2, '08:00', '22:00', '550e8400-e29b-41d4-a716-446655440005'), -- Tuesday
                                                                                           ('850e8400-e29b-41d4-a716-446655440003', 3, '08:00', '22:00', '550e8400-e29b-41d4-a716-446655440005'), -- Wednesday
                                                                                           ('850e8400-e29b-41d4-a716-446655440004', 4, '08:00', '22:00', '550e8400-e29b-41d4-a716-446655440005'), -- Thursday
                                                                                           ('850e8400-e29b-41d4-a716-446655440005', 5, '08:00', '22:00', '550e8400-e29b-41d4-a716-446655440005'), -- Friday
                                                                                           ('850e8400-e29b-41d4-a716-446655440006', 6, '09:00', '21:00', '550e8400-e29b-41d4-a716-446655440005'), -- Saturday
                                                                                           ('850e8400-e29b-41d4-a716-446655440007', 0, '10:00', '20:00', '550e8400-e29b-41d4-a716-446655440005'); -- Sunday

-- Insert stores
INSERT INTO stores (id, name, phone, email, is_active, created_by) VALUES
                                                                       ('950e8400-e29b-41d4-a716-446655440001', 'Tech Store Downtown', '+84281234567', 'downtown@techstore.com', true, '550e8400-e29b-41d4-a716-446655440005'),
                                                                       ('950e8400-e29b-41d4-a716-446655440002', 'Fashion Central', '+84281234568', 'central@fashionstore.com', true, '550e8400-e29b-41d4-a716-446655440005'),
                                                                       ('950e8400-e29b-41d4-a716-446655440003', 'Home Depot Branch', '+84281234569', 'branch@homedepot.com', true, '550e8400-e29b-41d4-a716-446655440005');

-- Insert store addresses
INSERT INTO store_addresses (id, store_id, province, district, commune, detailed_address, is_main_address, latitude, longitude, created_by) VALUES
                                                                                                                                                ('a50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440001', 'Ho Chi Minh City', 'District 1', 'Ben Nghe Ward', '100 Dong Khoi Street', true, 10.7769, 106.7009, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                ('a50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440002', 'Hanoi', 'Ba Dinh District', 'Kim Ma Ward', '200 Kim Ma Street', true, 21.0285, 105.8542, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                ('a50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440003', 'Da Nang', 'Hai Chau District', 'Hai Chau 1 Ward', '300 Tran Phu Street', true, 16.0544, 108.2022, '550e8400-e29b-41d4-a716-446655440005');

-- Insert store operating schedule
INSERT INTO store_operating_schedule (id, store_id, operating_hour_id, created_by) VALUES
                                                                                       ('b50e8400-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                       ('b50e8400-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                       ('b50e8400-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                       ('b50e8400-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                       ('b50e8400-e29b-41d4-a716-446655440005', '950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                       ('b50e8400-e29b-41d4-a716-446655440006', '950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                       ('b50e8400-e29b-41d4-a716-446655440007', '950e8400-e29b-41d4-a716-446655440001', '850e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440005');

-- Insert products
INSERT INTO products (id, name, description, category_id, base_price, discount_percentage, is_vat_included, sku, brand, guarantee_info, likes_count, created_by) VALUES
                                                                                                                                                                     ('c50e8400-e29b-41d4-a716-446655440001', 'iPhone 15 Pro', 'Latest iPhone with advanced camera system', '750e8400-e29b-41d4-a716-446655440004', 25000000.00, 5.00, false, 'IP15PRO001', 'Apple', '12 months warranty', 150, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                     ('c50e8400-e29b-41d4-a716-446655440002', 'Samsung Galaxy S24', 'Flagship Android smartphone', '750e8400-e29b-41d4-a716-446655440004', 22000000.00, 10.00, false, 'SGS24001', 'Samsung', '24 months warranty', 89, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                     ('c50e8400-e29b-41d4-a716-446655440003', 'MacBook Pro M3', 'Professional laptop for creators', '750e8400-e29b-41d4-a716-446655440005', 45000000.00, 0.00, false, 'MBPM3001', 'Apple', '12 months warranty', 203, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                     ('c50e8400-e29b-41d4-a716-446655440004', 'Dell XPS 13', 'Ultrabook for professionals', '750e8400-e29b-41d4-a716-446655440005', 28000000.00, 8.00, false, 'DXPS13001', 'Dell', '24 months warranty', 67, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                     ('c50e8400-e29b-41d4-a716-446655440005', 'Men''s Cotton T-Shirt', 'Comfortable cotton t-shirt for daily wear', '750e8400-e29b-41d4-a716-446655440006', 350000.00, 15.00, true, 'MCT001', 'Uniqlo', '30 days return policy', 45, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                     ('c50e8400-e29b-41d4-a716-446655440006', 'Women''s Summer Dress', 'Elegant summer dress for women', '750e8400-e29b-41d4-a716-446655440007', 890000.00, 20.00, true, 'WSD001', 'Zara', '30 days return policy', 78, '550e8400-e29b-41d4-a716-446655440005');

-- Insert product attributes
INSERT INTO product_attributes (id, attribute_name, attribute_type, created_by) VALUES
                                                                                    ('d50e8400-e29b-41d4-a716-446655440001', 'Color', 'color', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                    ('d50e8400-e29b-41d4-a716-446655440002', 'Size', 'size', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                    ('d50e8400-e29b-41d4-a716-446655440003', 'Storage', 'text', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                    ('d50e8400-e29b-41d4-a716-446655440004', 'RAM', 'text', '550e8400-e29b-41d4-a716-446655440005');

-- Insert product attribute values
INSERT INTO product_attribute_values (id, attribute_id, attribute_value, display_order, created_by) VALUES
-- Colors
('e50e8400-e29b-41d4-a716-446655440001', 'd50e8400-e29b-41d4-a716-446655440001', 'Black', 1, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440002', 'd50e8400-e29b-41d4-a716-446655440001', 'White', 2, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440003', 'd50e8400-e29b-41d4-a716-446655440001', 'Blue', 3, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440004', 'd50e8400-e29b-41d4-a716-446655440001', 'Red', 4, '550e8400-e29b-41d4-a716-446655440005'),
-- Sizes
('e50e8400-e29b-41d4-a716-446655440005', 'd50e8400-e29b-41d4-a716-446655440002', 'XS', 1, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440006', 'd50e8400-e29b-41d4-a716-446655440002', 'S', 2, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440007', 'd50e8400-e29b-41d4-a716-446655440002', 'M', 3, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440008', 'd50e8400-e29b-41d4-a716-446655440002', 'L', 4, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440009', 'd50e8400-e29b-41d4-a716-446655440002', 'XL', 5, '550e8400-e29b-41d4-a716-446655440005'),
-- Storage
('e50e8400-e29b-41d4-a716-446655440010', 'd50e8400-e29b-41d4-a716-446655440003', '128GB', 1, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440011', 'd50e8400-e29b-41d4-a716-446655440003', '256GB', 2, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440012', 'd50e8400-e29b-41d4-a716-446655440003', '512GB', 3, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440013', 'd50e8400-e29b-41d4-a716-446655440003', '1TB', 4, '550e8400-e29b-41d4-a716-446655440005'),
-- RAM
('e50e8400-e29b-41d4-a716-446655440014', 'd50e8400-e29b-41d4-a716-446655440004', '8GB', 1, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440015', 'd50e8400-e29b-41d4-a716-446655440004', '16GB', 2, '550e8400-e29b-41d4-a716-446655440005'),
('e50e8400-e29b-41d4-a716-446655440016', 'd50e8400-e29b-41d4-a716-446655440004', '32GB', 3, '550e8400-e29b-41d4-a716-446655440005');

-- Insert product variants
INSERT INTO product_variants (id, product_id, variant_sku, price_adjustment, created_by) VALUES
-- iPhone 15 Pro variants
('f50e8400-e29b-41d4-a716-446655440001', 'c50e8400-e29b-41d4-a716-446655440001', 'IP15PRO001-BLK-128', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440002', 'c50e8400-e29b-41d4-a716-446655440001', 'IP15PRO001-BLK-256', 3000000.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440003', 'c50e8400-e29b-41d4-a716-446655440001', 'IP15PRO001-WHT-128', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440004', 'c50e8400-e29b-41d4-a716-446655440001', 'IP15PRO001-WHT-256', 3000000.00, '550e8400-e29b-41d4-a716-446655440005'),
-- Samsung Galaxy S24 variants
('f50e8400-e29b-41d4-a716-446655440005', 'c50e8400-e29b-41d4-a716-446655440002', 'SGS24001-BLK-256', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440006', 'c50e8400-e29b-41d4-a716-446655440002', 'SGS24001-BLU-256', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
-- MacBook Pro M3 variants
('f50e8400-e29b-41d4-a716-446655440007', 'c50e8400-e29b-41d4-a716-446655440003', 'MBPM3001-8GB-512', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440008', 'c50e8400-e29b-41d4-a716-446655440003', 'MBPM3001-16GB-512', 5000000.00, '550e8400-e29b-41d4-a716-446655440005'),
-- T-shirt variants
('f50e8400-e29b-41d4-a716-446655440009', 'c50e8400-e29b-41d4-a716-446655440005', 'MCT001-BLK-M', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440010', 'c50e8400-e29b-41d4-a716-446655440005', 'MCT001-BLK-L', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440011', 'c50e8400-e29b-41d4-a716-446655440005', 'MCT001-WHT-M', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
-- Women's dress variants
('f50e8400-e29b-41d4-a716-446655440012', 'c50e8400-e29b-41d4-a716-446655440006', 'WSD001-RED-S', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440013', 'c50e8400-e29b-41d4-a716-446655440006', 'WSD001-RED-M', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('f50e8400-e29b-41d4-a716-446655440014', 'c50e8400-e29b-41d4-a716-446655440006', 'WSD001-BLU-S', 0.00, '550e8400-e29b-41d4-a716-446655440005');

-- Insert product variant attributes
INSERT INTO product_variant_attributes (id, variant_id, attribute_value_id, created_by) VALUES
-- iPhone 15 Pro Black 128GB
('150e8401-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440001', 'e50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005'), -- Black
('150e8401-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440001', 'e50e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005'), -- 128GB
-- iPhone 15 Pro Black 256GB
('150e8401-e29b-41d4-a716-446655440003', 'f50e8400-e29b-41d4-a716-446655440002', 'e50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005'), -- Black
('150e8401-e29b-41d4-a716-446655440004', 'f50e8400-e29b-41d4-a716-446655440002', 'e50e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005'), -- 256GB
-- iPhone 15 Pro White 128GB
('150e8401-e29b-41d4-a716-446655440005', 'f50e8400-e29b-41d4-a716-446655440003', 'e50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005'), -- White
('150e8401-e29b-41d4-a716-446655440006', 'f50e8400-e29b-41d4-a716-446655440003', 'e50e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005'), -- 128GB
-- MacBook Pro variants
('150e8401-e29b-41d4-a716-446655440007', 'f50e8400-e29b-41d4-a716-446655440007', 'e50e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440005'), -- 8GB RAM
('150e8401-e29b-41d4-a716-446655440008', 'f50e8400-e29b-41d4-a716-446655440007', 'e50e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440005'), -- 512GB Storage
-- T-shirt Black Medium
('150e8401-e29b-41d4-a716-446655440009', 'f50e8400-e29b-41d4-a716-446655440009', 'e50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005'), -- Black
('150e8401-e29b-41d4-a716-446655440010', 'f50e8400-e29b-41d4-a716-446655440009', 'e50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440005'), -- M
-- T-shirt Black Large
('150e8401-e29b-41d4-a716-446655440011', 'f50e8400-e29b-41d4-a716-446655440010', 'e50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005'), -- Black
('150e8401-e29b-41d4-a716-446655440012', 'f50e8400-e29b-41d4-a716-446655440010', 'e50e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440005'), -- L
-- T-shirt White Medium
('150e8401-e29b-41d4-a716-446655440013', 'f50e8400-e29b-41d4-a716-446655440011', 'e50e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440005'), -- White
('150e8401-e29b-41d4-a716-446655440014', 'f50e8400-e29b-41d4-a716-446655440011', 'e50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440005'), -- M
-- Women's dress Red Small
('150e8401-e29b-41d4-a716-446655440015', 'f50e8400-e29b-41d4-a716-446655440012', 'e50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440005'), -- Red
('150e8401-e29b-41d4-a716-446655440016', 'f50e8400-e29b-41d4-a716-446655440012', 'e50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440005'), -- S
-- Women's dress Red Medium
('150e8401-e29b-41d4-a716-446655440017', 'f50e8400-e29b-41d4-a716-446655440013', 'e50e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440005'), -- Red
('150e8401-e29b-41d4-a716-446655440018', 'f50e8400-e29b-41d4-a716-446655440013', 'e50e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440005'), -- M
-- Women's dress Blue Small
('150e8401-e29b-41d4-a716-446655440019', 'f50e8400-e29b-41d4-a716-446655440014', 'e50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005'), -- Blue
('150e8401-e29b-41d4-a716-446655440020', 'f50e8400-e29b-41d4-a716-446655440014', 'e50e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440005'), -- S
-- Samsung Galaxy variants
('150e8401-e29b-41d4-a716-446655440021', 'f50e8400-e29b-41d4-a716-446655440005', 'e50e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440005'), -- Black
('150e8401-e29b-41d4-a716-446655440022', 'f50e8400-e29b-41d4-a716-446655440005', 'e50e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005'), -- 256GB
('150e8401-e29b-41d4-a716-446655440023', 'f50e8400-e29b-41d4-a716-446655440006', 'e50e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440005'), -- Blue
('150e8401-e29b-41d4-a716-446655440024', 'f50e8400-e29b-41d4-a716-446655440006', 'e50e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440005'); -- 256GB

-- Insert product images
INSERT INTO product_images (id, product_id, variant_id, image_url, alt_text, is_primary, display_order, created_by) VALUES
-- iPhone 15 Pro product images
('250e8401-e29b-41d4-a716-446655440001', 'c50e8400-e29b-41d4-a716-446655440001', NULL, 'https://example.com/images/iphone15pro-main.jpg', 'iPhone 15 Pro main image', true, 1, '550e8400-e29b-41d4-a716-446655440005'),
('250e8401-e29b-41d4-a716-446655440002', 'c50e8400-e29b-41d4-a716-446655440001', NULL, 'https://example.com/images/iphone15pro-side.jpg', 'iPhone 15 Pro side view', false, 2, '550e8400-e29b-41d4-a716-446655440005'),
-- iPhone variant specific images
('250e8401-e29b-41d4-a716-446655440003', NULL, 'f50e8400-e29b-41d4-a716-446655440001', 'https://example.com/images/iphone15pro-black.jpg', 'iPhone 15 Pro Black', false, 3, '550e8400-e29b-41d4-a716-446655440005'),
('250e8401-e29b-41d4-a716-446655440004', NULL, 'f50e8400-e29b-41d4-a716-446655440003', 'https://example.com/images/iphone15pro-white.jpg', 'iPhone 15 Pro White', false, 4, '550e8400-e29b-41d4-a716-446655440005'),
-- Samsung Galaxy S24 images
('250e8401-e29b-41d4-a716-446655440005', 'c50e8400-e29b-41d4-a716-446655440002', NULL, 'https://example.com/images/galaxy-s24-main.jpg', 'Samsung Galaxy S24 main image', true, 1, '550e8400-e29b-41d4-a716-446655440005'),
('250e8401-e29b-41d4-a716-446655440006', 'c50e8400-e29b-41d4-a716-446655440002', NULL, 'https://example.com/images/galaxy-s24-back.jpg', 'Samsung Galaxy S24 back view', false, 2, '550e8400-e29b-41d4-a716-446655440005'),
-- MacBook Pro images
('250e8401-e29b-41d4-a716-446655440007', 'c50e8400-e29b-41d4-a716-446655440003', NULL, 'https://example.com/images/macbook-pro-m3.jpg', 'MacBook Pro M3 main image', true, 1, '550e8400-e29b-41d4-a716-446655440005'),
-- T-shirt images
('250e8401-e29b-41d4-a716-446655440008', 'c50e8400-e29b-41d4-a716-446655440005', NULL, 'https://example.com/images/cotton-tshirt.jpg', 'Men Cotton T-Shirt', true, 1, '550e8400-e29b-41d4-a716-446655440005'),
-- Women's dress images
('250e8401-e29b-41d4-a716-446655440009', 'c50e8400-e29b-41d4-a716-446655440006', NULL, 'https://example.com/images/summer-dress.jpg', 'Women Summer Dress', true, 1, '550e8400-e29b-41d4-a716-446655440005');

-- Insert store inventory
INSERT INTO store_inventory (id, store_id, product_variant_id, quantity, reserved_quantity, created_by) VALUES
-- Tech Store Downtown inventory
('350e8401-e29b-41d4-a716-446655440001', '950e8400-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440001', 25, 2, '550e8400-e29b-41d4-a716-446655440005'), -- iPhone Black 128GB
('350e8401-e29b-41d4-a716-446655440002', '950e8400-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440002', 15, 1, '550e8400-e29b-41d4-a716-446655440005'), -- iPhone Black 256GB
('350e8401-e29b-41d4-a716-446655440003', '950e8400-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440003', 20, 0, '550e8400-e29b-41d4-a716-446655440005'), -- iPhone White 128GB
('350e8401-e29b-41d4-a716-446655440004', '950e8400-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440005', 30, 3, '550e8400-e29b-41d4-a716-446655440005'), -- Samsung Black 256GB
('350e8401-e29b-41d4-a716-446655440005', '950e8400-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440007', 8, 1, '550e8400-e29b-41d4-a716-446655440005'), -- MacBook 8GB
('350e8401-e29b-41d4-a716-446655440006', '950e8400-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440008', 5, 0, '550e8400-e29b-41d4-a716-446655440005'), -- MacBook 16GB
-- Fashion Central inventory
('350e8401-e29b-41d4-a716-446655440007', '950e8400-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440009', 50, 5, '550e8400-e29b-41d4-a716-446655440005'), -- T-shirt Black M
('350e8401-e29b-41d4-a716-446655440008', '950e8400-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440010', 45, 3, '550e8400-e29b-41d4-a716-446655440005'), -- T-shirt Black L
('350e8401-e29b-41d4-a716-446655440009', '950e8400-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440011', 40, 2, '550e8400-e29b-41d4-a716-446655440005'), -- T-shirt White M
('350e8401-e29b-41d4-a716-446655440010', '950e8400-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440012', 25, 1, '550e8400-e29b-41d4-a716-446655440005'), -- Dress Red S
('350e8401-e29b-41d4-a716-446655440011', '950e8400-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440013', 30, 2, '550e8400-e29b-41d4-a716-446655440005'), -- Dress Red M
('350e8401-e29b-41d4-a716-446655440012', '950e8400-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440014', 20, 0, '550e8400-e29b-41d4-a716-446655440005'); -- Dress Blue S

-- Insert voucher types
INSERT INTO voucher_types (id, type_name, description, created_by) VALUES
                                                                       ('450e8401-e29b-41d4-a716-446655440001', 'Percentage Discount', 'Discount based on percentage of order value', '550e8400-e29b-41d4-a716-446655440005'),
                                                                       ('450e8401-e29b-41d4-a716-446655440002', 'Fixed Amount Discount', 'Fixed amount discount from order total', '550e8400-e29b-41d4-a716-446655440005'),
                                                                       ('450e8401-e29b-41d4-a716-446655440003', 'Free Shipping', 'Free shipping voucher', '550e8400-e29b-41d4-a716-446655440005'),
                                                                       ('450e8401-e29b-41d4-a716-446655440004', 'Buy One Get One', 'BOGO promotion voucher', '550e8400-e29b-41d4-a716-446655440005');

-- Insert vouchers
INSERT INTO vouchers (id, code, name, voucher_type_id, discount_value, minimum_order_amount, maximum_discount_amount, usage_limit, used_count, valid_from, valid_until, created_by) VALUES
                                                                                                                                                                                        ('550e8401-e29b-41d4-a716-446655440001', 'WELCOME10', 'Welcome 10% Discount', '450e8401-e29b-41d4-a716-446655440001', 10.00, 500000.00, 1000000.00, 1000, 45, '2024-01-01 00:00:00', '2024-12-31 23:59:59', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                                        ('550e8401-e29b-41d4-a716-446655440002', 'SAVE50K', 'Save 50,000 VND', '450e8401-e29b-41d4-a716-446655440002', 50000.00, 300000.00, NULL, 500, 23, '2024-01-01 00:00:00', '2024-06-30 23:59:59', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                                        ('550e8401-e29b-41d4-a716-446655440003', 'FREESHIP', 'Free Shipping', '450e8401-e29b-41d4-a716-446655440003', 100000.00, 1000000.00, 100000.00, 2000, 167, '2024-01-01 00:00:00', '2024-12-31 23:59:59', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                                        ('550e8401-e29b-41d4-a716-446655440004', 'STUDENT15', 'Student 15% Discount', '450e8401-e29b-41d4-a716-446655440001', 15.00, 200000.00, 500000.00, 100, 12, '2024-01-01 00:00:00', '2024-12-31 23:59:59', '550e8400-e29b-41d4-a716-446655440005'),
                                                                                                                                                                                        ('550e8401-e29b-41d4-a716-446655440005', 'SUMMER20', 'Summer Sale 20%', '450e8401-e29b-41d4-a716-446655440001', 20.00, 800000.00, 2000000.00, 300, 89, '2024-06-01 00:00:00', '2024-08-31 23:59:59', '550e8400-e29b-41d4-a716-446655440005');

-- Insert user vouchers
INSERT INTO user_vouchers (id, user_id, voucher_id, obtained_at, used_at, is_used, created_by) VALUES
                                                                                                   ('650e8401-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', '550e8401-e29b-41d4-a716-446655440001', '2024-01-01 10:30:00', '2024-01-15 14:20:00', true, '550e8400-e29b-41d4-a716-446655440001'),
                                                                                                   ('650e8401-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8401-e29b-41d4-a716-446655440003', '2024-01-05 09:15:00', NULL, false, '550e8400-e29b-41d4-a716-446655440001'),
                                                                                                   ('650e8401-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', '550e8401-e29b-41d4-a716-446655440002', '2024-01-02 11:30:00', '2024-01-10 16:45:00', true, '550e8400-e29b-41d4-a716-446655440002'),
                                                                                                   ('650e8401-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', '550e8401-e29b-41d4-a716-446655440004', '2024-01-03 13:20:00', NULL, false, '550e8400-e29b-41d4-a716-446655440002'),
                                                                                                   ('650e8401-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', '550e8401-e29b-41d4-a716-446655440005', '2024-06-01 10:00:00', NULL, false, '550e8400-e29b-41d4-a716-446655440003'),
                                                                                                   ('650e8401-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440004', '550e8401-e29b-41d4-a716-446655440001', '2024-01-04 14:30:00', NULL, false, '550e8400-e29b-41d4-a716-446655440004');

-- Insert order statuses
INSERT INTO order_statuses (id, status_name, created_by) VALUES
                                                             ('750e8401-e29b-41d4-a716-446655440001', 'Pending', '550e8400-e29b-41d4-a716-446655440005'),
                                                             ('750e8401-e29b-41d4-a716-446655440002', 'Confirmed', '550e8400-e29b-41d4-a716-446655440005'),
                                                             ('750e8401-e29b-41d4-a716-446655440003', 'Processing', '550e8400-e29b-41d4-a716-446655440005'),
                                                             ('750e8401-e29b-41d4-a716-446655440004', 'Shipped', '550e8400-e29b-41d4-a716-446655440005'),
                                                             ('750e8401-e29b-41d4-a716-446655440005', 'Delivered', '550e8400-e29b-41d4-a716-446655440005'),
                                                             ('750e8401-e29b-41d4-a716-446655440006', 'Cancelled', '550e8400-e29b-41d4-a716-446655440005'),
                                                             ('750e8401-e29b-41d4-a716-446655440007', 'Returned', '550e8400-e29b-41d4-a716-446655440005');

-- Insert payment methods
INSERT INTO payment_methods (id, method_name, created_by) VALUES
                                                              ('850e8401-e29b-41d4-a716-446655440001', 'Cash on Delivery', '550e8400-e29b-41d4-a716-446655440005'),
                                                              ('850e8401-e29b-41d4-a716-446655440002', 'Credit Card', '550e8400-e29b-41d4-a716-446655440005'),
                                                              ('850e8401-e29b-41d4-a716-446655440003', 'Debit Card', '550e8400-e29b-41d4-a716-446655440005'),
                                                              ('850e8401-e29b-41d4-a716-446655440004', 'Bank Transfer', '550e8400-e29b-41d4-a716-446655440005'),
                                                              ('850e8401-e29b-41d4-a716-446655440005', 'MoMo Wallet', '550e8400-e29b-41d4-a716-446655440005'),
                                                              ('850e8401-e29b-41d4-a716-446655440006', 'ZaloPay', '550e8400-e29b-41d4-a716-446655440005'),
                                                              ('850e8401-e29b-41d4-a716-446655440007', 'VNPay', '550e8400-e29b-41d4-a716-446655440005');


-- Sample Data for Orders, Order Items, and Order Fees
-- Note: Replace uuid_generate_v4() with actual UUIDs in production

-- Insert sample orders
INSERT INTO orders (id, order_number, user_id, shipping_address_id, subtotal, product_discount_amount, voucher_discount_amount, store_discount_amount, tax_amount, base_shipping_fee, shipping_discount_amount, total_amount, order_status_id, payment_method_id, voucher_id, notes, ordered_at, confirmed_at, shipped_at, delivered_at, created_by) VALUES
-- Order 1: John Doe - iPhone purchase with discount
('950e8401-e29b-41d4-a716-446655440001', 'ORD-2024-000001', '550e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', 25000000.00, 1250000.00, 2375000.00, 0.00, 2137500.00, 50000.00, 0.00, 23562500.00, '750e8401-e29b-41d4-a716-446655440005', '850e8401-e29b-41d4-a716-446655440002', '550e8401-e29b-41d4-a716-446655440001', 'Please handle with care', '2024-01-15 10:30:00', '2024-01-15 11:00:00', '2024-01-16 09:00:00', '2024-01-18 14:30:00', '550e8400-e29b-41d4-a716-446655440001'),

-- Order 2: Jane Smith - Fashion items with fixed discount
('950e8401-e29b-41d4-a716-446655440002', 'ORD-2024-000002', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', 1240000.00, 186000.00, 50000.00, 0.00, 100400.00, 30000.00, 0.00, 1134400.00, '750e8401-e29b-41d4-a716-446655440005', '850e8401-e29b-41d4-a716-446655440005', '550e8401-e29b-41d4-a716-446655440002', 'Gift wrapping requested', '2024-01-10 15:45:00', '2024-01-10 16:15:00', '2024-01-11 10:30:00', '2024-01-13 16:20:00', '550e8400-e29b-41d4-a716-446655440002'),

-- Order 3: Mike Johnson - Multiple tech items
('950e8401-e29b-41d4-a716-446655440003', 'ORD-2024-000003', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', 67000000.00, 2200000.00, 0.00, 0.00, 6480000.00, 0.00, 0.00, 71280000.00, '750e8401-e29b-41d4-a716-446655440004', '850e8401-e29b-41d4-a716-446655440004', NULL, 'Expedited shipping requested', '2024-01-20 09:15:00', '2024-01-20 10:00:00', '2024-01-21 14:00:00', NULL, '550e8400-e29b-41d4-a716-446655440003'),

-- Order 4: Sarah Wilson - Pending order
('950e8401-e29b-41d4-a716-446655440004', 'ORD-2024-000004', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440004', 1050000.00, 157500.00, 0.00, 0.00, 89250.00, 25000.00, 0.00, 1006750.00, '750e8401-e29b-41d4-a716-446655440001', '850e8401-e29b-41d4-a716-446655440001', NULL, 'Call before delivery', '2024-01-25 11:20:00', NULL, NULL, NULL, '550e8400-e29b-41d4-a716-446655440004'),

-- Order 5: John Doe - Second order, cancelled
('950e8401-e29b-41d4-a716-446655440005', 'ORD-2024-000005', '550e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440005', 712000.00, 142400.00, 0.00, 0.00, 56980.00, 35000.00, 0.00, 661580.00, '750e8401-e29b-41d4-a716-446655440006', '850e8401-e29b-41d4-a716-446655440003', NULL, 'Customer requested cancellation', '2024-01-22 13:30:00', '2024-01-22 14:00:00', NULL, NULL, '550e8400-e29b-41d4-a716-446655440001'),

-- Order 6: Jane Smith - Processing order
('950e8401-e29b-41d4-a716-446655440006', 'ORD-2024-000006', '550e8400-e29b-41d4-a716-446655440002', '650e8400-e29b-41d4-a716-446655440002', 19800000.00, 1980000.00, 0.00, 0.00, 1782000.00, 40000.00, 40000.00, 19582000.00, '750e8401-e29b-41d4-a716-446655440003', '850e8401-e29b-41d4-a716-446655440006', '550e8401-e29b-41d4-a716-446655440003', 'Free shipping applied', '2024-01-28 16:45:00', '2024-01-28 17:30:00', NULL, NULL, '550e8400-e29b-41d4-a716-446655440002'),

-- Order 7: Mike Johnson - Small order confirmed
('950e8401-e29b-41d4-a716-446655440007', 'ORD-2024-000007', '550e8400-e29b-41d4-a716-446655440003', '650e8400-e29b-41d4-a716-446655440003', 350000.00, 52500.00, 0.00, 0.00, 29750.00, 20000.00, 0.00, 347250.00, '750e8401-e29b-41d4-a716-446655440002', '850e8401-e29b-41d4-a716-446655440007', NULL, NULL, '2024-01-30 10:15:00', '2024-01-30 11:30:00', NULL, NULL, '550e8400-e29b-41d4-a716-446655440003');

-- Insert order items
INSERT INTO order_items (id, order_id, product_variant_id, quantity, unit_price, discount_amount, total_price, created_by) VALUES
-- Order 1 items (iPhone purchase)
('a50e8401-e29b-41d4-a716-446655440001', '950e8401-e29b-41d4-a716-446655440001', 'f50e8400-e29b-41d4-a716-446655440001', 1, 25000000.00, 1250000.00, 23750000.00, '550e8400-e29b-41d4-a716-446655440001'),

-- Order 2 items (Fashion items)
('a50e8401-e29b-41d4-a716-446655440002', '950e8401-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440009', 2, 350000.00, 52500.00, 647500.00, '550e8400-e29b-41d4-a716-446655440002'),
('a50e8401-e29b-41d4-a716-446655440003', '950e8401-e29b-41d4-a716-446655440002', 'f50e8400-e29b-41d4-a716-446655440012', 1, 890000.00, 133500.00, 756500.00, '550e8400-e29b-41d4-a716-446655440002'),

-- Order 3 items (Multiple tech items)
('a50e8401-e29b-41d4-a716-446655440004', '950e8401-e29b-41d4-a716-446655440003', 'f50e8400-e29b-41d4-a716-446655440005', 1, 22000000.00, 2200000.00, 19800000.00, '550e8400-e29b-41d4-a716-446655440003'),
('a50e8401-e29b-41d4-a716-446655440005', '950e8401-e29b-41d4-a716-446655440003', 'f50e8400-e29b-41d4-a716-446655440007', 1, 45000000.00, 0.00, 45000000.00, '550e8400-e29b-41d4-a716-446655440003'),

-- Order 4 items (Pending order)
('a50e8401-e29b-41d4-a716-446655440006', '950e8401-e29b-41d4-a716-446655440004', 'f50e8400-e29b-41d4-a716-446655440010', 3, 350000.00, 157500.00, 892500.00, '550e8400-e29b-41d4-a716-446655440004'),

-- Order 5 items (Cancelled order)
('a50e8401-e29b-41d4-a716-446655440007', '950e8401-e29b-41d4-a716-446655440005', 'f50e8400-e29b-41d4-a716-446655440013', 2, 356000.00, 142400.00, 569600.00, '550e8400-e29b-41d4-a716-446655440001'),

-- Order 6 items (Processing order)
('a50e8401-e29b-41d4-a716-446655440008', '950e8401-e29b-41d4-a716-446655440006', 'f50e8400-e29b-41d4-a716-446655440005', 1, 19800000.00, 1980000.00, 17820000.00, '550e8400-e29b-41d4-a716-446655440002'),

-- Order 7 items (Small confirmed order)
('a50e8401-e29b-41d4-a716-446655440009', '950e8401-e29b-41d4-a716-446655440007', 'f50e8400-e29b-41d4-a716-446655440009', 1, 350000.00, 52500.00, 297500.00, '550e8400-e29b-41d4-a716-446655440003');

-- Insert order fees
INSERT INTO order_fees (id, order_id, fee_type, fee_name, amount, created_by) VALUES
-- Order 1 fees
('b50e8401-e29b-41d4-a716-446655440001', '950e8401-e29b-41d4-a716-446655440001', 'shipping', 'Standard Shipping', 50000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440002', '950e8401-e29b-41d4-a716-446655440001', 'tax', 'VAT (10%)', 2137500.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440003', '950e8401-e29b-41d4-a716-446655440001', 'service', 'Insurance Fee', 25000.00, '550e8400-e29b-41d4-a716-446655440005'),

-- Order 2 fees
('b50e8401-e29b-41d4-a716-446655440004', '950e8401-e29b-41d4-a716-446655440002', 'shipping', 'Express Shipping', 30000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440005', '950e8401-e29b-41d4-a716-446655440002', 'tax', 'VAT (10%)', 100400.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440006', '950e8401-e29b-41d4-a716-446655440002', 'service', 'Gift Wrapping', 15000.00, '550e8400-e29b-41d4-a716-446655440005'),

-- Order 3 fees
('b50e8401-e29b-41d4-a716-446655440007', '950e8401-e29b-41d4-a716-446655440003', 'shipping', 'Free Shipping (Premium)', 0.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440008', '950e8401-e29b-41d4-a716-446655440003', 'tax', 'VAT (10%)', 6480000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440009', '950e8401-e29b-41d4-a716-446655440003', 'service', 'Priority Processing', 50000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440010', '950e8401-e29b-41d4-a716-446655440003', 'service', 'Extended Warranty', 200000.00, '550e8400-e29b-41d4-a716-446655440005'),

-- Order 4 fees
('b50e8401-e29b-41d4-a716-446655440011', '950e8401-e29b-41d4-a716-446655440004', 'shipping', 'Standard Shipping', 25000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440012', '950e8401-e29b-41d4-a716-446655440004', 'tax', 'VAT (10%)', 89250.00, '550e8400-e29b-41d4-a716-446655440005'),

-- Order 5 fees (cancelled)
('b50e8401-e29b-41d4-a716-446655440013', '950e8401-e29b-41d4-a716-446655440005', 'shipping', 'Express Shipping', 35000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440014', '950e8401-e29b-41d4-a716-446655440005', 'tax', 'VAT (10%)', 56980.00, '550e8400-e29b-41d4-a716-446655440005'),

-- Order 6 fees
('b50e8401-e29b-41d4-a716-446655440015', '950e8401-e29b-41d4-a716-446655440006', 'shipping', 'Premium Shipping', 40000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440016', '950e8401-e29b-41d4-a716-446655440006', 'shipping', 'Free Shipping Discount', 40000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440017', '950e8401-e29b-41d4-a716-446655440006', 'tax', 'VAT (10%)', 1782000.00, '550e8400-e29b-41d4-a716-446655440005'),

-- Order 7 fees
('b50e8401-e29b-41d4-a716-446655440018', '950e8401-e29b-41d4-a716-446655440007', 'shipping', 'Local Delivery', 20000.00, '550e8400-e29b-41d4-a716-446655440005'),
('b50e8401-e29b-41d4-a716-446655440019', '950e8401-e29b-41d4-a716-446655440007', 'tax', 'VAT (10%)', 29750.00, '550e8400-e29b-41d4-a716-446655440005');

-- Additional sample data for more realistic scenarios

-- Order 8: Large bulk order
INSERT INTO orders (id, order_number, user_id, shipping_address_id, subtotal, product_discount_amount, voucher_discount_amount, store_discount_amount, tax_amount, base_shipping_fee, shipping_discount_amount, total_amount, order_status_id, payment_method_id, voucher_id, notes, ordered_at, confirmed_at, shipped_at, delivered_at, created_by) VALUES
    ('950e8401-e29b-41d4-a716-446655440008', 'ORD-2024-000008', '550e8400-e29b-41d4-a716-446655440001', '650e8400-e29b-41d4-a716-446655440001', 5250000.00, 787500.00, 0.00, 262500.00, 420000.00, 80000.00, 0.00, 4700000.00, '750e8401-e29b-41d4-a716-446655440005', '850e8401-e29b-41d4-a716-446655440004', NULL, 'Bulk order for office', '2024-02-01 08:30:00', '2024-02-01 09:15:00', '2024-02-02 10:00:00', '2024-02-05 15:45:00', '550e8400-e29b-41d4-a716-446655440001');

-- Order 8 items (Bulk T-shirts)
INSERT INTO order_items (id, order_id, product_variant_id, quantity, unit_price, discount_amount, total_price, created_by) VALUES
                                                                                                                               ('a50e8401-e29b-41d4-a716-446655440010', '950e8401-e29b-41d4-a716-446655440008', 'f50e8400-e29b-41d4-a716-446655440009', 10, 350000.00, 525000.00, 2975000.00, '550e8400-e29b-41d4-a716-446655440001'),
                                                                                                                               ('a50e8401-e29b-41d4-a716-446655440011', '950e8401-e29b-41d4-a716-446655440008', 'f50e8400-e29b-41d4-a716-446655440010', 5, 350000.00, 262500.00, 1487500.00, '550e8400-e29b-41d4-a716-446655440001');

-- Order 8 fees
INSERT INTO order_fees (id, order_id, fee_type, fee_name, amount, created_by) VALUES
                                                                                  ('b50e8401-e29b-41d4-a716-446655440020', '950e8401-e29b-41d4-a716-446655440008', 'shipping', 'Bulk Shipping', 80000.00, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                  ('b50e8401-e29b-41d4-a716-446655440021', '950e8401-e29b-41d4-a716-446655440008', 'tax', 'VAT (10%)', 420000.00, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                  ('b50e8401-e29b-41d4-a716-446655440022', '950e8401-e29b-41d4-a716-446655440008', 'service', 'Bulk Discount Applied', 262500.00, '550e8400-e29b-41d4-a716-446655440005');

-- Order 9: International shipping
INSERT INTO orders (id, order_number, user_id, shipping_address_id, subtotal, product_discount_amount, voucher_discount_amount, store_discount_amount, tax_amount, base_shipping_fee, shipping_discount_amount, total_amount, order_status_id, payment_method_id, voucher_id, notes, ordered_at, confirmed_at, shipped_at, delivered_at, created_by) VALUES
    ('950e8401-e29b-41d4-a716-446655440009', 'ORD-2024-000009', '550e8400-e29b-41d4-a716-446655440004', '650e8400-e29b-41d4-a716-446655440004', 28000000.00, 2240000.00, 0.00, 0.00, 2576000.00, 500000.00, 0.00, 28836000.00, '750e8401-e29b-41d4-a716-446655440004', '850e8401-e29b-41d4-a716-446655440002', NULL, 'International shipping to Japan', '2024-02-05 14:20:00', '2024-02-05 15:30:00', '2024-02-06 11:00:00', NULL, '550e8400-e29b-41d4-a716-446655440004');

-- Order 9 items
INSERT INTO order_items (id, order_id, product_variant_id, quantity, unit_price, discount_amount, total_price, created_by) VALUES
    ('a50e8401-e29b-41d4-a716-446655440012', '950e8401-e29b-41d4-a716-446655440009', 'f50e8400-e29b-41d4-a716-446655440004', 1, 28000000.00, 2240000.00, 25760000.00, '550e8400-e29b-41d4-a716-446655440004');

-- Order 9 fees
INSERT INTO order_fees (id, order_id, fee_type, fee_name, amount, created_by) VALUES
                                                                                  ('b50e8401-e29b-41d4-a716-446655440023', '950e8401-e29b-41d4-a716-446655440009', 'shipping', 'International Express', 500000.00, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                  ('b50e8401-e29b-41d4-a716-446655440024', '950e8401-e29b-41d4-a716-446655440009', 'tax', 'VAT (10%)', 2576000.00, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                  ('b50e8401-e29b-41d4-a716-446655440025', '950e8401-e29b-41d4-a716-446655440009', 'service', 'Customs Handling', 100000.00, '550e8400-e29b-41d4-a716-446655440005'),
                                                                                  ('b50e8401-e29b-41d4-a716-446655440026', '950e8401-e29b-41d4-a716-446655440009', 'service', 'International Insurance', 75000.00, '550e8400-e29b-41d4-a716-446655440005');
