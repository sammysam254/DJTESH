-- Drop and recreate users table to fix schema cache issue

-- Drop the table if it exists
DROP TABLE IF EXISTS users CASCADE;

-- Create users table with all columns
CREATE TABLE users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Disable RLS for now
ALTER TABLE users DISABLE ROW LEVEL SECURITY;

-- Create index on email
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_is_admin ON users(is_admin);
