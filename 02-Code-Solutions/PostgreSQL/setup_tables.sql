
  -- =============================================
  -- Setup Tables for SQL Training
  -- Database: training
  -- =============================================

  -- สร้าง customers table
  CREATE TABLE customers (
      customer_id SERIAL PRIMARY KEY,
      name VARCHAR(100) NOT NULL,
      email VARCHAR(255) UNIQUE NOT NULL,
      created_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
  );

  -- สร้าง orders table
  CREATE TABLE orders (
      order_id SERIAL PRIMARY KEY,
      customer_id INTEGER NOT NULL,
      total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount > 0),
      status VARCHAR(20) NOT NULL DEFAULT 'pending',
      order_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

      -- Foreign Key Constraint
      CONSTRAINT fk_orders_customer
          FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
          ON DELETE RESTRICT ON UPDATE CASCADE
  );

  -- Performance Indexes
  CREATE INDEX idx_orders_customer_id ON orders(customer_id);
  CREATE INDEX idx_orders_status ON orders(status);
  CREATE INDEX idx_orders_order_date ON orders(order_date);
  CREATE INDEX idx_orders_customer_status ON orders(customer_id, status);

  -- Add constraint for valid status values
  ALTER TABLE orders ADD CONSTRAINT chk_orders_status
      CHECK (status IN ('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled'));

  -- Insert sample customers
  INSERT INTO customers (name, email) VALUES
  ('John Doe', 'john@example.com'),
  ('Jane Smith', 'jane@example.com'),
  ('Bob Wilson', 'bob@example.com'),
  ('Alice Johnson', 'alice@example.com'),
  ('Charlie Brown', 'charlie@example.com');

  -- Insert sample orders
  INSERT INTO orders (customer_id, total_amount, status) VALUES
  (1, 299.99, 'confirmed'),
  (1, 150.50, 'delivered'),
  (2, 75.25, 'shipped'),
  (2, 320.00, 'confirmed'),
  (2, 45.99, 'delivered'),
  (3, 199.99, 'processing'),
  (4, 89.50, 'delivered'),
  (4, 156.75, 'confirmed'),
  (4, 220.00, 'shipped'),
  (5, 95.25, 'cancelled');

  -- Verification
  SELECT 'Tables created successfully!' as status;
