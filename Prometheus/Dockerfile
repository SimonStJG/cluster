FROM arm32v6/alpine

ENV PROMETHEUS_VERSION 1.7.1

RUN apk add --update curl

RUN curl -Ls https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-armv7.tar.gz | tar -xzC /tmp/ && \
    cd /tmp/prometheus-$PROMETHEUS_VERSION.linux-armv7 && \
    mkdir -p /etc/prometheus && \
    mv prometheus /bin/prometheus && \
    mv promtool /bin/promtool && \
    mv prometheus.yml /etc/prometheus/prometheus.yml && \
    mv console_libraries /etc/prometheus/ && \
    mv consoles /etc/prometheus/ && \
    cd /tmp && rm -rf prometheus-$PROMETHEUS_VERSION.linux-armv7

ADD prometheus.yml /etc/prometheus/
ADD alert.rules /etc/prometheus/

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus

ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "-config.file=/etc/prometheus/prometheus.yml", \
             "-storage.local.path=/prometheus", \
             "-web.console.libraries=/etc/prometheus/console_libraries", \
             "-web.console.templates=/etc/prometheus/consoles" ]
