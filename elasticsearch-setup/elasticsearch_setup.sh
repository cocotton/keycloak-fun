#!/bin/sh

elasticuser="$1"
elasticpass="$2"

echo "Uncompressing data files..."
unzip -o /root/accounts.zip -d /root
echo "Done"

echo "Waiting for Elastic to come online..."
until curl -k https://elasticsearch:9200 > /dev/null 2>&1; do echo "."; sleep 2; done
echo "Done"

echo "Waiting for Kibana to come online..."
until curl -k https://kibana:5601 > /dev/null 2>&1; do echo "."; sleep 2; done
echo "Done"

echo "Uploading test data..."
curl -k --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -XPOST -H 'Content-Type: application/x-ndjson' 'https://elasticsearch:9200/bank/account/_bulk?pretty' --data-binary @/root/accounts.json
echo "Done"

echo "Creating index pattern..."
curl -k --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -s -XPOST -H "Content-Type: application/json" -H "kbn-xsrf: index_pattern" \
  "https://kibana:5601/api/saved_objects/index-pattern/bank*" \
  -d '{"attributes":{"title":"bank*"}}'
echo ""
echo "\nDone"

echo "Creating role mappings..."
curl -k --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -s -XPUT -H "Content-Type: application/json" \
  "https://kibana:5601/_xpack/security/role_mapping/saml-kibana" \
  -d '{"roles": [ "kibana_user" ],"enabled": true,"rules": {"field": { "realm.name": "saml1" }}}'
echo "\nDone"

echo "Script completed. Exiting."