.PHONY: build serve clean

## build: Build documentation site
build:
	mkdocs build

## serve: Serve documentation locally
serve:
	mkdocs serve

## clean: Clean built site
clean:
	rm -rf site/
