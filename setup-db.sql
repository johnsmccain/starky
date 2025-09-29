-- Starky Database Setup Script
-- Run this script to set up the database for Starky

-- Create user
CREATE USER starky_user WITH PASSWORD 'starky123';

-- Create database
CREATE DATABASE starky_db OWNER starky_user;

-- Connect to the new database
\c starky_db;

-- Grant all privileges to the user
GRANT ALL PRIVILEGES ON DATABASE starky_db TO starky_user;
GRANT ALL PRIVILEGES ON SCHEMA public TO starky_user;

-- Show confirmation
SELECT 'Database starky_db created successfully!' as status;