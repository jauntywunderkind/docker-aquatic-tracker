.PHONY: cargobuild

cargobuild:
	cd aquatic && cargo build
  

all: cargobuild
  
