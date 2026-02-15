#!/usr/bin/env bash
set -euo pipefail

RESOURCE_GROUP=${1:?"Resource group is required"}
PARAM_FILE=${2:-"variables/parameters.dev.json"}

az deployment group create \
  --resource-group "$RESOURCE_GROUP" \
  --template-file bicep/main.bicep \
  --parameters @"$PARAM_FILE"