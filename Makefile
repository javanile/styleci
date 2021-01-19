#!make
include .env
export $(shell sed 's/=.*//' .env)

build:
	chmod +x styleci-entrypoint.sh
	docker build -t javanile/styleci .

push: build
	git add .
	git commit -am "publish" || true
	git push
	docker push javanile/styleci

test-help: build
	@docker run --rm -v $${PWD}:/app javanile/styleci --help

test-remote: build
	@if [[ ! -d test/fixtures/repo ]]; then git clone https://github.com/javanile/adminer test/fixtures/repo; fi
	@docker run --rm -e STYLECI_GITHUB_API_KEY=$${STYLECI_GITHUB_API_KEY} -v $${PWD}/test/fixtures/repo:/app -u $$(id -u) javanile/styleci
