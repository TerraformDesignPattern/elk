FROM java:8-alpine


ENV KIBANA_VERSION 4.6.0

WORKDIR /opt

RUN apk add --update nodejs curl tar && \
    curl -LO https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
    tar -xvf kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
    rm kibana-${KIBANA_VERSION}-linux-x86_64/node/bin/node && \
    rm kibana-${KIBANA_VERSION}-linux-x86_64/node/bin/npm && \
    ln -s /usr/bin/node /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node/bin/node && \
    ln -s /usr/bin/npm /opt/kibana-${KIBANA_VERSION}-linux-x86_64/node/bin/npm && \
    rm -rf kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz /var/cache/apk/* && \
    ln -s kibana-${KIBANA_VERSION}-linux-x86_64 kibana

COPY assets/kibana.yml /opt/kibana/config/kibana.yml

EXPOSE 5601

ENTRYPOINT ["/opt/kibana/bin/kibana"]

CMD []
