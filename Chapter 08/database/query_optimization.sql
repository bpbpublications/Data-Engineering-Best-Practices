-- PostgreSQL Query Optimization Examples

-- Selective Column Retrieval
-- Inefficient: Retrieves unnecessary data and prevents index covering
SELECT * 
FROM customer_orders 
WHERE order_date >= '2025-08-01'   
  AND order_status = 'PENDING';

-- Optimized: Retrieves only required columns
SELECT order_id, customer_id, order_total, estimated_delivery
FROM customer_orders 
WHERE order_date >= '2025-08-01'   
  AND order_status = 'PENDING';

-- Join Optimization
-- Suboptimal: Filter applied after expensive join
SELECT c.customer_name, o.order_total
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= '2025-08-01'  
  AND c.customer_status = 'PREMIUM';

-- Optimized: Filters applied before join
SELECT c.customer_name, o.order_total
FROM customers c
JOIN (
    SELECT customer_id, order_total 
    FROM orders 
    WHERE order_date >= '2025-08-01'
) o ON c.customer_id = o.customer_id
WHERE c.customer_status = 'PREMIUM';

-- Hash Join Example
-- Large orders table with smaller customers table
SELECT 
    c.customer_name,
    c.customer_segment,
    COUNT(*) as order_count,
    SUM(o.order_total) as total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '2025-01-01' AND '2025-12-31'  
  AND c.customer_segment = 'ENTERPRISE'
GROUP BY c.customer_name, c.customer_segment;

-- Force hash join for demonstration (normally let optimizer decide)
SET enable_nestloop = off;
SET enable_mergejoin = off;

-- Nested Loop Join Example
-- Finding specific customer's recent orders
EXPLAIN (ANALYZE, BUFFERS)
SELECT 
    c.customer_name,
    c.email_address,
    o.order_date,
    o.order_total,
    p.product_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id  
JOIN products p ON oi.product_id = p.product_id
WHERE c.customer_id = 12345  -- Highly selective condition
  AND o.order_date >= '2025-08-01'
ORDER BY o.order_date DESC;

-- PostgreSQL Performance Tuning
-- Enable JIT compilation for complex queries
SET jit = on;

-- Use prepared statements for frequently executed queries
PREPARE customer_lookup (integer) AS 
SELECT customer_name, email_address 
FROM customers 
WHERE customer_id = $1;

EXECUTE customer_lookup(12345);
