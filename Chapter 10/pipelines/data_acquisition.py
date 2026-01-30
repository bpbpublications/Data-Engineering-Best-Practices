from pyspark.sql import SparkSession

# Data Acquisition and Integration
# Unifying batch and streaming data sources

# Initialize Spark session
spark = SparkSession.builder.appName("unify").getOrCreate()

# Load batch and streaming sources 
sales_logs = spark.read.csv("/warehouse/sales_logs.csv", header=True, inferSchema=True)  # relational sales data
customer_reviews = spark.read.text("/raw/customer_reviews.txt").withColumnRenamed("value", "review_text")  # free-form feedback

# Unify data with flexible column handling
unified = sales_logs.unionByName(customer_reviews, allowMissingColumns=True)
unified.write.format("hive").mode("append").saveAsTable("raw_unified_data")
