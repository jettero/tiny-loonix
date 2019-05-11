

include .git/docker-vars

GIT_DESC   := $(shell git describe --dirty --always)
IMAGE_NAME := $(HUB_USER)/$(HUB_REPO):$(GIT_DESC)

default:
	@echo IMAGE_NAME=$(IMAGE_NAME)

include docker-vars.mk
