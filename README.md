# DJ Tesh - Professional DJ Services Website

A modern, responsive website for DJ Tesh showcasing professional DJ services for weddings, birthday parties, pool parties, graduations, and more.

## Features

- **Responsive Design** - Works perfectly on desktop, tablet, and mobile devices
- **Service Showcase** - 9 different services with direct WhatsApp booking
- **Contact Form** - Integrated with Supabase for storing inquiries
- **Gallery Section** - Display event photos
- **Blue Theme** - Professional and modern color scheme

## Technologies Used

- HTML5
- CSS3
- JavaScript
- Supabase (Backend & Database)

## Supabase Setup

### Database Table Required

Create a table named `bookings` in your Supabase project with the following columns:

```sql
CREATE TABLE bookings (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  event_date DATE,
  message TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;

-- Create policy to allow inserts from anyone
CREATE POLICY "Allow public inserts" ON bookings
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Create policy to allow authenticated users to view all bookings
CREATE POLICY "Allow authenticated reads" ON bookings
  FOR SELECT
  TO authenticated
  USING (true);
```

## Services Offered

1. **Weddings** - Complete DJ services for wedding receptions
2. **Birthday Parties** - Energetic music and entertainment
3. **Pool Parties** - Perfect poolside soundtrack
4. **Graduations** - Celebration music
5. **Ruracio** - Traditional Kenyan engagement ceremonies
6. **MC Services** - Professional master of ceremonies
7. **Premium Sound System** - High-quality audio equipment
8. **Lighting Effects** - Professional venue lighting
9. **Custom Playlists** - Personalized music selection

## Contact

- **Phone/WhatsApp:** 0759015501
- **Email:** mosesmutethia003@gmail.com
- **Facebook:** [DJ Tesh](https://www.facebook.com/moses.mutethia.969)

## License

© 2024 DJ Tesh. All rights reserved.
