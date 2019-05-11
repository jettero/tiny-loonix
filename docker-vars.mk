
.git/docker-vars: docker-vars.mk
	@echo building $@
	@echo HUB_USER := $${USER} > $@
	@echo HUB_REPO := $$(basename $$(pwd)) >> $@
