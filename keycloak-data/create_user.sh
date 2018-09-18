#!/bin/sh

bearer_token=`curl -ks "https://keycloak:8443/auth/realms/master/protocol/openid-connect/token" -d "client_id=admin-cli" -d "username=${KEYCLOAK_USERNAME}" -d "password=${KEYCLOAK_PASSWORD}" -d "grant_type=password" | jq -r '.access_token'`

curl -k -XPOST -H "Authorization: bearer ${bearer_token}" -H "Content-Type: application/json" "https://keycloak:8443/auth/admin/realms/Demo/users" \
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

curl -k -XPOST -H "Authorization: bearer ${bearer_token}" -H "Content-Type: application/json" "https://keycloak:8443/auth/admin/realms" \
 -d @realm-export.json
