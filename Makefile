.PHONY: cargobuild

cargobuild:
	cd aquatic && cargo build

copy:
	rsync -av aquatic/aquatic* docker/
  
dockerbuild:
	cd docker && docker build -t rektide/aquatic_ws .

all: cargobuild copy dockerbuild

  
