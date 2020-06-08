.PHONY: cargobuild

cargobuild:
	cd aquatic && cargo build

copy:
	mkdir -p docker/src
	rsync -av aquatic/aquatic* aquatic/plot_pareto aquatic/Cargo* aquatic/LICENSE aquatic/scripts aquatic/README.md docker/src
	rsync -av aquatic/target/debug/aquatic_udp aquatic/target/debug/aquatic_ws docker
  
dockerbuild:
	cd docker && docker build -t rektide/aquatic_ws -t rektide/aquatic .

dockerpush:
	cd docker && docker push rektide/aquatic
	cd docker && docker push rektide/aquatic_ws

all: cargobuild copy dockerbuild

  
