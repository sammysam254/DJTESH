-- SIMPLE DATABASE SETUP
-- Run each section separately in Supabase SQL Editor

-- ============================================
-- SECTION 1: Create users table
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- SECTION 2: Update bookings table
-- ============================================
ALTER TABLE bookings 
ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'pending';

-- ============================================
-- SECTION 3: Enable RLS (Row Level Security)
-- ============================================
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

-- ============================================
-- SECTION 4: Policies for USERS table
-- ============================================

-- Drop old policies if they exist
DROP POLICY IF EXISTS "Users can view own data" ON users;
DROP POLICY IF EXISTS "Admins can view all users" ON users;
DROP POLICY IF EXISTS "Users can insert own data" ON users;

-- Allow users to view their own data
CREATE POLICY "Users can view own data" ON users
    FOR SELECT
    USING (auth.uid() = id);

-- Allow admins to view all users
CREATE POLICY "Admins can view all users" ON users
    FOR SELECT
    USING (is_admin = TRUE AND auth.uid() = id);

-- Allow new users to insert their data during signup
CREATE POLICY "Users can insert own data" ON users
    FOR INSERT
    WITH CHECK (auth.uid() = id);

-- ============================================
-- SECTION 5: Policies for BOOKINGS table
-- ============================================

-- Drop old policies if they exist
DROP POLICY IF EXISTS "Anyone can create bookings" ON bookings;
DROP POLICY IF EXISTS "Public can create bookings" ON bookings;

-- Allow anyone to create bookings (for contact form)
CREATE POLICY "Public can create bookings" ON bookings
    FOR INSERT
    TO public
    WITH CHECK (TRUE);

-- ============================================
-- SECTION 6: Create indexes
-- ============================================
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_is_admin ON users(is_admin);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);
