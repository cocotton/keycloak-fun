#!/bin/sh

elasticuser="$1"
elasticpass="$2"

echo "--- Uncompressing data files"
unzip -o /root/accounts.zip -d /root

echo "--- Uploading test data"
curl --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -XPOST -H 'Content-Type: application/x-ndjson' 'localhost:9200/bank/account/_bulk?pretty' --data-binary @accounts.json

echo "--- Done"
