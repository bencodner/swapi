.PHONY: help build run deploy load-minikube-docker remove-jobs
help: ## help
	@awk 'BEGIN {FS = ":.&?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.EXPORT_ALL_VARIABLES:

VERSION = "0.0.1"
IMAGENAME=starwars
DEPLOYNAME=swapi

build: ## build
	@echo "Building Container..."
	docker build -t $(IMAGENAME):$(VERSION) .

run: ## run
	@echo "Getting Data for title: $(title)"
	docker run --rm -it $(IMAGENAME):$(VERSION) $(title)

# This is a hack because we are deploying from local instead of a registry
.ONESHELL:
deploy: ## deploy to minikube
	@eval $$(minikube docker-env); \
	docker build -t $(IMAGENAME):$(VERSION) .; \
	if [ ! -z "$(title)" ]; then \
		helm install --debug --set job.arg="$(title)" ./deploy; \
	 else \
	  helm install --debug ./deploy; \
	fi

delete-jobs:
	kubectl delete jobs --all
