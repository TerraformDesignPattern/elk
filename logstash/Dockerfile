FROM java:8-alpine

ENV HOME_DIR /opt
ENV VERSION 2.4.0

WORKDIR ${HOME_DIR}

# Insatall Logstash
RUN apk add --update bash curl perl tar && \
    curl -O https://download.elastic.co/logstash/logstash/logstash-${VERSION}.tar.gz && \
    tar -xvf logstash-${VERSION}.tar.gz && \
    rm -rf logstash-${VERSION}.tar.gz /var/cache/apk/* && \
    ln -s logstash-${VERSION} logstash

## Install Plugins
RUN /opt/logstash/bin/logstash-plugin install logstash-input-cloudwatch_logs

ENV PATH=/opt/logstash/vendor/jruby/bin:$PATH

EXPOSE 6379

ENTRYPOINT ["/opt/logstash/bin/logstash"]

CMD []
