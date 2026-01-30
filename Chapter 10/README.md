# Chapter 10: DataOps and AI

Integrating AI into data engineering workflows.

## Key Topics

- Role of data engineers in AI/ML projects
- Pipeline architectures (Lambda, Kappa, Medallion)
- ML techniques for data processing
- Optimization strategies
- Ethical governance

## Files

### Pipelines
- **`pipelines/lambda_architecture.py`**: Lambda architecture implementation separating batch and streaming layers for AI workloads
- **`pipelines/data_acquisition.py`**: Data acquisition and integration unifying batch and streaming sources
- **`pipelines/acme_ai_etl_complete.py`**: Complete four-phase ACME AI-enhanced ETL system (assess, transform, scale, monitor)
- **`pipelines/policy_automation.py`**: ML-driven policy automation for resource fairness and stability
- **`pipelines/acme_ai_scaling.py`**: AI-driven resource management for ACME Auto Dealer using predictive scaling

### ML Techniques
- **`ml-techniques/anomaly_detection.py`**: Isolation Forest implementation for anomaly detection in data pipelines

### Optimization
- **`optimization/adaptive_execution.py`**: Adaptive execution with ML signals for runtime optimization

## Architecture Patterns

### Lambda Architecture
- **Batch Layer**: Processes historical data in large, scheduled runs
- **Speed Layer**: Handles incoming data with minimal delay for real-time updates
- **Unified View**: Combines batch and streaming results for comprehensive insights

### Kappa Architecture
- Treats all data as a stream over an immutable log
- Single streaming engine for both real-time and historical reprocessing
- Simplifies deployment and maintenance

### Medallion Architecture
- **Bronze Layer**: Raw append-only ingestion
- **Silver Layer**: Validated and conformed data
- **Gold Layer**: Curated, analytics-ready aggregates

## AI Techniques

- **Anomaly Detection**: Isolation Forest for identifying outliers
- **Predictive Scaling**: ML-based resource forecasting
- **Policy Automation**: Risk-based decision making
- **Adaptive Execution**: Runtime optimization with ML signals

## ACME Implementation

- AI-enhanced ETL for sales and customer data
- Predictive scaling for YARN containers and Airflow workers
- Continuous monitoring with automated alerts
- Integration with existing Hadoop infrastructure
