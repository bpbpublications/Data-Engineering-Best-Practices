#!/bin/bash
# YARN Application-level QoS Configuration Examples

# Critical Production Job Submission
yarn jar production-etl.jar \
  --queue critical \
  --conf spark.sql.adaptive.enabled=true \
  --conf spark.executor.memory=8g \
  --conf spark.executor.cores=4 \
  --conf spark.dynamicAllocation.enabled=false \
  --conf spark.executor.instances=20

# Analytical Workload with Elastic Scaling
yarn jar analytics-job.jar \
  --queue analytical \
  --conf spark.dynamicAllocation.enabled=true \
  --conf spark.dynamicAllocation.minExecutors=5 \
  --conf spark.dynamicAllocation.maxExecutors=50 \
  --conf spark.executor.memory=6g

# Development/Ad-hoc Query
yarn jar development-query.jar \
  --queue adhoc \
  --conf spark.dynamicAllocation.enabled=true \
  --conf spark.dynamicAllocation.minExecutors=1 \
  --conf spark.dynamicAllocation.maxExecutors=10 \
  --conf spark.executor.memory=2g
