#!/bin/bash
# Implementation example - not from book chapters
# Script to tag HDFS paths and Hive tables with Apache Atlas

ATLAS_HOST="${ATLAS_HOST:-localhost}"
ATLAS_PORT="${ATLAS_PORT:-21000}"

echo "Tagging resources with Apache Atlas"

# Create tags
atlas-tag create --name "Sensitivity" --values "Low,Medium,High"
atlas-tag create --name "Department" --values "Sales,Finance,Marketing"
atlas-tag create --name "Team" --values "Sales,Finance,Engineering"
atlas-tag create --name "Environment" --values "Dev,Staging,Prod"
atlas-tag create --name "Project" --values "StockPredictor"

# Apply tags to HDFS paths
atlas-tag apply --entity "/data/analytics" --tag "Sensitivity=Low"
atlas-tag apply --entity "/data/processing" --tag "Environment=Dev"
atlas-tag apply --entity "/data/research" --tag "Project=StockPredictor"
atlas-tag apply --entity "/public/reports" --tag "Department=Sales"

# Apply tags to Hive tables
atlas-tag apply --entity "analytics_db.finance_*" --tag "Team=Finance"
atlas-tag apply --entity "research_db.predict_*" --tag "Project=StockPredictor"

echo "Tagging complete"
