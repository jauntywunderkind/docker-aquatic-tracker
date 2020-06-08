.PHONY: cargobuild

cargobuild:
	cd aquatic && cargo build

copy:
	rsync -av aquatic/aquatic* docker/
  
dockerbuild:
	cd docker && docker build -t rektide/aquatic_ws -t rektide/aquatic .

all: cargobuild copy dockerbuild

  
