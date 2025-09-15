-- Week 1, Day 1: Enhanced Sample Data for Window Functions
-- สร้างข้อมูลเพิ่มเติมสำหรับ Window Functions practice

-- เพิ่มข้อมูล customers มากขึ้น
INSERT INTO customers (name, email, created_date) VALUES
('Alice Johnson', 'alice@example.com', '2025-01-15 10:30:00'),
('Charlie Brown', 'charlie@example.com', '2025-01-20 14:15:00'),
('Diana Prince', 'diana@example.com', '2025-02-01 09:45:00'),
('Eve Adams', 'eve@example.com', '2025-02-10 16:20:00'),
('Frank Miller', 'frank@example.com', '2025-02-15 11:30:00'),
('Grace Lee', 'grace@example.com', '2025-03-01 13:45:00'),
('Henry Ford', 'henry@example.com', '2025-03-10 08:30:00'),
('Ivy Chen', 'ivy@example.com', '2025-03-15 17:20:00'),
('Jack Ryan', 'jack@example.com', '2025-04-01 12:15:00'),
('Kate Wilson', 'kate@example.com', '2025-04-10 15:45:00'),
('Leo Martinez', 'leo@example.com', '2025-04-15 10:30:00'),
('Maya Patel', 'maya@example.com', '2025-05-01 14:20:00'),
('Noah Kim', 'noah@example.com', '2025-05-10 09:15:00'),
('Olivia Davis', 'olivia@example.com', '2025-05-15 16:45:00'),
('Paul Thompson', 'paul@example.com', '2025-06-01 11:30:00')
ON CONFLICT (email) DO NOTHING;

-- สร้าง orders เพิ่มเติมสำหรับ analytics (multiple orders per customer)
INSERT INTO orders (customer_id, total_amount, status, order_date) VALUES
-- January 2025
(1, 450.75, 'delivered', '2025-01-16 10:30:00'),
(2, 320.50, 'delivered', '2025-01-18 14:15:00'),
(5, 125.99, 'confirmed', '2025-01-22 09:45:00'),
(6, 275.30, 'delivered', '2025-01-25 16:20:00'),

-- February 2025
(3, 180.25, 'delivered', '2025-02-02 11:30:00'),
(7, 520.80, 'delivered', '2025-02-05 13:45:00'),
(8, 95.50, 'shipped', '2025-02-12 08:30:00'),
(9, 340.75, 'delivered', '2025-02-16 17:20:00'),
(1, 220.30, 'delivered', '2025-02-20 12:15:00'), -- John's 2nd order
(10, 410.60, 'confirmed', '2025-02-25 15:45:00'),

-- March 2025
(2, 155.45, 'delivered', '2025-03-02 10:30:00'), -- Jane's 2nd order
(11, 380.90, 'delivered', '2025-03-08 14:20:00'),
(12, 290.75, 'shipped', '2025-03-12 09:15:00'),
(5, 175.20, 'delivered', '2025-03-18 16:45:00'), -- Alice's 2nd order
(13, 465.85, 'delivered', '2025-03-22 11:30:00'),

-- April 2025
(6, 135.40, 'delivered', '2025-04-03 12:45:00'), -- Diana's 2nd order
(14, 325.60, 'delivered', '2025-04-08 08:30:00'),
(15, 245.90, 'shipped', '2025-04-15 17:20:00'),
(1, 190.85, 'delivered', '2025-04-18 12:15:00'), -- John's 3rd order
(16, 420.75, 'confirmed', '2025-04-25 15:45:00'),

-- May 2025
(3, 310.50, 'delivered', '2025-05-02 10:30:00'), -- Bob's 2nd order
(17, 185.30, 'delivered', '2025-05-08 14:20:00'),
(18, 475.60, 'shipped', '2025-05-12 09:15:00'),
(2, 265.40, 'delivered', '2025-05-18 16:45:00'), -- Jane's 3rd order
(19, 355.80, 'delivered', '2025-05-22 11:30:00'),

-- June 2025
(7, 225.90, 'delivered', '2025-06-02 12:45:00'), -- Charlie's 2nd order
(20, 395.75, 'confirmed', '2025-06-08 08:30:00'),
(5, 145.60, 'delivered', '2025-06-15 17:20:00'), -- Alice's 3rd order
(8, 280.45, 'shipped', '2025-06-18 12:15:00'), -- Diana's 3rd order
(1, 335.20, 'delivered', '2025-06-25 15:45:00'); -- John's 4th order

-- สร้างตาราง product_categories สำหรับ advanced joins ในวันต่อไป
CREATE TABLE IF NOT EXISTS product_categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- เพิ่มข้อมูล categories
INSERT INTO product_categories (category_name, description) VALUES
('Electronics', 'Electronic devices and gadgets'),
('Clothing', 'Fashion and apparel items'),
('Books', 'Physical and digital books'),
('Home & Garden', 'Home improvement and gardening supplies'),
('Sports', 'Sports equipment and accessories')
ON CONFLICT (category_name) DO NOTHING;

-- สร้างตาราง order_items สำหรับ detailed analytics
CREATE TABLE IF NOT EXISTS order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(order_id),
    product_name VARCHAR(100) NOT NULL,
    category_id INTEGER REFERENCES product_categories(category_id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price > 0),
    total_price DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- เพิ่ม sample order items
INSERT INTO order_items (order_id, product_name, category_id, quantity, unit_price) VALUES
-- Order 1 (John's first order)
(1, 'Wireless Headphones', 1, 1, 199.99),
(1, 'Phone Case', 1, 2, 50.00),

-- Order 2 (Jane's first order)  
(2, 'Summer Dress', 2, 1, 89.50),
(2, 'Sandals', 2, 1, 61.00),

-- Order 3 (Bob's first order)
(3, 'Programming Book', 3, 3, 25.08),

-- Additional items for new orders
(4, 'Laptop Stand', 1, 1, 125.75),
(4, 'Wireless Mouse', 1, 2, 162.50),
(5, 'Winter Jacket', 2, 1, 320.50),
(6, 'Garden Tools Set', 4, 1, 125.99),
(7, 'Tennis Racket', 5, 1, 275.30),
(8, 'Cooking Book', 3, 2, 90.25),
(9, 'Smart Watch', 1, 1, 520.80),
(10, 'Running Shoes', 5, 1, 95.50);

-- สร้าง view สำหรับ analytics
CREATE OR REPLACE VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.name,
    c.email,
    c.created_date as customer_since,
    COUNT(o.order_id) as total_orders,
    COALESCE(SUM(o.total_amount), 0) as total_spent,
    COALESCE(AVG(o.total_amount), 0) as avg_order_value,
    MAX(o.order_date) as last_order_date,
    MIN(o.order_date) as first_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.email, c.created_date
ORDER BY total_spent DESC;

-- แสดงสถิติข้อมูลใหม่
SELECT 'Data Summary:' as info;
SELECT 'Total Customers:' as metric, COUNT(*) as value FROM customers
UNION ALL
SELECT 'Total Orders:', COUNT(*) FROM orders  
UNION ALL
SELECT 'Total Order Items:', COUNT(*) FROM order_items
UNION ALL
SELECT 'Avg Orders per Customer:', ROUND(COUNT(*)::numeric / (SELECT COUNT(*) FROM customers), 2) FROM orders;

-- แสดง sample data สำหรับ verification
SELECT 'Sample Customer Order Summary:' as info;
SELECT * FROM customer_order_summary LIMIT 10;