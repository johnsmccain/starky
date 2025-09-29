@echo off
echo Setting up Starky database...
echo.

REM Check if PostgreSQL is running
echo Checking PostgreSQL service...
sc query "postgresql-x64-18" | find "RUNNING" >nul
if %errorlevel%==0 (
    echo PostgreSQL service is running.
) else (
    echo PostgreSQL service is not running.
    echo Please start PostgreSQL service as administrator:
    echo net start postgresql-x64-18
    echo.
    echo Or use Services.msc to start "postgresql-x64-18"
    pause
    exit /b 1
)

echo.
echo Creating database and user...
echo You may be prompted for the postgres user password.
echo.

REM Run the setup script
"C:\Program Files\PostgreSQL\18\bin\psql.exe" -U postgres -f setup-db.sql

if %errorlevel%==0 (
    echo.
    echo ✅ Database setup completed successfully!
    echo.
    echo Database: starky_db
    echo User: starky_user
    echo Password: starky123
    echo.
    echo You can now run: npm run dev
) else (
    echo.
    echo ❌ Database setup failed. Please check the error messages above.
    echo.
    echo Common issues:
    echo - PostgreSQL service not running
    echo - Incorrect postgres user password
    echo - User already exists (this is usually OK)
)

echo.
pause