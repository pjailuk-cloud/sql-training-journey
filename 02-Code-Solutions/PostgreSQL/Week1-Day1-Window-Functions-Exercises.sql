-- Week 1, Day 1: Window Functions Practice Exercises
-- ระดับความยาก: Basic → Intermediate → Advanced → Expert

-- =============================================================================
-- BASIC LEVEL (เริ่มต้น)
-- =============================================================================

-- Exercise 1: Basic Rankings
-- จงเขียน query หา ranking ของ orders ตามยอดเงิน
-- Expected output: order_id, customer_id, total_amount, rank

-- Your Solution:
-- SELECT ...
SELECT
    order_id,
    customer_id,
    total_amount,
    RANK() OVER (ORDER BY total_amount DESC) AS Rank
FROM
    orders
;

-- Exercise 2: Row Numbers
-- จงเขียน query ให้ลำดับเลขแถวสำหรับ orders แต่ละ customer
-- เรียงตามวันที่สั่งซื้อ
-- Expected output: customer_id, order_date, total_amount, row_number

-- Your Solution:
-- SELECT ...
SELECT
    customer_id,
    order_date,
    total_amount,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS row_number
FROM
    orders
;

-- Exercise 3: Simple Aggregation
-- จงหาจำนวน orders ทั้งหมดและยอดรวมทั้งหมด ในแต่ละแถวโดยไม่ใช้ GROUP BY
-- Expected output: order_id, total_amount, total_orders, grand_total

-- Your Solution:
-- SELECT ...
SELECT
    order_id,
    total_amount,
    COUNT(total_amount) OVER () AS total_orders,
    SUM(total_amount) OVER () AS grand_total
FROM
    orders
;

-- =============================================================================
-- INTERMEDIATE LEVEL (ระดับกลาง)
-- =============================================================================

-- Exercise 4: Customer Rankings
-- จงสร้าง query ที่แสดง:
-- - ลูกค้าแต่ละคนกับยอดใช้จ่ายรวม
-- - Rank ตามยอดใช้จ่าย
-- - Dense rank ตามจำนวนครั้งที่สั่งซื้อ
-- Expected: customer_name, total_spent, order_count, spending_rank, frequency_dense_rank

-- Your Solution:
-- SELECT ...
WITH customer_spending AS (
    SELECT
        c.name AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent,
        COUNT(o.order_id) AS order_count
    FROM
        customers c
        LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY
        c.name
)
SELECT
    customer_name,
    total_spent,
    order_count,
    RANK() OVER (ORDER BY total_spent DESC) AS spending_rank,
    DENSE_RANK() OVER (ORDER BY order_count DESC) AS frequency_dense_rank
FROM
    customer_spending
;

-- Exercise 5: Running Totals
-- จงสร้าง running total ของยอดขายเรียงตามวันที่
-- Expected: order_date, total_amount, running_total
-- Hint: ใช้ SUM() OVER()

-- Your Solution:
-- SELECT ...
SELECT
    order_date,
    total_amount,
    SUM(total_amount) OVER (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM
    orders
;

-- Exercise 6: LAG/LEAD Analysis
-- จงหาการเปลี่ยนแปลงของยอดขายระหว่าง orders ที่ติดกัน
-- Expected: order_date, total_amount, previous_amount, next_amount, change_from_previous
-- Hint: ใช้ LAG() และ LEAD()

-- Your Solution:
-- SELECT ...
SELECT
    order_date,
    total_amount,
    COALESCE(LAG(total_amount) OVER (ORDER BY order_date), 0) AS previous_amount,
    COALESCE(LEAD(total_amount) OVER (ORDER BY order_date), 0) AS next_amount,
    COALESCE(total_amount - LAG(total_amount) OVER (ORDER BY order_date), 0) AS change_from_previous
FROM
    orders
;

-- =============================================================================
-- ADVANCED LEVEL (ระดับสูง)
-- =============================================================================

-- Exercise 7: Customer Journey Analysis
-- สำหรับลูกค้าที่มี orders มากกว่า 1 ครั้ง จงวิเคราะห์:
-- - Order แรกและสุดท้ายของแต่ละคน
-- - จำนวนวันระหว่าง orders
-- - Running average ของยอดซื้อแต่ละคน
-- Expected: customer_name, order_sequence, total_amount, first_order, last_order, 
--           days_since_previous, customer_running_avg

-- Your Solution:
-- SELECT ...
WITH customer_orders AS (
    SELECT
        c.name AS customer_name,
        o.order_date,
        o.total_amount,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS order_sequence,
        FIRST_VALUE(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS first_order,
        LAST_VALUE(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_order,
        LAG(o.order_date) OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS previous_order_date,
        AVG(o.total_amount) OVER (PARTITION BY c.customer_id ORDER BY o.order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS customer_running_avg
    FROM
        customers c
        JOIN orders o ON c.customer_id = o.customer_id
)
SELECT
    customer_name,
    order_sequence,
    total_amount,
    first_order,
    last_order,
    CASE 
        WHEN previous_order_date IS NULL THEN NULL
        ELSE EXTRACT(DAY FROM (order_date - previous_order_date))
    END AS days_since_previous,
    customer_running_avg
FROM
    customer_orders
WHERE
    order_sequence > 1
;
-- Exercise 8: NTILE Segmentation  
-- จงแบ่งลูกค้าเป็น 3 กลุ่มตามยอดใช้จ่าย และ 4 กลุ่มตามความถี่การซื้อ
-- Expected: customer_name, total_spent, order_count, spending_tier, frequency_quartile
-- Hint: ใช้ NTILE()

-- Your Solution:
-- SELECT ...
WITH customer_summary AS (
    SELECT
        c.name AS customer_name,
        COALESCE(SUM(o.total_amount), 0) AS total_spent,
        COUNT(o.order_id) AS order_count
    FROM
        customers c
        LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY
        c.name
)
SELECT
    customer_name,
    total_spent,
    order_count,
    NTILE(3) OVER (ORDER BY total_spent DESC) AS spending_tier,
    NTILE(4) OVER (ORDER BY order_count DESC) AS frequency_quartile
FROM
    customer_summary
;


-- Exercise 9: Moving Averages
-- จงสร้าง 3-period moving average ของยอดขาย คือ ค่าเฉลี่ยของยอดขาย 3 รายการล่าสุด
-- Expected: order_date, total_amount, moving_avg_3
-- Hint: ใช้ ROWS BETWEEN

-- Your Solution:
-- SELECT ...
SELECT
    order_date,
    total_amount,
    AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3
FROM
    orders
;

-- =============================================================================
-- EXPERT LEVEL (ระดับเชี่ยวชาญ)
-- =============================================================================

-- Exercise 10: Complex Customer Segmentation
-- จงสร้างระบบ RFM (Recency, Frequency, Monetary) analysis:
-- - Recency: วันที่สั่งซื้อล่าสุด (คำนวณจาก CURRENT_DATE)
-- - Frequency: จำนวนครั้งที่สั่งซื้อ  
-- - Monetary: ยอดใช้จ่ายรวม
-- แต่ละมิติให้แบ่งเป็น 5 กลุ่ม (quintiles)
-- Expected: customer_name, recency_days, frequency, monetary, r_score, f_score, m_score, rfm_segment

-- Your Solution:
-- SELECT ...
WITH customer_rfm AS (
    SELECT
        c.name AS customer_name,
        COALESCE(MAX(o.order_date), '1900-01-01') AS last_order_date,
        COUNT(o.order_id) AS frequency,
        COALESCE(SUM(o.total_amount), 0) AS monetary
    FROM
        customers c
        LEFT JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY
        c.name
)
SELECT
    customer_name,
    EXTRACT(DAY FROM (CURRENT_DATE - last_order_date)) AS recency_days,
    frequency,
    monetary,
    NTILE(5) OVER (ORDER BY EXTRACT(DAY FROM (CURRENT_DATE - last_order_date))) AS r_score,
    NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary DESC) AS m_score,
    CONCAT(
        NTILE(5) OVER (ORDER BY EXTRACT(DAY FROM (CURRENT_DATE - last_order_date))),
        NTILE(5) OVER (ORDER BY frequency DESC),
        NTILE(5) OVER (ORDER BY monetary DESC)
    ) AS rfm_segment
FROM
    customer_rfm
;

-- Exercise 11: Advanced Frame Specification
-- จงสร้าง query ที่แสดงสำหรับแต่ละ order:
-- - ยอดขายเฉลี่ยของ 2 orders ก่อนหน้า + order ปัจจุบัน
-- - ยอดขายเฉลี่ยของ order ปัจจุบัน + 2 orders ถัดไป
-- - ผลรวมของทั้งช่วง (2 ก่อน + ปัจจุบัน + 2 หลัง)
-- Expected: order_date, total_amount, backward_avg, forward_avg, total_5_period

-- Your Solution:
-- SELECT ...
SELECT
    order_date,
    total_amount,
    AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS backward_avg,
    AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS forward_avg,
    SUM(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS total_5_period
FROM
    orders
;

-- Exercise 12: Performance Challenge
-- จงเขียน query ที่มีประสิทธิภาพสูงสุดเพื่อหา:
-- - Top 3 orders ที่มียอดสูงสุดในแต่ละเดือน
-- - พร้อมแสดง rank และ percentage ของยอดนั้นเทียบกับยอดรวมของเดือน
-- Expected: month, order_id, total_amount, monthly_rank, pct_of_monthly_total
-- Hint: ใช้ EXTRACT(), RANK(), และ SUM() ร่วมกัน

-- Your Solution:
-- SELECT ...
SELECT
    month,
    order_id,
    total_amount,
    monthly_rank,
    pct_of_monthly_total
FROM (
    SELECT
        EXTRACT(MONTH FROM order_date) AS month,
        order_id,
        total_amount,
        RANK() OVER (PARTITION BY EXTRACT(MONTH FROM order_date) ORDER BY total_amount DESC) AS monthly_rank,
        ROUND((total_amount / SUM(total_amount) OVER (PARTITION BY EXTRACT(MONTH FROM order_date)) * 100), 2) AS pct_of_monthly_total
    FROM
        orders
) ranked_orders
WHERE
    monthly_rank <= 3
;
-- =============================================================================
-- BONUS CHALLENGES (โจทย์พิเศษ)
-- =============================================================================

-- Bonus 1: Cohort Analysis
-- จงสร้าง cohort analysis แสดงลูกค้าที่เริ่มซื้อในแต่ละเดือน
-- และติดตามว่าพวกเขายังซื้อต่อในเดือนถัดๆ ไปหรือไม่
-- (Advanced topic - ยาก!)
WITH first_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date
    FROM
        orders
    GROUP BY
        customer_id
),
customer_cohorts AS (
    SELECT
        o.customer_id,
        EXTRACT(YEAR FROM fo.first_order_date) AS cohort_year,
        EXTRACT(MONTH FROM fo.first_order_date) AS cohort_month,
        EXTRACT(YEAR FROM o.order_date) AS order_year,
        EXTRACT(MONTH FROM o.order_date) AS order_month
    FROM
        orders o
        JOIN first_orders fo ON o.customer_id = fo.customer_id
),
cohort_analysis AS (
    SELECT
        cohort_year,
        cohort_month,
        order_year,
        order_month,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM
        customer_cohorts
    GROUP BY
        cohort_year, cohort_month, order_year, order_month
    ORDER BY
        cohort_year, cohort_month, order_year, order_month
)
SELECT
    cohort_year,
    cohort_month,
    order_year,
    order_month,
    active_customers
FROM
    cohort_analysis
;

  -- เพิ่ม Period Number และ Retention Rate
  WITH first_orders AS (
      SELECT
          customer_id,
          MIN(order_date) AS first_order_date,
          DATE_TRUNC('month', MIN(order_date)) AS cohort_month
      FROM orders
      GROUP BY customer_id
  ),
  cohort_data AS (
      SELECT
          fo.cohort_month,
          o.customer_id,
          DATE_TRUNC('month', o.order_date) AS order_month,
          EXTRACT(EPOCH FROM (DATE_TRUNC('month', o.order_date) - fo.cohort_month)) / (30.44 * 24 * 60 * 60) AS period_number
      FROM orders o
      JOIN first_orders fo ON o.customer_id = fo.customer_id
  )
  SELECT
      cohort_month,
      period_number,
      COUNT(DISTINCT customer_id) AS customers,
      ROUND(COUNT(DISTINCT customer_id) * 100.0 /
            FIRST_VALUE(COUNT(DISTINCT customer_id)) OVER (
                PARTITION BY cohort_month ORDER BY period_number
            ), 2) AS retention_rate
  FROM cohort_data
  GROUP BY cohort_month, period_number
  ORDER BY cohort_month, period_number;

-- Bonus 2: Customer Lifetime Value Prediction
-- จงใช้ Window Functions สร้างโมเดลพยากรณ์ง่ายๆ 
-- สำหรับ CLV โดยดูจาก pattern การซื้อของลูกค้าแต่ละคน
-- (Expert level - ยากมาก!)
WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.name AS customer_name,
        o.order_date,
        o.total_amount,
        ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date) AS order_sequence,
        COUNT(o.order_id) OVER (PARTITION BY c.customer_id) AS total_orders,
        SUM(o.total_amount) OVER (PARTITION BY c.customer_id) AS total_spent
    FROM
        customers c
        JOIN orders o ON c.customer_id = o.customer_id
), customer_lifetime AS (
    SELECT
        customer_id,
        customer_name,
        total_orders,
        total_spent,
        AVG(total_amount) AS avg_order_value,
        (total_spent / NULLIF(total_orders, 0)) AS clv_estimate
    FROM
        customer_orders
    GROUP BY
        customer_id, customer_name, total_orders, total_spent
)
SELECT
    customer_id,
    customer_name,
    total_orders,
    total_spent,
    avg_order_value,
    clv_estimate
FROM
    customer_lifetime
ORDER BY
    clv_estimate DESC
LIMIT 10
;
-- =============================================================================
-- HINTS & TIPS
-- =============================================================================

-- 1. Basic Functions: ROW_NUMBER(), RANK(), DENSE_RANK()
-- 2. Aggregate: SUM(), AVG(), COUNT(), MIN(), MAX()
-- 3. Navigation: LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE()
-- 4. Distribution: NTILE(), PERCENT_RANK(), CUME_DIST()
-- 5. Frame: ROWS BETWEEN ... AND ..., RANGE BETWEEN ... AND ...

-- Common OVER() clauses:
-- OVER () - ทั้งหมด
-- OVER (ORDER BY ...) - เรียงลำดับ
-- OVER (PARTITION BY ...) - แบ่งกลุ่ม
-- OVER (PARTITION BY ... ORDER BY ...) - แบ่งกลุ่ม + เรียงลำดับ

-- Frame specifications:
-- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
-- ROWS BETWEEN 2 PRECEDING AND CURRENT ROW  
-- ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
-- ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING