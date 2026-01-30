#!/bin/bash
# Implementation example - not from book chapters
# Script to apply Ranger policies via REST API

RANGER_HOST="${RANGER_HOST:-localhost}"
RANGER_PORT="${RANGER_PORT:-6080}"
RANGER_USER="${RANGER_USER:-admin}"
RANGER_PASS="${RANGER_PASS:-password}"
POLICY_FILE="${1:-../examples/acme-implementation.json}"

echo "Applying Ranger policies from: $POLICY_FILE"
echo "Ranger endpoint: http://$RANGER_HOST:$RANGER_PORT"

curl -u "$RANGER_USER:$RANGER_PASS" \
  -X POST \
  -H "Content-Type: application/json" \
  -d @"$POLICY_FILE" \
  "http://$RANGER_HOST:$RANGER_PORT/service/public/v2/api/policy"

echo ""
echo "Policy application complete"
