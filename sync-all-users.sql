-- Sync all users from auth.users to public.users
INSERT INTO public.users (id, email, full_name, is_admin, created_at)
SELECT 
    id, 
    email, 
    COALESCE(raw_user_meta_data->>'full_name', 'User'),
    LOWER(email) = 'sammyseth260@gmail.com',
    created_at
FROM auth.users
ON CONFLICT (id) DO UPDATE
SET 
    email = EXCLUDED.email,
    is_admin = LOWER(EXCLUDED.email) = 'sammyseth260@gmail.com';

-- Verify all users are synced
SELECT 
    u.id, 
    u.email, 
    u.full_name, 
    u.is_admin,
    CASE WHEN au.id IS NOT NULL THEN 'Synced' ELSE 'Missing in auth' END as status
FROM public.users u
LEFT JOIN auth.users au ON u.id = au.id
ORDER BY u.created_at DESC;
