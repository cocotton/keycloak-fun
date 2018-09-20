#!/bin/bash

curl -ks -XGET https://keycloak:8443/auth/realms/Demo/protocol/saml/descriptor -o /usr/share/elasticsearch/config/idp-descriptor.xml

/usr/local/bin/docker-entrypoint.sh
