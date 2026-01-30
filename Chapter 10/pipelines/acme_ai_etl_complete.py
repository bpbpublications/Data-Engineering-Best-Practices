from pyspark.sql import SparkSession
from airflow.models import DagRun
import pandas as pd
from sklearn.ensemble import IsolationForest
from datetime import datetime, timedelta
import subprocess

# ACME AI-Enhanced ETL System - Four-Phase Implementation

# Phase 1: Assess Data and AI Readiness
# Initialize Spark session
spark = SparkSession.builder.appName("ai_etl_assessment").getOrCreate()

# Assess data quality in Hive table
data = spark.read.table("raw_unified_data")
null_count = data.filter(data.speed.isNull()).count()
print(f"ACME: Null values in speed: {null_count}")

# Review recent ETL runs in Airflow
etl_runs = DagRun.find(dag_id="etl_pipeline", execution_date_range=["2025-12-01", "2025-12-07"])
print(f"ACME: ETL runs in last week: {len(etl_runs)}")

# Phase 2: Integrate AI for Transformation
# Load and transform ACME's data
acme_data = pd.read_parquet("raw_unified_data.parquet")  
model = IsolationForest(contamination=0.1)
acme_data['anomaly'] = model.fit_predict(acme_data[['quantity']])

# Save cleaned data for ACME's AI models
clean_data = acme_data[acme_data['anomaly'] != -1]
clean_data.to_parquet("acme_ai_transformed_data.parquet")
print(f"ACME: Removed {len(acme_data) - len(clean_data)} anomalies")

# Phase 3: Scale with AI-Driven Resource Management
# Initialize Spark session for scaling
spark = SparkSession.builder.appName("acme_ai_scaling").getOrCreate()

# Load usage data
usage_data = spark.read.parquet("acme_usage_data.parquet")

# Aggregate maximum CPU usage per hour
max_cpu_usage_per_hour = usage_data.groupBy("hour").max("cpu_usage").collect()

# Determine the peak CPU usage
peak_cpu_usage = max(row["max(cpu_usage)"] for row in max_cpu_usage_per_hour)

# Scale YARN containers if CPU usage exceeds threshold
if peak_cpu_usage > 80:
    subprocess.run(["yarn", "rmadmin", "-updateNodeResource", "acme-node-01", "4096", "4"])

# Launch Airflow worker with defined concurrency
subprocess.run(["airflow", "celery", "worker", "--concurrency", "12"])

# Phase 4: Monitor and Continuous Improvement
# Monitor ACME's ETL health by checking runs in the last 24 hours
acme_runs = [run for run in DagRun.find(dag_id="acme_ai_etl_pipeline")
             if run.execution_date > datetime.now() - timedelta(hours=24)]

# Calculate average duration
if acme_runs:
    avg_duration = sum(run.duration for run in acme_runs) / len(acme_runs)
else:
    avg_duration = 0

# Log average duration and alert if threshold exceeded
print(f"ACME: Average ETL duration: {avg_duration} minutes")
if avg_duration > 60:
    print("ACME: Alert: ETL delay detected")
