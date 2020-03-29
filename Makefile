.PHONY: init help build

include .env
export $(shell sed 's/=.*//' .env)

default: build

help:
	@echo "Help: "
	@echo "build: init, build, build"
	@echo "init: submodule initialization and updates"
init:
	git submodule update --init --recursive

core:
	docker-compose build

up:
	docker-compose up -d

build:
	init core up

logs:
	docker-compose logs --tail=500 -f dash
