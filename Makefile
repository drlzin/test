.PHONY: help test test-phase1 test-server test-cms test-production validate-ready hugo hugo-cms cms build clean

help:
	@echo "Dostępne komendy:"
	@echo "  make hugo             - Uruchom serwer lokalny Hugo"
	@echo "  make hugo-cms         - Uruchom Hugo + CMS server"
	@echo "  make cms              - Uruchom tylko CMS server (decap-server)"
	@echo "  make build            - Zbuduj stronę produkcyjną"
	@echo "  make test             - Uruchom wszystkie testy"
	@echo "  make test-phase1      - Uruchom testy Fazy 1"
	@echo "  make test-server      - Uruchom testy lokalnego serwera"
	@echo "  make test-cms         - Uruchom testy Decap CMS"
	@echo "  make test-production  - Test buildu produkcyjnego"
	@echo "  make validate-ready   - Sprawdź czy projekt gotowy do GitHub Pages"
	@echo "  make clean            - Wyczyść wygenerowane pliki"

hugo:
	hugo server --buildDrafts --buildFuture

hugo-cms:
	@./scripts/start-cms-local.sh

cms:
	@echo "Uruchamianie Decap CMS server..."
	npx decap-server

build:
	hugo --minify --buildFuture

test: test-phase1 test-server test-cms

test-phase1:
	@./tests/test-phase1.sh

test-server:
	@./tests/test-local-server.sh

test-cms:
	@./tests/test-decap-cms.sh

test-production:
	@./scripts/test-production-build.sh

validate-ready:
	@./scripts/validate-github-ready.sh

clean:
	rm -rf public/ resources/ .hugo_build.lock
