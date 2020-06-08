FROM debian:buster-slim
WORKDIR /opt/aquatic
VOLUME /opt/aquatic/etc /opt/aquatic/etc-tls
EXPOSE 3000/tcp
EXPOSE 3000/udp
RUN adduser --disabled-password --gecos "" aquatic && \
	apt-get update && \
	apt-get install -y libssl1.1 && \
	apt-get remove --purge -y
USER aquatic
COPY aquatic_udp aquatic_ws config_udp config_ws ./
COPY src ./src
CMD ./aquatic_ws
