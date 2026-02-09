# Plan Projektu: Testowa Strona Gazety/Bloga

## Data utworzenia: 2026-02-07

---

## 1. CELE PROJEKTU

### Cel główny
Stworzenie testowej instancji strony internetowej dla lewackiej gazety.

### Cele szczegółowe
- [x] Utworzenie planu działania
- [ ] Wybór generatora statycznego (Jekyll vs Hugo)
- [ ] Konfiguracja GitHub Pages
- [ ] Integracja Decap CMS
- [ ] Implementacja uwierzytelniania przez DecapBridge
- [ ] Przygotowanie architektury umożliwiającej łatwą zmianę metody uwierzytelniania
- [ ] Stworzenie przykładowej struktury treści
- [ ] Testowanie z wieloma użytkownikami

---

## 2. WYMAGANIA TECHNICZNE

### Hosting i infrastruktura
- **Hosting**: GitHub Pages (standard lub dla organizacji)
- **Generator**: Jekyll LUB Hugo
- **CMS**: Decap CMS (dawniej Netlify CMS)
- **Uwierzytelnianie**: DecapBridge (z możliwością łatwej zmiany)
- **Koszt**: 100% darmowe rozwiązania

### Wymagania funkcjonalne
- Obsługa do 50 redaktorów
- System ról i uprawnień
- Łatwa edycja treści przez panel CMS
- Responsywny design
- Wsparcie dla kategorii i tagów
- System komentarzy (opcjonalnie)

---

## 3. ANALIZA TECHNOLOGII

### Jekyll vs Hugo - Porównanie

#### Jekyll
**Zalety:**
- Natywne wsparcie GitHub Pages
- Duża społeczność i dojrzałość
- Łatwa integracja z Decap CMS

**Wady:**
- Wolniejsze buildowanie przy dużej liczbie postów
- Wymaga Ruby w lokalnym środowisku

#### Hugo
**Zalety:**
- Bardzo szybkie buildowanie
- Jeden binarny plik (łatwa instalacja)
- Bogaty system szablonów
- Lepsza wydajność przy dużych projektach

**Wady:**
- Wymaga dodatkowej konfiguracji GitHub Actions dla deploymentu
- Nieco bardziej złożona składnia szablonów

**REKOMENDACJA**: Hugo - ze względu na:
- Lepszą skalowalność
- Szybsze buildowanie
- Lepszą wydajność w długim terminie

### Decap CMS
- Open-source, Git-based CMS
- Przechowuje treści jako pliki w repo
- Wsparcie dla różnych backend'ów uwierzytelniania
- Doskonała integracja z generatorami statycznymi

### DecapBridge
- Serwer proxy dla uwierzytelniania OAuth
- Bezpłatny tier dostępny
- Łatwa konfiguracja
- **Modułowa architektura** - łatwa wymiana na:
  - GitHub OAuth App (własna implementacja)
  - External OAuth providers

---

## 4. ARCHITEKTURA PROJEKTU

### Struktura katalogów (Hugo)
```
medium-test/
├── config.toml                 # Główna konfiguracja Hugo
├── content/
│   ├── posts/                  # Artykuły
│   ├── pages/                  # Strony statyczne
│   └── authors/                # Profile autorów
├── themes/
│   └── newspaper-theme/        # Dedykowany motyw
├── static/
│   ├── admin/                  # Decap CMS
│   │   ├── config.yml
│   │   └── index.html
│   └── images/
├── layouts/
│   ├── _default/
│   ├── posts/
│   └── partials/
└── .github/
    └── workflows/
        └── deploy.yml          # GitHub Actions dla Hugo
```

### Warstwa uwierzytelniania - Architektura modularna
```
┌─────────────────┐
│   Decap CMS     │
└────────┬────────┘
         │
         │ (konfiguracja backend)
         ▼
┌─────────────────────────────┐
│  Auth Abstraction Layer     │
│  (config.yml)               │
└────────┬────────────────────┘
         │
         │ (wybór providera)
         ▼
┌────────────────────────────────────────┐
│  Provider 1: DecapBridge (default)     │
│  Provider 2: GitHub OAuth              │
└────────────────────────────────────────┘
```

---

## 5. PLAN IMPLEMENTACJI

### Faza 1: Inicjalizacja projektu (Priorytet: WYSOKI)
- [ ] Inicjalizacja Hugo w katalogu
- [ ] Utworzenie struktury folderów
- [ ] Konfiguracja podstawowa config.toml
- [ ] Wybór/stworzenie motywu dla gazety

### Faza 2: GitHub Pages Setup (Priorytet: WYSOKI)
- [ ] Utworzenie GitHub repository
- [ ] Konfiguracja GitHub Actions dla Hugo
- [ ] Setup GitHub Pages (branch: gh-pages)
- [ ] Test deployment

### Faza 3: Decap CMS Integration (Priorytet: ŚREDNI)
- [ ] Instalacja Decap CMS
- [ ] Konfiguracja admin/config.yml
- [ ] Definicja kolekcji (posts, pages, authors)
- [ ] Konfiguracja widgetów i pól
- [ ] Setup editorial workflow

### Faza 4: Uwierzytelnianie (Priorytet: ŚREDNI)
- [ ] Konfiguracja DecapBridge jako domyślny backend
- [ ] Przygotowanie dokumentacji zamiany providera
- [ ] Utworzenie plików konfiguracyjnych dla alternatywnych metod
- [ ] Testowanie przepływu logowania

### Faza 5: Content & Design (Priorytet: NISKI)
- [ ] Stworzenie przykładowych artykułów
- [ ] Konfiguracja ról i uprawnień (poprzez CMS)
- [ ] Dostosowanie motywu wizualnego
- [ ] Dodanie nawigacji i menu

### Faza 6: Testing & Documentation (Priorytet: NISKI)
- [ ] Testowanie workflow redakcyjnego
- [ ] Dokumentacja dla redaktorów
- [ ] Dokumentacja techniczna
- [ ] Utworzenie przewodnika po zmianie auth providera

---

## 6. KONFIGURACJA UWIERZYTELNIANIA

### DecapBridge (domyślnie)
```yaml
backend:
  name: github
  repo: owner/repo
  branch: main
  base_url: https://decapbridge.example.com
  auth_endpoint: auth
```

### Łatwa zamiana na GitHub OAuth (własny)
```yaml
backend:
  name: github
  repo: owner/repo
  branch: main
  # Wymaga GitHub OAuth App
```

---

## 7. KOSZTY I LIMITY (wszystko darmowe)

### GitHub Pages
- ✓ Darmowy hosting
- ✓ Bandwidth: 100GB/miesiąc
- ✓ Build: 10 builds/hour
- ✓Limit rozmiaru repo: 1GB (zalecane)

### DecapBridge
- ✓ Darmowy tier dostępny
- ✓ Alternatywa: własna instancja na Vercel/Netlify

### Hugo
- ✓ 100% darmowy, open-source

### Decap CMS
- ✓ 100% darmowy, open-source

---

## 8. RYZYKA I MITYGACJA

| Ryzyko | Prawdopodobieństwo | Wpływ | Mitygacja |
|--------|-------------------|-------|-----------|
| DecapBridge przestanie być darmowy | Średnie | Wysoki | Architektura modularna - łatwa zamiana na inny provider |
| Przekroczenie limitów GitHub Pages | Niskie | Średni | Monitoring użycia, optymalizacja obrazków |
| Konflikty przy jednoczesnej edycji | Średnie | Średni | Editorial workflow w Decap CMS |
| Zbyt wolne buildowanie | Niskie | Niski | Hugo jest bardzo szybki |

---

## 9. METRYKI SUKCESU

- [ ] Strona dostępna publicznie na GitHub Pages
- [ ] Decap CMS funkcjonalny z panelem administracyjnym
- [ ] Udane logowanie przez DecapBridge
- [ ] Możliwość dodania/edycji/usunięcia artykułu przez CMS
- [ ] Responsywny design działa na mobile/tablet/desktop
- [ ] Dokumentacja umożliwia zamianę auth w <30 minut
- [ ] Build time <30 sekund dla 100 artykułów

---

### Przydatne repozytoria
- Hugo Themes: https://themes.gohugo.io/
- Decap CMS Templates: https://decapcms.org/docs/examples/

