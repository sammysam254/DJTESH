-- Set sammyseth260@gmail.com as admin
UPDATE users 
SET is_admin = TRUE 
WHERE email = 'sammyseth260@gmail.com';

-- Verify the admin status
SELECT id, email, full_name, is_admin, created_at 
FROM users 
WHERE email = 'sammyseth260@gmail.com';
