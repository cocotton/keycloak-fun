ARG ELK_VERSION

FROM docker.elastic.co/elasticsearch/elasticsearch:${ELK_VERSION}

ADD start-elasticsearch.sh /root/start-elasticsearch.sh

ENTRYPOINT /root/start-elasticsearch.sh
