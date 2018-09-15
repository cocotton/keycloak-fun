FROM alpine:3.8

RUN apk --no-cache add curl

COPY accounts.zip /root/
COPY upload-data.sh /root/

ENTRYPOINT /root/upload-data.sh
