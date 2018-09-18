#!/bin/sh

elasticuser="$1"
elasticpass="$2"

echo "Uncompressing data files..."
unzip -o /root/accounts.zip -d /root

echo "Waiting for Elastic to come online..."
until curl -k https://elasticsearch:9200 > /dev/null 2>&1; do echo "."; sleep 2; done

echo "Waiting for Kibana to come online..."
until curl -k https://kibana:5601 > /dev/null 2>&1; do echo "."; sleep 2; done

echo "Uploading test data..."
curl -ks --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -XPOST -H 'Content-Type: application/x-ndjson' 'https://elasticsearch:9200/bank/account/_bulk?pretty' --data-binary @/root/accounts.json

echo "Creating index pattern..."
curl -ks --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -XPOST -H "Content-Type: application/json" -H "kbn-xsrf: index_pattern" \
  "https://kibana:5601/api/saved_objects/index-pattern/bank*" \
  -d '{"attributes":{"title":"bank*"}}'

echo "Creating role mappings..."
curl -ks --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -XPUT -H "Content-Type: application/json" \
  "https://kibana:5601/_xpack/security/role_mapping/saml-kibana" \
  -d '{"roles": [ "kibana_user" ],"enabled": true,"rules": {"field": { "realm.name": "saml1" }}}'

echo ""
echo "Script completed. Exiting."
