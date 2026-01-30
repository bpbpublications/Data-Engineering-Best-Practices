# Chapter 4: Permission Management

Implementation of permission management in data engineering ecosystems.

## Key Topics

- Authentication and authorization concepts
- RBAC (Role-Based Access Control) and ABAC (Attribute-Based Access Control)
- Apache Ranger policies for Hadoop/Hive
- SSO with Okta and MFA with Google Authenticator
- Integration with data engineering architecture

## Files

### Policies
- **`policies/ranger-policy.json`**: Basic Apache Ranger access control policies demonstrating RBAC and ABAC for HDFS and Hive
- **`policies/acme-implementation.json`**: Complete ACME Auto Dealer implementation with all user groups (Users, DataAnalysts, DataEngineers, DataScientists, Admins) and comprehensive HDFS/Hive policies

## ACME Auto Dealer Use Case

- **Company**: Medium-sized firm with 1,000 employees across 20 locations
- **Platform**: Centralized Hadoop cluster with Hive, Spark, and YARN
- **Data Sources**: SAP (orders, stock, procurement), Salesforce CRM, in-house service apps
- **Team**: 5 Data Engineers, 12 Data Analysts, 3 Data Scientists
- **Use Cases**: Reporting, forecasting, integration

## Implementation Highlights

- SSO with Okta for centralized authentication
- MFA with Google Authenticator for enhanced security
- Hybrid RBAC/ABAC model via Apache Ranger
- Tag-based access control (Department, Team, Sensitivity, Environment, Project)

## Policy Structure

### User Groups
- **Users**: Sales managers with read-only access to public reports
- **DataAnalysts**: Read access to analytics data with team-based restrictions
- **DataEngineers**: Read/write access to processing directories in dev environment
- **DataScientists**: Read access to research data for specific projects
- **Admins**: Full control with audit-only restrictions

### Access Control Tags
- Department (Sales, Finance, Marketing)
- Team (Sales, Finance, Engineering)
- Sensitivity (Low, Medium, High)
- Environment (Dev, Staging, Prod)
- Project (StockPredictor)
- Data_Classification (Public, Low)
- Action (Audit)
