-- Check all users in auth.users
SELECT id, email, created_at 
FROM auth.users;

-- Check all users in public.users
SELECT id, email, full_name, is_admin, created_at 
FROM public.users;

-- If sammyseth260@gmail.com exists in auth.users but not in public.users, 
-- manually insert it (replace YOUR_USER_ID with the actual id from auth.users)
-- INSERT INTO public.users (id, email, full_name, is_admin, created_at)
-- SELECT id, email, COALESCE(raw_user_meta_data->>'full_name', 'Admin'), TRUE, created_at
-- FROM auth.users
-- WHERE email = 'sammyseth260@gmail.com'
-- ON CONFLICT (id) DO UPDATE
-- SET is_admin = TRUE;
