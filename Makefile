

include .git/docker-vars

IMAGE_TAG      := $(shell git describe --dirty --always)
IMAGE_NAME     := $(HUB_USER)/$(HUB_REPO)
IMAGE_NAMETAG  := $(IMAGE_NAME):$(IMAGE_TAG)
CONTAINER_NAME := $(HUB_REPO)-$(IMAGE_TAG)

run: build run.sh
	./run.sh

run.sh: Makefile build
	@echo building $@
	@(echo '#!/bin/bash'; echo) > $@
	@echo docker run --rm -ti --name '"$(CONTAINER_NAME)"' '"$(IMAGE_NAMETAG)"' '"$$@"' >> $@
	@chmod -c 0755 $@

build:
ifndef PROXY
	docker image build -t "$(IMAGE_NAMETAG)" .
else
	docker image build -t "$(IMAGE_NAMETAG)" \
		--build-arg http_proxy=http://$(PROXY)/ \
		--build-arg https_proxy=http://$(PROXY)/ \
		.
endif

prune:
	docker image ls --filter 'reference=$(IMAGE_NAME)*' \
		--filter 'before=$(IMAGE_NAMETAG)' --quiet \
		| xargs -r docker image rm -f; echo
	docker image prune -f; echo


what:
	@echo IMAGE_NAME=$(IMAGE_NAME)
ifdef PROXY
	@echo PROXY=$(PROXY)
endif

.git/docker-vars:
	@echo building $@
	@echo HUB_USER := $${USER} > $@
	@echo HUB_REPO := $$(basename $$(pwd)) >> $@
