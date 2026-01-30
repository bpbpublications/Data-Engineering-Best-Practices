-- Hive Query Optimization Configuration

-- Enable vectorization for improved batch processing performance
SET hive.vectorized.execution.enabled = true;
SET hive.vectorized.execution.reduce.enabled = true;

-- Enable cost-based optimization
SET hive.cbo.enable = true;
SET hive.compute.query.using.stats = true;
SET hive.stats.fetch.column.stats = true;

-- Optimized aggregation with partition pruning
SELECT 
    region,
    product_category,
    SUM(sales_amount) as total_sales,
    COUNT(DISTINCT customer_id) as unique_customers
FROM sales_fact 
WHERE year = 2025 AND month >= 8  -- Leverages partitioning
GROUP BY region, product_category;

-- Create partitioned table for efficient data access
CREATE TABLE sales_data (
    transaction_id STRING,
    customer_id INT,
    product_category STRING,
    sale_amount DECIMAL(10,2)
)
PARTITIONED BY (sale_date DATE, region STRING);

-- Efficient query leveraging partition pruning
SELECT SUM(sale_amount) 
FROM sales_data 
WHERE sale_date = '2025-08-04'   
  AND region = 'NORTH_AMERICA';

-- Table creation with ORC optimization
CREATE TABLE inventory_data (
    item_id STRING,
    category STRING,
    stock_level INT,
    last_updated TIMESTAMP
)
STORED AS ORC
TBLPROPERTIES (
    "orc.compress"="ZLIB",
    "orc.bloom.filter.columns"="item_id,category"
);
