#!/bin/bash

# Run all SQL scripts to initialize the database
# Usage: ./run_all.sh

# Configuration
MYSQL_HOST=${MYSQL_HOST:-mysql}
MYSQL_PORT=${MYSQL_PORT:-3306}
MYSQL_USER=${MYSQL_USER:-printer}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-printer_local}
MYSQL_DB=${MYSQL_DB:-printer}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🔄 Running database initialization scripts..."
echo "Host: $MYSQL_HOST:$MYSQL_PORT"
echo "Database: $MYSQL_DB"
echo ""

# Execute each SQL script
for sql_file in "$SCRIPT_DIR"/00*.sql; do
    if [ -f "$sql_file" ]; then
        echo "📄 Executing: $(basename "$sql_file")"
        mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DB" < "$sql_file"
        if [ $? -eq 0 ]; then
            echo "✅ $(basename "$sql_file") completed successfully"
        else
            echo "❌ Error executing $(basename "$sql_file")"
            exit 1
        fi
        echo ""
    fi
done

# Execute init.sql if it exists
if [ -f "$SCRIPT_DIR/init.sql" ]; then
    echo "📄 Executing: init.sql (test data)"
    mysql -h "$MYSQL_HOST" -P "$MYSQL_PORT" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DB" < "$SCRIPT_DIR/init.sql"
    if [ $? -eq 0 ]; then
        echo "✅ init.sql completed successfully"
    else
        echo "⚠️  init.sql had issues (may be duplicate data)"
    fi
    echo ""
fi

echo "🎉 Database initialization complete!"
