#!/bin/bash

echo "Waiting for keycloak..."
until curl -kf https://keycloak:8443/auth/realms/Demo/protocol/saml/descriptor -o /usr/share/elasticsearch/config/idp-descriptor.xml > /dev/null 2>&1; do echo "."; sleep 2; done

/usr/local/bin/docker-entrypoint.sh
