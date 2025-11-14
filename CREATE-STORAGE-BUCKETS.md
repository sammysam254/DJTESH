# CRITICAL: Create Storage Buckets First!

The "Failed to fetch" error means the storage buckets don't exist yet.

## Step-by-Step Instructions:

### 1. Go to Supabase Dashboard
- Open your Supabase project dashboard
- URL: https://supabase.com/dashboard/project/YOUR_PROJECT_ID

### 2. Navigate to Storage
- Click **"Storage"** in the left sidebar menu
- You should see a page with "Create a new bucket" button

### 3. Create Hero Images Bucket
- Click **"New bucket"** button
- Enter bucket name: `hero-images` (exactly as written, no spaces)
- **IMPORTANT**: Toggle **"Public bucket"** to ON (green)
- Click **"Create bucket"**

### 4. Create Service Images Bucket
- Click **"New bucket"** button again
- Enter bucket name: `service-images` (exactly as written, no spaces)
- **IMPORTANT**: Toggle **"Public bucket"** to ON (green)
- Click **"Create bucket"**

### 5. Verify Buckets Are Public
- Click on `hero-images` bucket
- Look for "Public" badge or indicator
- If not public, click settings and enable "Public bucket"
- Repeat for `service-images` bucket

### 6. Set Bucket Policies (Optional but Recommended)
For each bucket:
- Click on the bucket name
- Go to "Policies" tab
- Add policy: "Allow public read access"
- Add policy: "Allow authenticated users to upload"

### 7. Test Upload
- Go to your admin panel
- Navigate to "Hero Images" tab
- Try uploading an image
- Should work now!

## Troubleshooting:

### Still getting "Failed to fetch"?
1. **Check bucket names are exact**: `hero-images` and `service-images`
2. **Verify buckets are PUBLIC**: Look for public badge
3. **Check your internet connection**
4. **Try refreshing the page**
5. **Check browser console** (F12) for detailed error

### "Storage API not available"?
- Your Supabase project might not have storage enabled
- Contact Supabase support or check project settings

### "Bucket not found"?
- Bucket name is wrong or bucket doesn't exist
- Go back to step 3 and create the buckets

## Quick Check:
After creating buckets, you should see them listed in Storage:
- ✅ hero-images (Public)
- ✅ service-images (Public)

If you see both with "Public" badge, you're ready to upload!
