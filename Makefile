IMAGE_NAME = melpazoid
PACKAGE_NAME ?= NONE

.PHONY: run
run:
	python melpazoid/melpazoid.py

.PHONY: test
test: image
	@docker run -it --rm --network none ${IMAGE_NAME}

.PHONY: term
term: image
	docker run -it --rm --entrypoint=/bin/bash ${IMAGE_NAME}

.PHONY: image
image:
	@docker build --build-arg PACKAGE_NAME --quiet \
		--tag ${IMAGE_NAME} -f docker/Dockerfile .

.PHONY: cask-test
cask-test: .cask
	cask exec buttercup -L .

.cask:
	cask install
	touch $@
