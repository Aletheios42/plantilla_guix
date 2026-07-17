.PHONY: help check pull dev prod ci lint test build ci-act all

LINT_CMD ?=
TEST_CMD ?=
BUILD_CMD ?=

define comprobar_cmd
	@if [ -z "$($(1))" ]; then \
		echo "Define $(1) en tu override o variable de entorno"; \
		exit 1; \
	fi
endef

help: ## Muestra esta ayuda
	@printf "\033[1;33mComandos disponibles:\033[0m\n"
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk -F'##' '{printf "\033[32m%-15s\033[0m %s\n", $$1, $$2}'

check:
	@command -v guix >/dev/null || { echo "Falta: guix — https://guix.gnu.org"; exit 1; }

pull: check ## Sincroniza los canales Guix con manifest/channels.scm
	@guix pull -C manifest/channels.scm

dev: export ENV := DEV
dev: check ## Shell de desarrollo
	@exec guix shell -m manifest/dev.scm

prod: export ENV := PROD
prod: check ## Shell de producción
	@exec guix shell -m manifest/prod.scm

lint: check ## Ejecuta el linter (define LINT_CMD)
	$(call comprobar_cmd,LINT_CMD)
	@guix shell -m manifest/ci.scm -- $(LINT_CMD)

test: check ## Ejecuta los tests (define TEST_CMD)
	$(call comprobar_cmd,TEST_CMD)
	@guix shell -m manifest/ci.scm -- $(TEST_CMD)

build: check ## Compila el proyecto (define BUILD_CMD)
	$(call comprobar_cmd,BUILD_CMD)
	@guix shell -m manifest/ci.scm -- $(BUILD_CMD)

ci: check lint test build ## Pipeline CI (usada por el runner remoto)

ci-act: check ## Simula la pipeline completa localmente con act
	@command -v act >/dev/null || { echo "Falta: act — https://github.com/nektos/act"; exit 1; }
	@act -j ci

all: help
