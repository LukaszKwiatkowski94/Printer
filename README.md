# Printer

Printer to projekt aplikacji, która ma ułatwić przygotowanie dokumentu i
wysłanie go na adres e-mail drukarki HP. Docelowo użytkownik będzie mógł
przygotować dokument w aplikacji, a następnie przekazać go do wydruku bez
konieczności ręcznego wysyłania wiadomości z załącznikiem.

## Aktualny stan

**Faza 1 (w trakcie): Infrastruktura & Schemat bazy danych ✅**
- Konfiguracja MySQL w `backend/.env`
- SQL scripts do tworzenia tabel (bez ORM)
- Test data seeds

Projekt zawiera szkielet aplikacji frontendowej w Angularze i backendu w
Laravelu. Funkcje przygotowywania dokumentów, integracja z adresem e-mail
drukarki oraz połączenie frontendu z backendem będą implementowane w kolejnych fazach.
Po uruchomieniu frontendu zobaczysz domyślną stronę startową Angulara, a
backend udostępnia na razie stronę powitalną Laravel.

## Technologie i struktura

- `frontend/` — aplikacja Angular 21 z Material Design.
- `backend/` — aplikacja Laravel 12, uruchamiana na PHP 8.2 lub nowszym.
- `compose.yaml` — kontener roboczy oraz baza MySQL 8.
- `.devcontainer/` — konfiguracja środowiska VS Code Dev Containers; obraz
  zawiera PHP 8.3, Composer i Node.js 22.

**Baza danych:**
- MySQL 8 (z Docker Compose)
- SQL scripts w `backend/database/scripts/` (bez ORM/migrations)
- Skrypt inicjalizacyjny: `backend/database/scripts/run_all.sh`

## Uruchomienie w VS Code

Wymagane są Docker z Docker Compose oraz VS Code z rozszerzeniem **Dev
Containers**.

### Setup

1. Otwórz katalog projektu w VS Code.
2. Wybierz **Dev Containers: Reopen in Container**. VS Code zbuduje obraz
   środowiska, a Docker Compose uruchomi kontener roboczy i MySQL.
3. Przy pierwszym uruchomieniu otwórz terminal w kontenerze i przygotuj backend:

   ```bash
   cd backend
   composer install
   php artisan key:generate
   ```

4. **Inicjalizuj bazę danych** (w nowym terminalu w kontenerze):

   ```bash
   cd backend/database/scripts
   ./run_all.sh
   ```

   Lub zaloguj się do MySQL i uruchom skrypty ręcznie:
   ```bash
   mysql -h mysql -u printer -pprinter_local printer < 001_create_users_table.sql
   mysql -h mysql -u printer -pprinter_local printer < 002_create_documents_table.sql
   mysql -h mysql -u printer -pprinter_local printer < 003_create_document_logs_table.sql
   mysql -h mysql -u printer -pprinter_local printer < init.sql
   ```

5. Uruchom backend:

   ```bash
   cd backend
   php artisan serve --host=0.0.0.0
   ```

   Backend będzie dostępny pod adresem <http://localhost:8000>.

6. Otwórz drugi terminal w kontenerze i zainstaluj frontend oraz Angular Material:

   ```bash
   cd frontend
   npm install
   ng add @angular/material
   npm start -- --host 0.0.0.0
   ```

   Frontend będzie dostępny pod adresem <http://localhost:4200>.

### Weryfikacja

- **Backend**: <http://localhost:8000> - powinna pokazać stronę powitalną Laravel
- **Frontend**: <http://localhost:4200> - powinna pokazać stronę startową Angular
- **Baza danych**: 3 tabele (`users`, `documents`, `document_logs`)

### Zatrzymanie

Zatrzymaj serwery skrótem `Ctrl+C` w odpowiednich terminalach. Aby zatrzymać
kontenery, zamknij środowisko Dev Container w VS Code.
