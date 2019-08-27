BOOKNAME=service-mesh-primer

PRIMER_TOOLCHAIN=gitlabregistry.innoq.com/innoq/tex-toolchain/primer-toolchain:latest
EBOOK_CONVERT=gitlabregistry.innoq.com/innoq/tex-toolchain/ebook-convert:latest

# detect WSL and remove /mnt from pwd
var := $(shell grep -q Microsoft /proc/version)
ifneq ($(.SHELLSTATUS),0)
  PWD := $(subst mnt/,,$(shell readlink -f ${PWD}))
endif

build:
	@echo "Building PDFs, epub3 and mobi..."
	docker pull $(PRIMER_TOOLCHAIN) -q
	docker pull $(EBOOK_CONVERT) -q
	docker run -ti --rm -v ${PWD}:/workdir $(PRIMER_TOOLCHAIN) make -f Makefile.pandoc
	docker run -ti --rm -v ${PWD}:/workdir -w /workdir $(EBOOK_CONVERT) $(BOOKNAME).epub $(BOOKNAME).mobi
	@echo "Done."

clean:
	@echo "Cleaning PDFs, epub3 and mobi..."
	docker run -ti --rm -v ${PWD}:/workdir $(PRIMER_TOOLCHAIN) make -f Makefile.pandoc clean
	rm -rf $(BOOKNAME).mobi

.PHONY: clean all
.DEFAULT_GOAL := build