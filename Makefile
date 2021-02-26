#!make
include .env
export $(shell sed 's/=.*//' .env)

build-alpine:
	cp mail docker/alpine/
	chmod +x docker/alpine/mail docker/alpine/styleci-entrypoint.sh
	docker build -t javanile/styleci:alpine docker/alpine

build-ubuntu:
	cp mail docker/ubuntu/
	chmod +x docker/ubuntu/styleci-entrypoint.sh
	docker build -t javanile/styleci:ubuntu docker/ubuntu

push: build-alpine build-ubuntu
	@git add .; git commit -am "publish" || true; git push
	docker push javanile/styleci:alpine
	#docker push javanile/styleci:ubuntu

test-alpine-help: build-alpine
	@docker run --rm -v $${PWD}:/app javanile/styleci:alpine --help

test-alpine-mail: build-alpine
	@docker run --rm -e MAIL_SMTP=$${MAIL_SMTP} -v $${PWD}:/app javanile/styleci:alpine sh -c "echo Hello! | mail Hello! info.francescobianco@gmail.com"

test-remote: build
	@if [[ ! -d test/fixtures/repo ]]; then git clone https://github.com/javanile/adminer test/fixtures/repo; fi
	@docker run --rm -e STYLECI_GITHUB_API_KEY=$${STYLECI_GITHUB_API_KEY} -v $${PWD}/test/fixtures/repo:/app -u $$(id -u) javanile/styleci
