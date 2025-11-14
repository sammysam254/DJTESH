# Supabase Storage Setup Guide

## Step 1: Create Storage Buckets

1. Go to your Supabase Dashboard
2. Navigate to **Storage** in the left sidebar
3. Click **"New bucket"**

### Create Hero Images Bucket:
- **Name**: `hero-images`
- **Public bucket**: ✅ **Enable** (check this box)
- Click **"Create bucket"**

### Create Service Images Bucket:
- **Name**: `service-images`
- **Public bucket**: ✅ **Enable** (check this box)
- Click **"Create bucket"**

## Step 2: Run Database Setup

Run `setup-storage.sql` in Supabase SQL Editor to create the necessary tables.

## Step 3: Test Upload

1. Go to your admin panel at `admin.html`
2. Click on **"Hero Images"** tab
3. Click **"Upload Hero Image"**
4. Select an image from your computer
5. The image should upload and appear in the grid

## Features

### Hero Images:
- Upload images that will slide in the hero section
- Images change every 5 seconds automatically
- Delete images you don't want anymore
- Images are stored in Supabase Storage

### Service Images (Coming Soon):
- When adding/editing services, you can optionally upload an image
- Images will display alongside the service icon
- Makes services more visually appealing

## Troubleshooting

### "Error uploading image"
- Make sure the buckets are created and set to **public**
- Check that bucket names match exactly: `hero-images` and `service-images`
- Verify you're logged in as admin

### Images not showing
- Check browser console for errors
- Verify the bucket is public
- Make sure the image was uploaded successfully in Storage dashboard

### Upload button not working
- Check that you ran `setup-storage.sql`
- Verify the `hero_images` table exists
- Check browser console for JavaScript errors
