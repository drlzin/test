#!/bin/bash

# Uruchamia lokalny CMS z Decap backend
# Wymaga: npx (Node.js)

echo "╔════════════════════════════════════════════════════╗"
echo "║   Decap CMS - Lokalny Development Mode             ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""

# Sprawdź czy npx jest zainstalowane
if ! command -v npx &> /dev/null; then
    echo "❌ BŁĄD: npx nie jest zainstalowane"
    echo ""
    echo "Zainstaluj Node.js:"
    echo "  brew install node"
    echo ""
    exit 1
fi

echo "✓ npx znalezione"
echo ""

# Uruchom decap-server w tle
echo "Uruchamianie Decap CMS server (port 8081)..."
npx decap-server &
CMS_PID=$!

echo "✓ CMS server uruchomiony (PID: $CMS_PID)"
echo ""

# Poczekaj chwilę
sleep 2

# Uruchom Hugo server
echo "Uruchamianie Hugo server (port 1313)..."
echo ""

hugo server --buildDrafts --buildFuture --baseURL "http://localhost:1313/" &
HUGO_PID=$!

# Cleanup function
cleanup() {
    echo ""
    echo "Zatrzymywanie serwerów..."
    kill $CMS_PID 2>/dev/null || true
    kill $HUGO_PID 2>/dev/null || true
    echo "✓ Serwery zatrzymane"
    exit 0
}

trap cleanup EXIT INT TERM

# Poczekaj aż Hugo się uruchomi
sleep 3

echo ""
echo "╔════════════════════════════════════════════════════╗"
echo "║   Serwery uruchomione!                             ║"
echo "╚════════════════════════════════════════════════════╝"
echo ""
echo "CMS Panel:  http://localhost:1313/admin/"
echo "Strona:     http://localhost:1313/"
echo ""
echo "Zmiany w CMS będą zapisywane lokalnie do plików."
echo "Naciśnij Ctrl+C aby zatrzymać."
echo ""

# Czekaj
wait
