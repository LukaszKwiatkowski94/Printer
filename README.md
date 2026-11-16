# Printer

Printer to projekt aplikacji, która ma ułatwić przygotowanie dokumentu i
wysłanie go na adres e-mail drukarki HP. Docelowo użytkownik będzie mógł
przygotować dokument w aplikacji, a następnie przekazać go do wydruku bez
konieczności ręcznego wysyłania wiadomości z załącznikiem.

## Aktualny stan

Projekt zawiera szkielet aplikacji frontendowej w Angularze i backendu w
Laravelu. Funkcje przygotowywania dokumentów, integracja z adresem e-mail
drukarki oraz połączenie frontendu z backendem nie są jeszcze zaimplementowane.
Po uruchomieniu frontendu zobaczysz domyślną stronę startową Angulara, a
backend udostępnia na razie stronę powitalną Laravel.

## Technologie i struktura

- `frontend/` — aplikacja Angular 21.
- `backend/` — aplikacja Laravel 12, uruchamiana na PHP 8.2 lub nowszym.
- `compose.yaml` — kontener roboczy oraz lokalna baza MySQL 8.
- `.devcontainer/` — konfiguracja środowiska VS Code Dev Containers; obraz
  zawiera PHP 8.3, Composer i Node.js 22.

Przykładowa konfiguracja Laravel w `backend/.env.example` używa SQLite.
Kontener MySQL jest uruchamiany przez Docker Compose, ale backend nie korzysta
z niego domyślnie.

## Uruchomienie w VS Code

Wymagane są Docker z Docker Compose oraz VS Code z rozszerzeniem **Dev
Containers**.

1. Otwórz katalog projektu w VS Code.
2. Wybierz **Dev Containers: Reopen in Container**. VS Code zbuduje obraz
   środowiska, a Docker Compose uruchomi kontener roboczy i MySQL.
3. Przy pierwszym uruchomieniu otwórz terminal w kontenerze i przygotuj
   backend. Jeśli masz już własny plik `.env`, zachowaj go i pomiń kopiowanie
   przykładowej konfiguracji.

   ```bash
   cd backend
   test -f .env || cp .env.example .env
   touch database/database.sqlite
   composer install
   php artisan key:generate
   php artisan migrate
   ```

4. W tym terminalu uruchom backend:

   ```bash
   php artisan serve --host=0.0.0.0
   ```

   Backend będzie dostępny pod adresem <http://localhost:8000>.

5. Otwórz drugi terminal w kontenerze i uruchom frontend:

   ```bash
   cd frontend
   npm install
   npm start -- --host 0.0.0.0
   ```

   Frontend będzie dostępny pod adresem <http://localhost:4200>.

Zatrzymaj serwery skrótem `Ctrl+C` w odpowiednich terminalach. Aby zatrzymać
kontenery, zamknij środowisko Dev Container w VS Code.
