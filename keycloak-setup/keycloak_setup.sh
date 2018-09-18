#!/bin/sh

echo "Waiting for keycloak..."
until curl -k https://keycloak:8443 > /dev/null 2>&1; do echo "."; sleep 2; done
echo "\nDone"

echo "Getting bearer token..."
bearer_token=`curl -ks "https://keycloak:8443/auth/realms/master/protocol/openid-connect/token" -d "client_id=admin-cli" -d "username=${KEYCLOAK_USERNAME}" -d "password=${KEYCLOAK_PASSWORD}" -d "grant_type=password" | jq -r '.access_token'`
echo "\nDone"

echo "Uploading Demo realm..."
curl -k -XPOST -H "Authorization: bearer ${bearer_token}" -H "Content-Type: application/json" "https://keycloak:8443/auth/admin/realms" \
 -d @realm-export.json
echo "\nDone"

echo "Creating demo user..."
curl -ks -XPOST -H "Authorization: bearer ${bearer_token}" -H "Content-Type: application/json" "https://keycloak:8443/auth/admin/realms/Demo/users" \
  -d '{
        "username": "demo",
        "firstName": "Demo",
        "lastName": "User",
        "email": "demouser@example.com",
        "enabled": true,
        "emailVerified": true,
        "attributes": {
          "demo-user-attribute": "Super Demo user attribute"
        },
        "groups": ["Demo Group"],
        "credentials": [{
    	    "type": "password",
    	    "value": "ch4ng3m3!"
        }]
      }'
echo "\nDone"
