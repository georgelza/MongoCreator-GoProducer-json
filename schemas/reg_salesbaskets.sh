#!/bin/bash

schema=$(cat schema_salesbaskets.json | sed 's/\"/\\\"/g' | tr -d "\n\r")
SCHEMA="{\"schema\": \"$schema\", \"schemaType\": \"JSON\"}"
curl -X POST -H "Content-Type: application/vnd.schemaregistry.v1+json" \
  --data "$SCHEMA" \
  http://localhost:8081/subjects/json_salesbaskets-value/versions
