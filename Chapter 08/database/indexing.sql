-- PostgreSQL Indexing Examples for Data Engineering

-- B-Tree Index: Composite index for inventory analysis
-- Without index: Full table scan across millions of records
SELECT location_id, SUM(stock_quantity) 
FROM inventory_fact 
WHERE inventory_date BETWEEN '2025-08-01' AND '2025-08-31'  
  AND product_category = 'automotive_parts';

-- With proper composite index
CREATE INDEX idx_inventory_date_category 
ON inventory_fact (inventory_date, product_category);

-- Hash Index: Optimized for exact match queries
CREATE INDEX idx_customer_email_hash 
ON customers USING hash(email_address);

-- Efficient for exact match queries
SELECT customer_id, customer_name 
FROM customers 
WHERE email_address = 'john.smith@example.com';

-- Partial Index: Index only active records
CREATE INDEX idx_active_customers 
ON customers (customer_id, registration_date) 
WHERE status = 'ACTIVE';

-- Functional Index: Case-insensitive searches
CREATE INDEX idx_customer_email_lower 
ON customers (LOWER(email_address));

-- Composite Index: Optimized column ordering
CREATE INDEX idx_sales_analysis 
ON sales_transactions (
    region_id,        -- High selectivity (few regions)
    sale_date,        -- Range queries common
    product_category, -- Group by operations
    customer_id       -- Covering column for joins
);

-- Covering Index: Includes all query columns
CREATE INDEX idx_customer_service_covering 
ON customer_interactions (customer_id, interaction_date) 
INCLUDE (service_type, resolution_status, satisfaction_score);

-- Query served entirely from index
SELECT customer_id, service_type, satisfaction_score
FROM customer_interactions 
WHERE customer_id = 12345  
  AND interaction_date >= '2025-08-01';

-- Monitor index usage in PostgreSQL
SELECT 
    schemaname,
    tablename,
    indexname,
    idx_scan as index_scans,
    idx_tup_read as tuples_read,
    idx_tup_fetch as tuples_fetched
FROM pg_stat_user_indexes 
WHERE idx_scan = 0  -- Identify unused indexes
ORDER BY schemaname, tablename;

-- Index Maintenance: Rebuild fragmented indexes
REINDEX INDEX idx_sales_transactions;

-- Update statistics for cost-based optimization
ANALYZE sales_transactions;

-- Index Maintenance: Disable during bulk load
ALTER TABLE sales_summary SET UNLOGGED;
DROP INDEX idx_sales_date;

-- Re-enable after load
CREATE INDEX idx_sales_date ON sales_summary (sale_date);
ALTER TABLE sales_summary SET LOGGED;
