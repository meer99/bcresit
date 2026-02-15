#!/usr/bin/env bash
set -euo pipefail

RESOURCE_GROUP=${1:?"Resource group is required"}
ENVIRONMENT=${2:-"dev"}
PARAM_FILE=${3:-"variable/parameter.dev.json"}

az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file main.bicep \
  --parameters @"$PARAM_FILE" \
  --parameters environment=$ENVIRONMENT