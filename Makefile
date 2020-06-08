.PHONY: aquatic aquatic-cargo aquatic-docker-copy aquatic-docker-config aquatic-docker aquatic-docker-push

aquatic: aquatic-cargo aquatic-docker-copy aquatic-docker-config aquatic-docker aquatic-docker-push

aquatic-cargo:
	cd aquatic && cargo build

aquatic-docker-copy:
	mkdir -p docker/src
	rsync -av aquatic/aquatic* aquatic/plot_pareto aquatic/Cargo* aquatic/LICENSE aquatic/scripts aquatic/README.md docker/src
	rsync -av aquatic/target/debug/aquatic_udp aquatic/target/debug/aquatic_ws docker

aquatic-docker-config:
	cd docker && ./aquatic_ws -p > config_ws
	cd docker && ./aquatic_udp -p > config_udp

aquatic-docker:
	cd docker && docker build -t rektide/aquatic_ws:latest -t rektide/aquatic:latest .

aquatic-docker-push:
	docker push rektide/aquatic:latest
	docker push rektide/aquatic_ws:latest

websocat: websocat-cargo websocat-docker-copy websocat-docker

websocat-cargo:
	cd websocat && cargo build --features=ssl

websocat-docker-copy:
	mkdir -p docker-websocat
	rsync -av websocat/target/debug/websocat websocat/LICENSE websocat/*.md websocat/Cargo* docker-websocat
	rsync -av websocat/src docker-websocat/src

websocat-docker:
	cd docker-websocat && docker build -t rektide/websocat .

websocat-docker-push:
	docker push rektide/websocat

all: aquatic websocat

