# Adaptive Execution with ML Signals
# Combine runtime adaptivity with upstream ML signals

# Enable runtime adaptivity
spark.conf.set("spark.sql.adaptive.enabled", "true")
spark.conf.set("spark.sql.adaptive.skewJoin.enabled", "true")

# Simple policy: if drift_rate > threshold, go conservative
if drift_rate > 0.2:
    spark.conf.set("spark.sql.autoBroadcastJoinThreshold", "-1")  # curb broadcast
    spark.conf.set("spark.sql.shuffle.partitions", "200")          # avoid huge partitions
