FROM alpine:3.8

RUN apk --no-cache add jq

ADD realm-export.json /root/
ADD keycloak_setup.sh /root/

ENTRYPOINT [ "/root/keycloak_setup.sh" ]
