.PHONY: help test test-phase1 test-server dev build clean

help:
	@echo "Dostępne komendy:"
	@echo "  make dev         - Uruchom serwer lokalny Hugo"
	@echo "  make build       - Zbuduj stronę produkcyjną"
	@echo "  make test        - Uruchom wszystkie testy"
	@echo "  make test-phase1 - Uruchom testy Fazy 1"
	@echo "  make test-server - Uruchom testy lokalnego serwera"
	@echo "  make clean       - Wyczyść wygenerowane pliki"

dev:
	hugo server --buildDrafts --buildFuture

build:
	hugo --minify --buildFuture

test: test-phase1 test-server

test-phase1:
	@./tests/test-phase1.sh

test-server:
	@./tests/test-local-server.sh

clean:
	rm -rf public/ resources/ .hugo_build.lock
