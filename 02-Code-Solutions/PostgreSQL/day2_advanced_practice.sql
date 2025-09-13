
  -- =============================================
  -- Part 1: Customer Analysis Dashboard
  -- =============================================

  WITH customer_summary AS (
      SELECT
          c.customer_id,
          c.name as customer_name,
          c.email,
          c.created_date,
          COUNT(o.order_id) as total_orders,
          COALESCE(SUM(o.total_amount), 0) as total_spent,
          COALESCE(AVG(o.total_amount), 0) as avg_order_value,
          MIN(o.order_date) as first_order_date,
          MAX(o.order_date) as last_order_date
      FROM customers c
      LEFT JOIN orders o ON c.customer_id = o.customer_id
      GROUP BY c.customer_id, c.name, c.email, c.created_date
  ),

  customer_rankings AS (
      SELECT
          *,
          RANK() OVER (ORDER BY total_spent DESC) as customer_rank,
          DENSE_RANK() OVER (ORDER BY total_spent DESC) as customer_dense_rank,
          (PERCENT_RANK() OVER (ORDER BY total_spent) * 100)::NUMERIC(5,1) as spending_percentile,

          CASE
              WHEN total_spent > 500 THEN 'Premium'
              WHEN total_spent BETWEEN 100 AND 500 THEN 'Standard'
              WHEN total_spent > 0 THEN 'Basic'
              ELSE 'No Purchase'
          END as customer_segment,

          CASE
              WHEN last_order_date >= CURRENT_DATE - INTERVAL '30 days' THEN 'Active'
              WHEN last_order_date >= CURRENT_DATE - INTERVAL '90 days' THEN 'At Risk'
              WHEN last_order_date IS NOT NULL THEN 'Churned'
              ELSE 'Never Purchased'
          END as customer_status
      FROM customer_summary
  )

  SELECT
      customer_rank,
      customer_name,
      email,
      total_orders,
      total_spent::NUMERIC(10,2) as total_spent,
      avg_order_value::NUMERIC(8,2) as avg_order_value,
      customer_segment,
      customer_status,
      spending_percentile,

      CASE
          WHEN first_order_date IS NOT NULL
          THEN EXTRACT(DAY FROM CURRENT_DATE - first_order_date)::INTEGER
          ELSE NULL
      END as days_since_first_order,

      CASE
          WHEN last_order_date IS NOT NULL
          THEN EXTRACT(DAY FROM CURRENT_DATE - last_order_date)::INTEGER
          ELSE NULL
      END as days_since_last_order,

      COUNT(*) OVER (PARTITION BY customer_segment) as segment_size,
      AVG(total_spent) OVER (PARTITION BY customer_segment)::NUMERIC(8,2) as segment_avg_spent

  FROM customer_rankings
  ORDER BY total_spent DESC;


  -- =============================================
  -- Part 2: Monthly Trends Analysis
  -- =============================================

  WITH monthly_trends AS (
      SELECT
          DATE_TRUNC('month', order_date) as month,
          COUNT(DISTINCT customer_id) as active_customers,
          COUNT(order_id) as total_orders,
          SUM(total_amount) as monthly_revenue,
          AVG(total_amount) as avg_order_value,
          LAG(SUM(total_amount)) OVER (ORDER BY DATE_TRUNC('month', order_date)) as prev_month_revenue,
          SUM(SUM(total_amount)) OVER (
              ORDER BY DATE_TRUNC('month', order_date)
              ROWS UNBOUNDED PRECEDING
          ) as cumulative_revenue
      FROM orders
      WHERE order_date IS NOT NULL
      GROUP BY DATE_TRUNC('month', order_date)
  )

  SELECT
      TO_CHAR(month, 'YYYY-MM') as month_year,
      active_customers,
      total_orders,
      monthly_revenue::NUMERIC(10,2),
      avg_order_value::NUMERIC(8,2),

      CASE
          WHEN prev_month_revenue IS NOT NULL AND prev_month_revenue > 0
          THEN ((monthly_revenue - prev_month_revenue) / prev_month_revenue * 100)::NUMERIC(5,2)
          ELSE NULL
      END as mom_growth_percent,

      cumulative_revenue::NUMERIC(12,2)

  FROM monthly_trends
  ORDER BY month;

  
  -- =============================================
  -- Part 3: Summary Statistics
  -- =============================================

  WITH customer_summary AS (
      SELECT
          c.customer_id,
          COALESCE(SUM(o.total_amount), 0) as total_spent,
          COUNT(o.order_id) as total_orders,
          CASE
              WHEN COALESCE(SUM(o.total_amount), 0) > 500 THEN 'Premium'
              WHEN COALESCE(SUM(o.total_amount), 0) BETWEEN 100 AND 500 THEN 'Standard'
              WHEN COALESCE(SUM(o.total_amount), 0) > 0 THEN 'Basic'
              ELSE 'No Purchase'
          END as customer_segment
      FROM customers c
      LEFT JOIN orders o ON c.customer_id = o.customer_id
      GROUP BY c.customer_id
  )

  SELECT
      'SUMMARY STATISTICS' as analysis_type,
      COUNT(*) as total_customers,
      SUM(CASE WHEN customer_segment = 'Premium' THEN 1 ELSE 0 END) as premium_customers,
      SUM(CASE WHEN customer_segment = 'Standard' THEN 1 ELSE 0 END) as standard_customers,
      SUM(CASE WHEN customer_segment = 'Basic' THEN 1 ELSE 0 END) as basic_customers,
      SUM(CASE WHEN customer_segment = 'No Purchase' THEN 1 ELSE 0 END) as no_purchase_customers,

      AVG(total_spent)::NUMERIC(8,2) as avg_customer_value,
      SUM(total_spent)::NUMERIC(10,2) as total_revenue,
      SUM(total_orders) as total_orders_count

  FROM customer_summary;
