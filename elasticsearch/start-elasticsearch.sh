#!/bin/bash

echo "Waiting for keycloak..."
until curl -k https://keycloak:8443/auth/ > /dev/null 2>&1; do echo "."; sleep 2; done

curl -k -XGET https://keycloak:8443/auth/realms/Demo/protocol/saml/descriptor -o /usr/share/elasticsearch/config/idp-descriptor.xml

/usr/local/bin/docker-entrypoint.sh
