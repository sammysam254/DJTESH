-- Add user_id to bookings table to link bookings to users
ALTER TABLE bookings 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE SET NULL;

-- Create index
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON bookings(user_id);
