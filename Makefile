DOCKER = docker
REPO = dimroc/dockerfile-elasticsearch

TAG = $(shell git rev-parse --abbrev-ref HEAD 2>/dev/null)
ifeq ($(TAG), master)
	TAG = latest
else ifeq ($(TAG), HEAD)
	TAG = latest
endif

all: build push

run:
	$(DOCKER) run -i -t \
		-e "ELASTICSEARCH_USER=admin" \
		-e "ELASTICSEARCH_PASS=password" \
		-p 9200:9200 \
		$(REPO)

build:
	$(DOCKER) build -t $(REPO):$(TAG) .

push:
	$(DOCKER) push $(REPO):$(TAG)
