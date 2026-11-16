# Database Scripts

This directory contains SQL scripts for initializing the Printer application database.

## Files

- `001_create_users_table.sql` - Creates the users table
- `002_create_documents_table.sql` - Creates the documents table
- `003_create_document_logs_table.sql` - Creates the document_logs table
- `init.sql` - Inserts test/sample data
- `run_all.sh` - Bash script to run all scripts automatically

## Setup Instructions

### Option 1: Automatic (Recommended)
```bash
cd backend/database/scripts
chmod +x run_all.sh
./run_all.sh
```

### Option 2: Manual Execution
```bash
# Connect to MySQL container
docker exec -it printer-mysql mysql -u printer -pprinter_local printer

# Then execute each script:
source 001_create_users_table.sql;
source 002_create_documents_table.sql;
source 003_create_document_logs_table.sql;
source init.sql;
```

### Option 3: One-liner
```bash
cd backend
cat database/scripts/00*.sql database/scripts/init.sql | mysql -h mysql -u printer -pprinter_local printer
```

## Verification

After running the scripts, verify tables were created:

```bash
docker exec -it printer-mysql mysql -u printer -pprinter_local printer -e "SHOW TABLES;"
```

You should see:
- `users`
- `documents`
- `document_logs`

## Default Test Credentials

After running `init.sql`, you have:

**User 1:**
- Email: `test@example.com`
- Password: (hashed - see init.sql for hash value)

**User 2:**
- Email: `admin@example.com`
- Password: (hashed - see init.sql for hash value)

**Note:** The password hashes in init.sql are placeholder values. Update them with actual bcrypt hashes before using in production.
