-include env_make

REPO ?= walkero/docker4sharedance
PHPTAG ?= 5.6-dev
MACPHPTAG ?= 5.6-dev-macos

.PHONY: build buildnc push release

default: build

build:
	docker build -t $(REPO):$(PHPTAG) --build-arg PHP_TAG=$(PHPTAG) .
	docker build -t $(REPO):$(MACPHPTAG) --build-arg PHP_TAG=$(MACPHPTAG) .

buildnc:
	docker build --no-cache -t $(REPO):$(PHPTAG) --build-arg PHP_TAG=$(PHPTAG) .
	docker build --no-cache -t $(REPO):$(MACPHPTAG) --build-arg PHP_TAG=$(MACPHPTAG) .

push:
	docker push $(REPO):$(PHPTAG)
	docker push $(REPO):$(MACPHPTAG)

release: build push
