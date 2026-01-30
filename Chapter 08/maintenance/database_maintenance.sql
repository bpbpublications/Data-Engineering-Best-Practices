-- PostgreSQL Database Maintenance

-- Statistics Updates for Query Optimization
-- Check when statistics were last updated
SELECT schemaname, tablename, n_tup_ins, n_tup_upd, n_tup_del,
       last_analyze, last_autoanalyze
FROM pg_stat_user_tables 
WHERE n_tup_ins + n_tup_upd + n_tup_del > 1000
ORDER BY last_analyze ASC NULLS FIRST;

-- Update statistics for tables with significant changes
ANALYZE customer_transactions;
ANALYZE product_catalog;
ANALYZE user_sessions;

-- Index Maintenance and Optimization
-- Identify fragmented indexes requiring maintenance
SELECT schemaname, tablename, indexname,
        pg_size_pretty(pg_total_relation_size(indexrelid)) as index_size
FROM pg_stat_user_indexes 
WHERE idx_scan < 100  -- Infrequently used indexes
   OR pg_total_relation_size(indexrelid) > 100 * 1024 * 1024  -- Large indexes
ORDER BY pg_total_relation_size(indexrelid) DESC;

-- Rebuild indexes that would benefit from maintenance
REINDEX INDEX CONCURRENTLY idx_customer_transactions_date;
REINDEX INDEX CONCURRENTLY idx_product_catalog_category;

-- Storage Space Management
-- Reclaim unused storage space
VACUUM customer_transactions;

-- Update table storage parameters for better performance
ALTER TABLE customer_transactions SET (fillfactor = 80);

-- Clean up temporary objects and unused space
VACUUM ANALYZE;
