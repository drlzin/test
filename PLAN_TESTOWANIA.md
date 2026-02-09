# Plan Testowania - Testowa Strona Gazety

## Data utworzenia: 2026-02-07

---

## Faza 1: Inicjalizacja projektu

### Test 1.1: Hugo zainstalowany i działający
```bash
hugo version
# Oczekiwane: hugo v0.155.x lub nowsze
```

### Test 1.2: Struktura projektu utworzona
```bash
ls -la
# Oczekiwane: katalogi: archetypes/, content/, layouts/, static/, themes/
# Oczekiwane: pliki: hugo.toml, .gitignore
```

### Test 1.3: Serwer lokalny działa
```bash
hugo server --buildDrafts
# Otwórz: http://localhost:1313/
# Oczekiwane: strona się wyświetla bez błędów 404
```

### Test 1.4: Git zainicjalizowany
```bash
git status
git log --oneline
# Oczekiwane: commit "Initial Hugo setup..."
```

### Kryteria sukcesu Fazy 1:
- [x] Hugo zainstalowany (sprawdzone: hugo version)
- [x] Podstawowa struktura katalogów istnieje
- [x] Konfiguracja hugo.toml poprawna
- [x] Serwer lokalny wyświetla stronę
- [x] Git repo zainicjalizowane z pierwszym commitem

---

## Faza 2: GitHub Pages Setup

### Test 2.1: GitHub repo utworzone
```bash
git remote -v
# Oczekiwane: origin https://github.com/username/repo.git
```

### Test 2.2: GitHub Actions workflow poprawny
```bash
cat .github/workflows/deploy.yml
# Sprawdź: workflow zawiera kroki: checkout, setup hugo, build, deploy
```

### Test 2.3: Test lokalnego buildu produkcyjnego
```bash
hugo --minify
ls -la public/
# Oczekiwane: katalog public/ zawiera: index.html, css/, posts/
```

### Test 2.4: Deployment działa
```bash
git push origin main
# Sprawdź: https://github.com/username/repo/actions
# Oczekiwane: workflow zakończony sukcesem (zielony ✓)
```

### Test 2.5: Strona dostępna publicznie
```
Otwórz: https://username.github.io/repo/
# Oczekiwane: strona wyświetla się poprawnie
# Sprawdź: CSS załadowany, linki działają
```

### Kryteria sukcesu Fazy 2:
- [ ] GitHub repo istnieje i jest połączone
- [ ] GitHub Actions workflow skonfigurowany
- [ ] Lokalny build produkcyjny działa
- [ ] Push do main trigguje deployment
- [ ] Strona dostępna pod URL GitHub Pages
- [ ] CSS i zasoby statyczne działają

---

## Faza 3: Decap CMS Integration

### Test 3.1: Pliki CMS utworzone
```bash
ls -la static/admin/
# Oczekiwane: config.yml, index.html
```

### Test 3.2: Panel CMS dostępny lokalnie
```
Otwórz: http://localhost:1313/admin/
# Oczekiwane: interfejs Decap CMS się ładuje
```

### Test 3.3: Konfiguracja CMS poprawna
```bash
cat static/admin/config.yml
# Sprawdź: backend, collections, media_folder skonfigurowane
```

### Test 3.4: Kolekcje zdefiniowane
```yaml
# W config.yml sprawdź istnienie:
collections:
  - name: "posts"
  - name: "pages"
  - name: "authors"
```

### Test 3.5: Editorial workflow działa
```
Panel CMS > Nowy post > Zapisz jako draft
# Oczekiwane: utworzony pull request w GitHub
```

### Kryteria sukcesu Fazy 3:
- [ ] Panel /admin/ dostępny
- [ ] Konfiguracja config.yml bez błędów składni
- [ ] Wszystkie kolekcje (posts, pages, authors) widoczne
- [ ] Widgety edycji działają (markdown, image, date)
- [ ] Editorial workflow tworzy PR

---

## Faza 4: Uwierzytelnianie

### Test 4.1: DecapBridge skonfigurowany
```bash
grep -A5 "backend:" static/admin/config.yml
# Oczekiwane: base_url wskazuje na DecapBridge
```

### Test 4.2: Logowanie działa
```
Otwórz: https://username.github.io/repo/admin/
Kliknij: "Login with GitHub"
# Oczekiwane: przekierowanie do OAuth, następnie powrót do CMS
```

### Test 4.3: Autoryzacja sprawdzona
```
Po zalogowaniu sprawdź:
# Oczekiwane: widoczne kolekcje, możliwość edycji
```

### Test 4.4: Test alternatywnego providera
```bash
# Utwórz kopię config.yml
cp static/admin/config.yml static/admin/config.yml.decapbridge
# Zmień backend na git-gateway
# Sprawdź, czy CMS dalej działa (z innym auth)
```

### Test 4.5: Dokumentacja zamiany
```bash
cat docs/AUTH_PROVIDERS.md
# Oczekiwane: instrukcje dla 3+ providerów
# Sprawdź: każda instrukcja ma przykład konfiguracji
```

### Kryteria sukcesu Fazy 4:
- [ ] Logowanie przez DecapBridge działa
- [ ] Po zalogowaniu dostęp do edycji
- [ ] Dokumentacja zamiany providera istnieje
- [ ] Przetestowano minimum 2 providery
- [ ] Zmiana providera zajmuje <30 minut

---

## Faza 5: Content & Design

### Test 5.1: Przykładowe artykuły
```bash
ls content/posts/
# Oczekiwane: minimum 5 przykładowych plików .md
```

### Test 5.2: Różne typy treści
```
Sprawdź istnienie:
- content/posts/*.md (artykuły)
- content/pages/about.md (strona O nas)
- content/authors/*.md (profile autorów)
```

### Test 5.3: Responsywność
```
Otwórz stronę w przeglądarce
DevTools > Toggle device toolbar
Przetestuj: Mobile (375px), Tablet (768px), Desktop (1920px)
# Oczekiwane: treść czytelna na wszystkich rozdzielczościach
```

### Test 5.4: Kategorie i tagi
```
Otwórz: http://localhost:1313/tags/
Otwórz: http://localhost:1313/categories/
# Oczekiwane: listy tagów i kategorii z linkami
```

### Test 5.5: Nawigacja
```
Sprawdź w przeglądarce:
- Menu główne: Home, Posts, About
- Linki działają
- Active state dla bieżącej strony
```

### Kryteria sukcesu Fazy 5:
- [ ] 5+ przykładowych artykułów
- [ ] Strony statyczne (About, Contact)
- [ ] Profile autorów
- [ ] Responsywny design (mobile/tablet/desktop)
- [ ] Kategorie i tagi działają
- [ ] Nawigacja funkcjonalna

---

## Faza 6: Testing & Documentation

### Test 6.1: Workflow redakcyjny - pojedynczy redaktor
```
Scenariusz:
1. Zaloguj do CMS
2. Utwórz nowy post
3. Dodaj tytuł, treść, obraz
4. Zapisz jako draft
5. Opublikuj

Oczekiwane:
- Draft tworzy PR
- Publikacja merguje PR
- Artykuł pojawia się na stronie
```

### Test 6.2: Workflow redakcyjny - wielu redaktorów
```
Scenariusz:
1. Redaktor A: tworzy draft "Post A"
2. Redaktor B: tworzy draft "Post B"
3. Redaktor A: publikuje swój post
4. Sprawdź czy Post B nadal jest draftem

Oczekiwane:
- Brak konfliktów
- Każdy draft to osobny PR
```

### Test 6.3: Performance - czas buildowania
```bash
time hugo --minify
# Oczekiwane: <5 sekund dla 10 postów
# Oczekiwane: <30 sekund dla 100 postów
```

### Test 6.4: Dokumentacja dla redaktorów
```bash
cat docs/REDAKTOR_GUIDE.md
# Sprawdź sekcje:
- Jak się zalogować
- Jak utworzyć artykuł
- Jak dodać obrazy
- Jak używać tagów/kategorii
```

### Test 6.5: Dokumentacja techniczna
```bash
cat README.md
# Sprawdź sekcje:
- Wymagania
- Instalacja lokalna
- Deployment
- Konfiguracja CMS
- Troubleshooting
```

### Kryteria sukcesu Fazy 6:
- [ ] Single-user workflow działa
- [ ] Multi-user workflow działa bez konfliktów
- [ ] Build time <30s dla 100 postów
- [ ] Dokumentacja dla redaktorów kompletna
- [ ] README.md z instrukcjami technicznymi
- [ ] Przewodnik zamiany auth providera

---

## Testy End-to-End (E2E)

### E2E Test 1: Pełny cykl artykułu
```
1. Redaktor loguje się do CMS
2. Tworzy nowy artykuł z obrazem
3. Dodaje tagi i kategorię
4. Zapisuje jako draft
5. Edytor recenzuje draft
6. Redaktor publikuje
7. Artykuł pojawia się na stronie w <2 minuty

Oczekiwane: Każdy krok działa płynnie
```

### E2E Test 2: Symulacja 20 redaktorów
```
1. Utwórz 20 testowych drafts
2. Opublikuj 10 z nich jednocześnie
3. Sprawdź logi GitHub Actions
4. Sprawdź czy wszystkie 10 jest na stronie

Oczekiwane: Brak błędów, wszystkie posty widoczne
```

### E2E Test 3: Zmiana auth providera
```
1. Zanotuj czas rozpoczęcia
2. Zmień DecapBridge na Netlify Identity
3. Przetestuj logowanie
4. Zanotuj czas zakończenia

Oczekiwane: Całość <30 minut
```

---

## Checklist przed produkcją

### Podstawy
- [ ] Hugo działa lokalnie
- [ ] Build produkcyjny bez błędów
- [ ] GitHub Pages deployment działa

### CMS
- [ ] Decap CMS dostępny pod /admin/
- [ ] Logowanie działa
- [ ] Wszystkie kolekcje widoczne
- [ ] Editorial workflow testowany

### Treść
- [ ] Minimum 5 przykładowych postów
- [ ] Strony About/Contact
- [ ] Profile autorów

### Design
- [ ] Responsywny na mobile/tablet/desktop
- [ ] CSS załadowany poprawnie
- [ ] Obrazy wyświetlają się
- [ ] Nawigacja działa

### Dokumentacja
- [ ] README.md kompletny
- [ ] Przewodnik dla redaktorów
- [ ] Instrukcje zamiany auth

### Performance
- [ ] Build <30s dla 100 postów
- [ ] Strona ładuje się <3s
- [ ] Lighthouse score >80

---

## Narzędzia testowania

### Test lokalny
```bash
hugo server --buildDrafts
```

### Build produkcyjny
```bash
hugo --minify
```

### Test performance
```bash
time hugo --minify
```

### Test dostępności
```bash
npm install -g lighthouse
lighthouse https://username.github.io/repo/ --view
```

### Sprawdzenie linków
```bash
npm install -g broken-link-checker
blc https://username.github.io/repo/ -ro
```

### Test responsywności
```bash
# Używając przeglądarki:
# DevTools (F12) > Toggle device toolbar (Ctrl+Shift+M)
# Testuj: Mobile (375px), Tablet (768px), Desktop (1920px)
```

---

## Status testów

### Faza 1: ✓ ZAKOŃCZONA
- [x] Hugo zainstalowany
- [x] Struktura projektu
- [x] Serwer lokalny działa
- [x] Git zainicjalizowany

### Faza 2: ⏳ OCZEKUJĄCA
- [ ] GitHub repo
- [ ] GitHub Actions
- [ ] Deployment

### Faza 3: ⏳ OCZEKUJĄCA
- [ ] Decap CMS

### Faza 4: ⏳ OCZEKUJĄCA
- [ ] Uwierzytelnianie

### Faza 5: ⏳ OCZEKUJĄCA
- [ ] Content & Design

### Faza 6: ⏳ OCZEKUJĄCA
- [ ] Testing & Documentation
