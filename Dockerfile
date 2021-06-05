FROM alpine:3.7
ENV DRUID_VERSION=0.21.0
ENV ZOOKEEPER_VERSION=3.7.0

RUN apk update --quiet \
&& apk add --no-cache --quiet curl tar openjdk8 perl bash \
&& mkdir /downloads \
&& cd /downloads \
&& curl https://downloads.apache.org/druid/${DRUID_VERSION}/apache-druid-${DRUID_VERSION}-bin.tar.gz \
-o druid.tar.gz \
&& curl https://downloads.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz \
-o zk.tar.gz \
&& tar -xf druid.tar.gz --directory / \
&& mv /apache-druid-${DRUID_VERSION} /druid \
&& tar -xf zk.tar.gz --directory /druid \
&& mv /druid/apache-zookeeper-${ZOOKEEPER_VERSION}-bin /druid/zk \
&& rm -r /downloads \
&& apk del --quiet curl tar

EXPOSE 8888
CMD [ "/druid/bin/start-micro-quickstart" ]