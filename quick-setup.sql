-- QUICK SETUP - Run this all at once
-- This will get your authentication working immediately

-- 1. Create users table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Add status to bookings
ALTER TABLE bookings 
ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'pending';

-- 3. Disable RLS on bookings (so admin can access)
ALTER TABLE bookings DISABLE ROW LEVEL SECURITY;

-- 4. Enable RLS only on users table
ALTER TABLE users ENABLE ROW LEVEL SECURITY;

-- 5. Simple policy for users
DROP POLICY IF EXISTS "Enable all access for authenticated users" ON users;
CREATE POLICY "Enable all access for authenticated users" ON users
    FOR ALL
    TO authenticated
    USING (TRUE)
    WITH CHECK (TRUE);

-- Done! Now you can signup and use the admin panel
