FROM alpine:3.8

RUN apk --no-cache add curl busybox-extras

COPY accounts.zip /root/
COPY elasticsearch_setup.sh /root/

ENTRYPOINT /root/elasticsearch_setup.sh
