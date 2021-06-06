#Uses Alpine Linux as base
FROM alpine:3.7
#Informs the version of both Druid and Zookeeper
ENV DRUID_VERSION=0.21.0
ENV ZOOKEEPER_VERSION=3.7.0

#Downloads openjdk8, perl and bash. Those are Druid dependencies.
#Also downloads curl and tar, so we can download both Druid and Zookeeper from Apache.
#After extracting each file, we move then to /druid and /druid/zk respectively.
#Then, we delete the downloads folder and remove unused softwares to start Druid.
#It will be available on port 8888.
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