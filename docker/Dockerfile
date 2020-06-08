FROM debian:buster-slim
WORKDIR /opt/aquatic
COPY aquatic/aquatic_udp aquatic/aquatic_ws aquatic-ws-example.toml aquatic-udp-example.toml ./
VOLUME /opt/aquatic/etc /opt/aquatic/etc-tls
CMD aquatic_ws
