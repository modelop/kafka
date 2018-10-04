FROM alpine:3.8

## Install Kafka+Zookeeper, theirs deps and custom nc-less busybox
RUN apk --no-cache add bash curl openjdk8-jre-base &&\
	curl -O https://fastscore.ai/alpine/v3.8/busybox-1.28.4-r1.apk &&\
	apk --no-cache --allow-untrusted add busybox-1.28.4-r1.apk &&\
	rm busybox-1.28.4-r1.apk &&\
	curl http://www-us.apache.org/dist/kafka/1.1.1/kafka_2.11-1.1.1.tgz | tar xz &&\
	mv kafka_2.11-1.1.1 /kafka &&\
	rm -rf /kafka/site-docs /kafka/bin/windows &&\
	chmod -R g=u /kafka

ENV PATH=/kafka/bin:${PATH}

EXPOSE 2181 2888 3888 9092

COPY entry.sh /
ENTRYPOINT ["/entry.sh"]
