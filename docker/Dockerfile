FROM debian:buster-slim
WORKDIR /opt/aquatic
VOLUME /opt/aquatic/etc /opt/aquatic/etc-tls
RUN adduser --disabled-password --gecos "" aquatic && \
	apt-get update && \
	apt-get install -y libssl1.1 && \
	apt-get remove --purge -y
USER aquatic
COPY aquatic_ws aquatic_udp src ./
CMD ./aquatic_ws
