-- STEP 1: Create users table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT UNIQUE NOT NULL,
    full_name TEXT NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);


-- STEP 2: Add status column to bookings table
ALTER TABLE bookings 
ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'pending';

-- STEP 3: Enable Row Level Security
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

-- STEP 4: Drop existing policies if they exist (ignore errors if they don't exist)
DROP POLICY IF EXISTS "Users can view own data" ON users;
DROP POLICY IF EXISTS "Admins can view all users" ON users;
DROP POLICY IF EXISTS "Users can insert own data" ON users;
DROP POLICY IF EXISTS "Anyone can create bookings" ON bookings;
DROP POLICY IF EXISTS "Admins can view all bookings" ON bookings;
DROP POLICY IF EXISTS "Admins can update bookings" ON bookings;
DROP POLICY IF EXISTS "Admins can delete bookings" ON bookings;

-- STEP 5: Create policies for users table
CREATE POLICY "Users can view own data" ON users
    FOR SELECT
    USING (auth.uid() = id);

CREATE POLICY "Admins can view all users" ON users
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM users
            WHERE users.id = auth.uid() AND users.is_admin = TRUE
        )
    );

CREATE POLICY "Users can insert own data" ON users
    FOR INSERT
    WITH CHECK (auth.uid() = id);

-- STEP 6: Create policies for bookings table
CREATE POLICY "Anyone can create bookings" ON bookings
    FOR INSERT
    WITH CHECK (TRUE);

CREATE POLICY "Admins can view all bookings" ON bookings
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM users
            WHERE users.id = auth.uid() AND users.is_admin = TRUE
        )
    );

CREATE POLICY "Admins can update bookings" ON bookings
    FOR UPDATE
    USING (
        EXISTS (
            SELECT 1 FROM users
            WHERE users.id = auth.uid() AND users.is_admin = TRUE
        )
    );

CREATE POLICY "Admins can delete bookings" ON bookings
    FOR DELETE
    USING (
        EXISTS (
            SELECT 1 FROM users
            WHERE users.id = auth.uid() AND users.is_admin = TRUE
        )
    );

-- STEP 7: Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_is_admin ON users(is_admin);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);
CREATE INDEX IF NOT EXISTS idx_bookings_created_at ON bookings(created_at);
CREATE INDEX IF NOT EXISTS idx_bookings_event_date ON bookings(event_date);
