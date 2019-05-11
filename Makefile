

include .git/docker-vars

GIT_DESC       := $(shell git describe --dirty --always)
IMAGE_NAME     := $(HUB_USER)/$(HUB_REPO):$(GIT_DESC)
CONTAINER_NAME := $(HUB_REPO)-$(GIT_DESC)

run: build run.sh
	./run.sh

run.sh: Makefile build
	@echo building $@
	@(echo '#!/bin/bash'; echo) > $@
	@echo docker run --rm -ti --name '"$(CONTAINER_NAME)"' '"$(IMAGE_NAME)"' '"$$@"' >> $@
	@chmod -c 0755 $@

build:
ifndef PROXY
	docker image build -t "$(IMAGE_NAME)" .
else
	docker image build -t "$(IMAGE_NAME)" \
		--build-arg http_proxy=http://$(PROXY)/ \
		--build-arg https_proxy=http://$(PROXY)/ \
		.
endif

what:
	@echo IMAGE_NAME=$(IMAGE_NAME)
ifdef PROXY
	@echo PROXY=$(PROXY)
endif

.git/docker-vars:
	@echo building $@
	@echo HUB_USER := $${USER} > $@
	@echo HUB_REPO := $$(basename $$(pwd)) >> $@
