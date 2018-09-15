#!/bin/sh

elasticuser="$1"
elasticpass="$2"

printf "Uncompressing data files..."
unzip -o /root/accounts.zip -d /root
printf "DONE\n"

printf "Waiting for Elastic to come online..."
until curl http://elasticsearch:9200 > /dev/null 2>&1; do sleep 2; done
printf "DONE\n"

printf "Waiting for Kibana to come online..."
until curl http://kibana:5601 > /dev/null 2>&1; do sleep 2; done
printf "DONE\n"

printf "Uploading test data..."
curl --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -XPOST -H 'Content-Type: application/x-ndjson' 'http://elasticsearch:9200/bank/account/_bulk?pretty' --data-binary @/root/accounts.json > /dev/null 2>&1
printf "DONE\n"

printf "Creating index pattern..."
curl --user "${ELASTIC_USERNAME}:${ELASTIC_PASSWORD}" -s -XPOST -H "Content-Type: application/json" -H "kbn-xsrf: index_pattern" \
    "http://kibana:5601/api/saved_objects/index-pattern/bank\*" \
    -d "{\"attributes\":{\"title\":\"bank\*\",\"timeFieldName\":\"time\"}}" > /dev/null 2>&1
printf "DONE\n"

printf "Script completed. Exiting.\n"
