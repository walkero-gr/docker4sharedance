-include env_make

REPO ?= walkero/docker4sharedance
TAG ?= 1.0

.PHONY: build buildnc push release

default: build

build:
	docker build -t $(REPO):$(TAG) .
	docker build -t $(REPO):latest .

buildnc:
	docker build --no-cache -t $(REPO):$(TAG) .
	docker build -t $(REPO):latest .

push:
	docker push $(REPO):$(TAG)
	docker push $(REPO):latest

release: build push
