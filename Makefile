.PHONY: cargobuild

cargobuild:
	cd aquatic && cargo build

copy:
	mkdir -p docker/src
	rsync -av aquatic/aquatic* aquatic/plot_pareto aquatic/Cargo* aquatic/LICENSE aquatic/scripts aquatic/README.md docker/src
	rsync -av -f"- */" -f"+ *" aquatic/target/debug/*  docker
  
dockerbuild:
	cd docker && docker build -t rektide/aquatic_ws -t rektide/aquatic .

all: cargobuild copy dockerbuild

  
