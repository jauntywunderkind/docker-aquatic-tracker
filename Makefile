BUILD_MODE ?= release
AQUATIC_BINS := aquatic aquatic_http aquatic_http_load_test aquatic_udp aquatic_udp_bench aquatic_udp_load_test aquatic_ws aquatic_ws_load_test
AQUATIC_BINS_TARGETS = $(addprefix aquatic/target/$(BUILD_MODE)/,$(AQUATIC_BINS))

CARGO_BUILD_ARGS =

ifeq (release,$(BUILD_MODE))
CARGO_BUILD_ARGS += --release
endif

.PHONY: aquatic aquatic-cargo aquatic-docker-copy aquatic-docker-config websocat websocat-cargo websocat-docker-copy docker docker-push

all: aquatic websocat docker

aquatic: aquatic-cargo aquatic-docker-copy aquatic-docker-config

aquatic-cargo:
	cd aquatic && cargo build $(CARGO_BUILD_ARGS)

aquatic-docker-copy:
	mkdir -p docker/src
	rsync -av aquatic/LICENSE aquatic/scripts aquatic/README.md docker/src
	rsync -av $(AQUATIC_BINS_TARGETS) docker

aquatic-docker-config:
	cd docker && ./aquatic_ws -p > config_ws
	cd docker && ./aquatic_udp -p > config_udp
	cd docker && ./aquatic_http -p > config_http

websocat: websocat-cargo websocat-docker-copy

websocat-cargo:
	cd websocat && cargo build --features=ssl $(CARGO_BUILD_ARGS)

websocat-docker-copy:
	mkdir -p docker-websocat/src-websocat
	rsync -av websocat/target/debug/websocat docker/websocat
	rsync -av websocat/LICENSE websocat/*.md websocat/Cargo* websocat/src docker/src-websocat

docker:
	cd docker && docker build -t rektide/aquatic_ws:latest -t rektide/aquatic:latest .

docker-push:
	docker push rektide/aquatic:latest
	docker push rektide/aquatic_ws:latest
