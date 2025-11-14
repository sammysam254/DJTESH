-- Create services table for dynamic service management
CREATE TABLE IF NOT EXISTS services (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    icon TEXT NOT NULL,
    description TEXT NOT NULL,
    whatsapp_message TEXT,
    display_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Disable RLS for now
ALTER TABLE services DISABLE ROW LEVEL SECURITY;

-- Insert existing services
INSERT INTO services (title, icon, description, whatsapp_message, display_order) VALUES
('Weddings', '💍', 'Complete DJ services for your wedding reception, including music for cocktail hour, dinner, and dancing.', 'Hi DJ Tesh! I''m interested in booking your services for a Wedding. Can we discuss the details?', 1),
('Birthday Parties', '🎉', 'Make your birthday celebration unforgettable with energetic music and entertainment for all ages.', 'Hi DJ Tesh! I''m interested in booking your services for a Birthday Party. Can we discuss the details?', 2),
('Pool Parties', '🏊', 'Bring the summer vibes with the perfect poolside soundtrack and high-energy entertainment.', 'Hi DJ Tesh! I''m interested in booking your services for a Pool Party. Can we discuss the details?', 3),
('Graduations', '🎓', 'Celebrate your academic achievements with music that keeps the party going all night long.', 'Hi DJ Tesh! I''m interested in booking your services for a Graduation. Can we discuss the details?', 4),
('Ruracio', '🎊', 'Traditional Kenyan engagement ceremonies with culturally appropriate music and professional MC services.', 'Hi DJ Tesh! I''m interested in booking your services for a Ruracio. Can we discuss the details?', 5),
('MC Services', '🎤', 'Professional master of ceremonies to guide your guests through the evening''s events seamlessly.', 'Hi DJ Tesh! I''m interested in booking your MC Services. Can we discuss the details?', 6),
('Premium Sound System', '🔊', 'High-quality sound equipment ensuring crystal clear audio for every moment of your celebration.', 'Hi DJ Tesh! I''m interested in renting your Premium Sound System. Can we discuss the details?', 7),
('Lighting Effects', '💡', 'Professional lighting to create the perfect ambiance and transform your venue.', 'Hi DJ Tesh! I''m interested in booking your Lighting Effects. Can we discuss the details?', 8),
('Custom Playlists', '📋', 'Personalized music selection based on your preferences and special requests.', 'Hi DJ Tesh! I''m interested in your Custom Playlist service. Can we discuss the details?', 9);

-- Create index
CREATE INDEX IF NOT EXISTS idx_services_active ON services(is_active);
CREATE INDEX IF NOT EXISTS idx_services_order ON services(display_order);
