#!/bin/bash

# Symuluje build produkcyjny jak na GitHub Actions

set -e

echo "========================================="
echo "TEST: Production Build (GitHub Actions)"
echo "========================================="
echo ""

# Kolory
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Cleanup
echo "Czyszczenie poprzednich buildów..."
rm -rf public/ resources/ .hugo_build.lock

# Symulacja buildu jak na GitHub Actions
echo ""
echo "Buildowanie Hugo (production mode)..."
HUGO_ENVIRONMENT=production hugo \
  --gc \
  --minify \
  --buildFuture \
  --baseURL "https://USERNAME.github.io/REPO/"

echo ""
echo -e "${GREEN}✓ Build zakończony pomyślnie${NC}"
echo ""

# Sprawdzenie outputu
echo "Sprawdzanie wygenerowanych plików..."
echo ""

if [ ! -d "public" ]; then
    echo -e "${RED}✗ Katalog public/ nie został utworzony${NC}"
    exit 1
fi

echo "Struktura public/:"
tree -L 2 public/ 2>/dev/null || find public/ -maxdepth 2 -type f | head -20

echo ""
echo "Rozmiar buildu:"
du -sh public/

echo ""
echo "Liczba plików:"
find public/ -type f | wc -l

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Build produkcyjny gotowy!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo "Pliki w public/ są gotowe do deployment na GitHub Pages."
echo ""
echo "UWAGA: baseURL jest ustawiony na placeholder."
echo "Przed pushem na GitHub zmień USERNAME/REPO w hugo.toml"
