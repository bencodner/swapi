.PHONY: help
help: ## help
	@awk 'BEGIN {FS = ":.&?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.EXPORT_ALL_VARIABLES:

VERSION = "0.0.1"
IMAGENAME=starwars

.PHONY: build
build: ## build
	@echo "Building Container..."
	docker build -t $(IMAGENAME):$(VERSION) .

.PHONY: run
run: ## run
	@echo "Getting Data for title: $(title)"
	docker run --rm -it $(IMAGENAME):$(VERSION) $(title)