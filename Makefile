
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
	@source .env
	@if [[ ! -d test/fixtures/repo ]]; then git clone https://github.com/javanile/adminer test/fixtures/repo; fi
	@docker run --rm -v $${PWD}/test/fixtures/repo:/app -u $$(id -u) javanile/styleci
