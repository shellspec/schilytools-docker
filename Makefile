COMPOSE := docker-compose -f docker-compose.test.yml

all: build test

build:
	$(COMPOSE) build --pull

run:
	$(COMPOSE) run --rm sut /bin/sh

test:
	$(COMPOSE) up --build --exit-code-from sut --abort-on-container-exit
