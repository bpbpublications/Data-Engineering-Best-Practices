# Policy Documentation

## Overview

This document explains the access control policies implemented for ACME Auto Dealer's Hadoop-based analytics platform.

## User Roles

### 1. Users (General Employees)
- **Role**: Basic access for sales managers and general staff
- **Access Level**: Read-only
- **Resources**: `/public/reports`
- **Attributes**: 
  - Department=Sales
  - Data_Classification=Public
- **Use Case**: View public sales reports and dashboards

### 2. Data Analysts (DAs)
- **Role**: Analyze data for business insights
- **Access Level**: Read-only
- **Resources**: 
  - HDFS: `/data/analytics`
  - Hive: `analytics_db.finance_*`
- **Attributes**:
  - Team=Finance
  - Sensitivity=Low
- **Use Case**: Query sales, inventory, and financial data via DataGrip

### 3. Data Engineers (DEs)
- **Role**: Build and maintain data pipelines
- **Access Level**: Read and Write
- **Resources**: 
  - HDFS: `/data/processing`
  - Hive: `core_processing_db`
- **Attributes**:
  - Environment=Dev
  - Experience>2years (for production)
- **Use Case**: Submit Spark jobs, manage schemas, process SAP/Salesforce data

### 4. Data Scientists (DSs)
- **Role**: Develop predictive models
- **Access Level**: Read and Update
- **Resources**:
  - HDFS: `/data/research`
  - Hive: `research_db.predict_*`
- **Attributes**:
  - Project=StockPredictor
- **Use Case**: Build stock prediction models, update research tables

### 5. Admins
- **Role**: System administration and auditing
- **Access Level**: Full control
- **Resources**: All (`/*`)
- **Attributes**:
  - Action=Audit
- **Use Case**: Cluster management, compliance audits, emergency access

## Authentication Flow

1. **SSO with Okta**
   - User logs in with corporate credentials (email/password)
   - Okta authenticates against LDAP directory
   - SAML assertion issued to Hadoop cluster

2. **MFA with Google Authenticator**
   - After password entry, user provides 6-digit TOTP
   - Token refreshes every 30 seconds
   - Backup codes stored in HashiCorp Vault

3. **Token Propagation**
   - Single authentication grants access across tools
   - DataGrip, Spark, Hive use same session token
   - Tokens expire after configured time period

## Authorization Model

### RBAC (Role-Based Access Control)
- Assigns broad permissions based on job function
- Simplifies management for common access patterns
- Groups: Users, DataAnalysts, DataEngineers, DataScientists, Admins

### ABAC (Attribute-Based Access Control)
- Refines RBAC with contextual attributes
- Attributes: Department, Team, Sensitivity, Environment, Project, Action
- Enables fine-grained control without role proliferation

### Policy Enforcement with Apache Ranger
- Centralized policy management
- Real-time access decisions
- Audit logging for compliance (GDPR, PIPL)
- Metadata-driven tagging via Apache Atlas

## Example Workflows

### Workflow 1: Data Analyst Queries Sales Data
1. DA logs into Okta (SSO)
2. Provides MFA code from Google Authenticator
3. Opens DataGrip, connects via JDBC
4. Executes: `SELECT * FROM analytics_db.sales_opportunities`
5. Ranger checks:
   - User in DataAnalysts group ✓
   - Team=Finance attribute ✓
   - Table matches finance_* pattern ✓
   - Sensitivity=Low ✓
6. Query succeeds, returns non-PII sales data

### Workflow 2: Data Engineer Submits Spark Job
1. DE authenticates via Okta + MFA
2. Submits Spark job to process SAP stock data
3. Job writes to `/data/processing/dev/sap_stock`
4. Ranger checks:
   - User in DataEngineers group ✓
   - Environment=Dev attribute ✓
   - Write permission to /data/processing ✓
5. Job executes successfully

### Workflow 3: Data Scientist Updates Model
1. DS authenticates via Okta + MFA
2. Runs Python script to update stock prediction model
3. Script updates `research_db.predict_stock_prices`
4. Ranger checks:
   - User in DataScientists group ✓
   - Project=StockPredictor attribute ✓
   - Update permission on predict_* tables ✓
5. Model update succeeds

## Compliance and Auditing

### GDPR Compliance
- PII data tagged with Sensitivity=High
- Access restricted to authorized personnel only
- Audit logs track all data access
- Data retention policies enforced

### Audit Trail
- All authentication attempts logged
- Authorization decisions recorded
- Failed access attempts flagged
- Quarterly access reviews conducted

### Regular Reviews
- Quarterly permission audits
- Temporary roles expire after 90 days
- Over-privileged accounts identified and corrected
- Compliance reports generated automatically

## Implementation Steps

### 1. Install Apache Ranger
```bash
# Download and install Ranger
wget https://ranger.apache.org/download.html
tar -xzf ranger-x.x.x.tar.gz
cd ranger-x.x.x
./setup.sh
```

### 2. Configure Okta SSO
- Create Okta application for Hadoop
- Configure SAML 2.0 integration
- Map LDAP groups to Ranger groups
- Test SSO login flow

### 3. Enable MFA
- Enroll users in Google Authenticator
- Configure TOTP settings in Okta
- Generate and store backup codes in Vault
- Test MFA authentication

### 4. Apply Ranger Policies
```bash
# Import policies via Ranger REST API
curl -u admin:password -X POST \
  -H "Content-Type: application/json" \
  -d @acme-implementation.json \
  http://ranger-host:6080/service/public/v2/api/policy
```

### 5. Tag Resources with Apache Atlas
```bash
# Tag HDFS paths and Hive tables
atlas-tag create --name "Sensitivity" --values "Low,Medium,High"
atlas-tag apply --entity "/data/analytics" --tag "Sensitivity=Low"
```

### 6. Test and Validate
- Test each user role with sample queries
- Verify access restrictions work correctly
- Check audit logs for proper recording
- Conduct security review

## Troubleshooting

### Issue: User Cannot Access Resource
1. Check user group membership in LDAP
2. Verify Ranger policy applies to user's group
3. Confirm resource tags match policy conditions
4. Review Ranger audit logs for denial reason

### Issue: MFA Token Not Working
1. Verify time sync on user's device
2. Check backup codes in Vault
3. Re-enroll user in Google Authenticator
4. Test with different authenticator app

### Issue: Policy Not Enforcing
1. Restart Ranger service
2. Verify Ranger plugin enabled on Hadoop
3. Check policy sync status
4. Review Ranger logs for errors

## Best Practices

1. **Principle of Least Privilege**: Grant minimum access needed
2. **Regular Audits**: Review permissions quarterly
3. **Temporary Access**: Use JIT for short-term needs
4. **Metadata Management**: Keep tags up-to-date
5. **Documentation**: Document all policy changes
6. **Testing**: Test policies in dev before production
7. **Monitoring**: Set up alerts for suspicious access patterns
8. **Training**: Educate users on security best practices

## References

- Apache Ranger Documentation: https://ranger.apache.org/
- Apache Atlas Documentation: https://atlas.apache.org/
- Okta SAML Configuration: https://developer.okta.com/
- GDPR Compliance Guide: https://gdpr.eu/
