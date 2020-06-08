.PHONY: cargobuild

cargobuild:
	cd aquatic && cargo build
  
dockerbuild:
	docker build -t rektide/aquatic_ws .

all: cargobuild dockerbuild

  
