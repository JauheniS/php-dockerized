BUILD_PATH := $(CURDIR)

PHP_CONTAINER := php

# Auto-detect OS to select proper dev compose file (Linux vs macOS/Apple Silicon)
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
	COMPOSE_FILE := docker-compose-apple.yaml
else
	COMPOSE_FILE := docker-compose.yaml
endif

.PHONY: rebuild rebuild-nocache restart recreate run stop

TARGETS := rebuild rebuild-nocache restart recreate run stop

rebuild:
	docker compose -f $(COMPOSE_FILE) build

rebuild-nocache:
	docker compose -f $(COMPOSE_FILE) build --no-cache

run:
	docker compose -f $(COMPOSE_FILE) up -d

recreate:
	docker compose -f $(COMPOSE_FILE) up -d --force-recreate

stop:
	docker compose -f $(COMPOSE_FILE) down

restart:
	$(MAKE) stop
	$(MAKE) run

help:
	@printf "Available targets:\n"
	@for t in $(TARGETS); do \
		case "$$t" in \
			rebuild) d="Build Docker images";; \
			rebuild-nocache) d="Build Docker images without cache";; \
			run) d="Start services with docker-compose (system specific)";; \
			recreate) d="Force recreate and start services";; \
			stop) d="Stop and remove services";; \
			restart) d="Restart services (stop && run)";; \
			*) d="";; \
		esac; \
		printf "  %-28s %s\n" "$$t" "$$d"; \
	done
