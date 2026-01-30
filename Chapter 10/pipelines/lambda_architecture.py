# Lambda Architecture Implementation for AI Pipelines
# Separates batch and streaming layers to balance resource use

# Batch layer - leverages Chapter 8's ETL optimization principles
batch_features = (spark.read.parquet("hdfs://acme/data/historical/")
                  .repartition("user_id")  # Optimize for parallel processing
                  .cache())  # Reduce repeated I/O as discussed in Ch 8

# Speed layer - using Spark Structured Streaming with HDFS as source
streaming_features = (spark.readStream.format("parquet")
                     .option("path", "hdfs://acme/data/streaming/")
                     .option("maxFilesPerTrigger", 10)
                     .load()
                     .writeStream.format("delta")
                     .option("path", "hdfs://acme/features/real_time/")
                     .trigger(processingTime="10 seconds")
                     .start())
