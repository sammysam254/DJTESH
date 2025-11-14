# DJ Tesh Website - Authentication & Admin Panel Setup

## Features Implemented

✅ User Signup & Login System
✅ Admin Panel for sammyseth260@gmail.com
✅ Booking Management
✅ User Management
✅ Statistics Dashboard

## Database Setup

### Step 1: Run SQL Commands in Supabase

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Copy and paste the contents of `database-setup.sql`
4. Click **Run** to execute the SQL commands

This will create:
- `users` table for storing user accounts
- Add `status` column to existing `bookings` table
- Set up Row Level Security (RLS) policies
- Create necessary indexes

### Step 2: Enable Email Authentication

1. In Supabase Dashboard, go to **Authentication** → **Providers**
2. Make sure **Email** provider is enabled
3. Configure email templates if needed (optional)

## How It Works

### User Signup
- Users can create accounts at `auth.html`
- When sammyseth260@gmail.com signs up, they automatically get admin privileges
- Other users get regular user access

### User Login
- Users login at `auth.html`
- After login:
  - Admin users (sammyseth260@gmail.com) → redirected to `admin.html`
  - Regular users → redirected to `index.html`

### Admin Panel Features

The admin panel (`admin.html`) includes:

1. **Bookings Tab**
   - View all booking requests
   - See booking statistics (total, pending, confirmed)
   - Confirm bookings
   - Delete bookings
   - View customer details and messages

2. **Users Tab**
   - View all registered users
   - See user roles (Admin/User)
   - Track registration dates

3. **Statistics Tab**
   - Bookings this month
   - Upcoming events
   - New users this month

## File Structure

```
├── index.html              # Main website
├── auth.html              # Login/Signup page
├── admin.html             # Admin panel (admin only)
├── styles.css             # Main styles
├── auth-styles.css        # Auth & admin styles
├── script.js              # Main JavaScript
├── database-setup.sql     # Database setup SQL
└── SETUP-INSTRUCTIONS.md  # This file
```

## Testing

1. **Create Admin Account**
   - Go to `auth.html`
   - Click "Sign Up"
   - Use email: sammyseth260@gmail.com
   - Create a password
   - You'll be redirected to the admin panel

2. **Create Regular User**
   - Sign up with any other email
   - You'll be redirected to the main website

3. **Test Admin Features**
   - Login as admin
   - View bookings from the contact form
   - Manage users
   - View statistics

## Security Notes

- Row Level Security (RLS) is enabled on all tables
- Only admins can view/modify bookings
- Only admins can view all users
- Users can only view their own data
- Passwords are securely hashed by Supabase Auth

## Troubleshooting

### "Error creating account"
- Make sure you've run the SQL setup commands
- Check that email authentication is enabled in Supabase

### "Access denied" when accessing admin panel
- Make sure you're logged in with sammyseth260@gmail.com
- Check that the user has `is_admin = TRUE` in the database

### Bookings not showing in admin panel
- Make sure RLS policies are set up correctly
- Check browser console for errors
- Verify Supabase credentials in the code

## Next Steps

- Customize email templates in Supabase
- Add password reset functionality
- Add email notifications for new bookings
- Add more admin features as needed
