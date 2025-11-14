-- Create storage buckets for images
-- Run this in Supabase SQL Editor

-- Create hero images table
CREATE TABLE IF NOT EXISTS hero_images (
    id SERIAL PRIMARY KEY,
    image_url TEXT NOT NULL,
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Disable RLS for now
ALTER TABLE hero_images DISABLE ROW LEVEL SECURITY;

-- Add image_url column to services table
ALTER TABLE services 
ADD COLUMN IF NOT EXISTS image_url TEXT;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_hero_images_active ON hero_images(is_active);
CREATE INDEX IF NOT EXISTS idx_hero_images_order ON hero_images(display_order);

-- Note: You also need to create storage buckets in Supabase Dashboard:
-- 1. Go to Storage in Supabase Dashboard
-- 2. Create a bucket called "hero-images" (make it public)
-- 3. Create a bucket called "service-images" (make it public)
