-- Starky Database Setup Script
-- Run this script as the postgres superuser

-- Create the user
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'starky_user') THEN
        CREATE USER starky_user WITH PASSWORD 'starky123';
    END IF;
END
$$;

-- Create the database
SELECT 'CREATE DATABASE starky_db OWNER starky_user'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'starky_db')\gexec

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE starky_db TO starky_user;

-- Connect to the new database and set up permissions
\c starky_db;
GRANT ALL ON SCHEMA public TO starky_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO starky_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO starky_user;

-- Show confirmation
SELECT 'Database setup completed successfully!' as status;