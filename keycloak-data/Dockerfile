FROM alpine:3.8

RUN apk --no-cache add jq

ADD create_user.sh /root/

ENTRYPOINT [ "/root/create_user.sh" ]
