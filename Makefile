.PHONY: cargobuild

cargobuild:
	cd aquatic && cargo build

copy:
	mkdir -p docker/src
	rsync -av aquatic/aquatic* aquatic/plot_pareto aquatic/Cargo* aquatic/LICENSE aquatic/scripts aquatic/README.md docker/src
	rsync -av aquatic/target/debug/aquatic_udp aquatic/target/debug/aquatic_ws docker

configbuild:
	cd docker && ./aquatic_ws -p > config_ws
	cd docker && ./aquatic_udp -p > config_udp

dockerbuild:
	cd docker && docker build -t rektide/aquatic_ws:latest -t rektide/aquatic:latest .

dockerpush:
	cd docker && docker push rektide/aquatic:latest
	cd docker && docker push rektide/aquatic_ws:latest

all: cargobuild copy configbuild dockerbuild

  
