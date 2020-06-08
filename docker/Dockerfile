FROM debian:buster-slim
WORKDIR /opt/aquatic
RUN adduser --disabled-password --gecos "" aquatic && \
	apt-get update && \
	apt-get install -y libssl1.1 && \
	apt-get remove --purge -y
USER aquatic
COPY . ./
VOLUME /opt/aquatic/etc /opt/aquatic/etc-tls
CMD ./aquatic_ws
