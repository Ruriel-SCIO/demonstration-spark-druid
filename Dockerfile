FROM alpine:3.7
ENV DRUID_VERSION=0.21.0
ENV ZOOKEEPER_VERSION=3.7.0

RUN apk update
RUN apk add curl openjdk8 tar perl bash

WORKDIR /downloads
RUN curl https://downloads.apache.org/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz \
-o druid.tar.gz
RUN tar -xf druid.tar.gz --directory /
RUN mv /apache-druid-${DRUID_VERSION} /druid

RUN curl https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz \
-o zk.tar.gz
RUN tar -xf zk.tar.gz --directory /druid
RUN mv /druid/apache-zookeeper-${ZOOKEEPER_VERSION}-bin /druid/zk
EXPOSE 8888

WORKDIR /druid/bin
CMD [ "./start-micro-quickstart" ]