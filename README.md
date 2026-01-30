# Data Engineering Best Practices - Code Repository

Code repository containing examples and implementations from the Data book.

## Important Note

**Code Source:** All code examples are derived directly from the book chapters. Only chapters containing code snippets are included in this repository.

## Repository Structure

```
.
├── Chapter-04/          # Permission Management
│   ├── policies/        # Apache Ranger policies
│   └── README.md
├── Chapter-08/          # Infrastructure Operations
│   ├── database/        # SQL indexing and query optimization
│   ├── etl/             # Python ETL optimization
│   ├── maintenance/     # YARN, Hive, database maintenance
│   ├── monitoring/      # System health and queue debugging
│   └── README.md
├── Chapter-10/          # DataOps and AI
│   ├── pipelines/       # Lambda architecture, scaling, automation
│   ├── ml-techniques/   # Anomaly detection
│   └── README.md
└── README.md
```

## Chapters with Code

### Chapter 4: Permission Management

Implementation of permission management in data engineering ecosystems.

**Key Topics:**
- Authentication and authorization concepts
- RBAC and ABAC implementation
- Apache Ranger policies for Hadoop/Hive
- SSO with Okta and MFA with Google Authenticator

**Files (2):**
- `policies/ranger-policy.json` - Basic Apache Ranger access control policies with RBAC/ABAC
- `policies/acme-implementation.json` - Complete ACME implementation with all user groups

[View Chapter 4 →](./Chapter-04/)

---

### Chapter 8: Infrastructure Operations

Optimizing and maintaining reliable, scalable data infrastructure.

**Key Topics:**
- Database performance (indexing, query optimization)
- ETL performance (throughput, latency, resource efficiency)
- Preventive maintenance strategies
- System health monitoring
- Debugging job queues
- Managing long job queue situations

**Files (9):**

**Database:**
- `database/indexing.sql` - B-Tree, Hash, Partial, Covering indexes with monitoring
- `database/query_optimization.sql` - Join optimization, prepared statements, JIT compilation

**ETL:**
- `etl/throughput_optimization.py` - Parallel processing with ProcessPoolExecutor and asyncio

**Maintenance:**
- `maintenance/yarn-capacity-scheduler.xml` - YARN QoS configuration
- `maintenance/hive-optimization.sql` - Vectorization and cost-based optimization
- `maintenance/yarn-job-submission.sh` - Job submission examples for different workloads
- `maintenance/database_maintenance.sql` - Statistics updates, index maintenance, VACUUM

**Monitoring:**
- `monitoring/system_health_tracker.py` - Health monitoring with trend analysis
- `monitoring/queue_debugging.py` - Airflow queue assessment and priority management

[View Chapter 8 →](./Chapter-08/)

---

### Chapter 10: DataOps and AI

Integrating AI into data engineering workflows.

**Key Topics:**
- Role of data engineers in AI/ML projects
- Pipeline architectures (Lambda, Kappa, Medallion)
- ML techniques for data processing
- Optimization strategies
- Ethical governance

**Files (7):**

**Pipelines:**
- `pipelines/lambda_architecture.py` - Batch and streaming layers for AI workloads
- `pipelines/data_acquisition.py` - Unifying batch and streaming data sources
- `pipelines/acme_ai_etl_complete.py` - Four-phase ACME AI ETL (assess, transform, scale, monitor)
- `pipelines/policy_automation.py` - ML-driven policy automation
- `pipelines/acme_ai_scaling.py` - AI-driven resource management with YARN

**ML Techniques:**
- `ml-techniques/anomaly_detection.py` - Isolation Forest for anomaly detection

**Optimization:**
- `optimization/adaptive_execution.py` - Adaptive execution with ML signals

[View Chapter 10 →](./Chapter-10/)

---

## Statistics

- **Total Chapters Scanned**: 12
- **Chapters with Code**: 3 (Chapters 4, 8, 10)
- **Total Code Files**: 18
- **Languages**: Python, SQL, JSON, XML, Bash

## Use Case: ACME Auto Dealer

ACME Auto Dealer is a fictional company used as example in the book:
- 1,000 employees across 20 locations
- Hadoop-based analytics platform (Hive, Spark, YARN)
- Data sources: SAP, Salesforce CRM, in-house apps
- Big Data team: 5 Data Engineers, 12 Data Analysts, 3 Data Scientists

## Getting Started

Navigate to individual chapter directories for specific code examples and documentation.

```bash
cd Chapter-04  # Permission Management
cd Chapter-08  # Infrastructure Operations
cd Chapter-10  # DataOps and AI
```
