// Mobile Navigation Toggle
const hamburger = document.querySelector('.hamburger');
const navMenu = document.querySelector('.nav-menu');

hamburger.addEventListener('click', () => {
    navMenu.classList.toggle('active');
    hamburger.classList.toggle('active');
});

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-menu a').forEach(link => {
    link.addEventListener('click', () => {
        navMenu.classList.remove('active');
        hamburger.classList.remove('active');
    });
});

// Smooth scrolling for navigation links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Navbar background on scroll
window.addEventListener('scroll', () => {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 100) {
        navbar.style.background = 'rgba(26, 26, 26, 1)';
    } else {
        navbar.style.background = 'rgba(26, 26, 26, 0.95)';
    }
});

// Initialize Supabase
const SUPABASE_URL = 'https://tdvrxgvtxletskcgdiaq.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRkdnJ4Z3Z0eGxldHNrY2dkaWFxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA4NTIzMzcsImV4cCI6MjA3NjQyODMzN30.6yhnA5cX_UyXk6u_ypAxap9HKymTZsnqThmItZP5FuE';

const supabase = window.supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

// Form submission handler
const contactForm = document.querySelector('.contact-form');
contactForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    // Get form data
    const formData = new FormData(contactForm);
    const name = formData.get('name');
    const email = formData.get('email');
    const phone = formData.get('phone');
    const eventDate = formData.get('event_date');
    const message = formData.get('message');
    
    // Show loading state
    const submitBtn = contactForm.querySelector('button[type="submit"]');
    const originalText = submitBtn.textContent;
    submitBtn.textContent = 'Sending...';
    submitBtn.disabled = true;
    
    try {
        // Get current user session
        const { data: { session } } = await supabase.auth.getSession();
        
        // Insert data into Supabase
        const { data, error} = await supabase
            .from('bookings')
            .insert([
                {
                    name: name,
                    email: email,
                    phone: phone,
                    event_date: eventDate,
                    message: message,
                    user_id: session?.user?.id || null,
                    created_at: new Date().toISOString()
                }
            ]);
        
        if (error) throw error;
        
        // Success message
        alert('Thank you for your inquiry! DJ Tesh will get back to you soon.');
        contactForm.reset();
        
    } catch (error) {
        console.error('Error submitting form:', error);
        alert('There was an error submitting your request. Please try contacting us via WhatsApp.');
    } finally {
        // Reset button
        submitBtn.textContent = originalText;
        submitBtn.disabled = false;
    }
});

// Intersection Observer for fade-in animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -100px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe service cards and gallery items
document.querySelectorAll('.service-card, .gallery-item').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
    observer.observe(el);
});

// Check if user is logged in and show admin link if admin
async function checkUserAuth() {
    const { data: { session } } = await supabase.auth.getSession();
    
    const navAuth = document.querySelector('.nav-auth');
    const navAdmin = document.querySelector('.nav-admin');
    const navBookings = document.querySelector('.nav-bookings');
    
    if (session) {
        // User is logged in
        navAuth.textContent = 'Logout';
        navAuth.href = '#';
        navAuth.addEventListener('click', async (e) => {
            e.preventDefault();
            await supabase.auth.signOut();
            window.location.reload();
        });
        
        // Show My Bookings for all logged-in users
        navBookings.style.display = 'block';
        
        // Check if user is admin
        const { data: userData } = await supabase
            .from('users')
            .select('is_admin')
            .eq('id', session.user.id)
            .limit(1);
        
        if (userData && userData.length > 0 && userData[0].is_admin) {
            navAdmin.style.display = 'block';
        }
    }
}

// Run auth check on page load
checkUserAuth();

// Hero Slideshow
let currentSlide = 0;
let heroImages = [];

async function loadHeroSlideshow() {
    try {
        const { data, error } = await supabase
            .from('hero_images')
            .select('*')
            .eq('is_active', true)
            .order('display_order', { ascending: true });

        if (error) throw error;

        if (data && data.length > 0) {
            heroImages = data;
            const slideshow = document.getElementById('hero-slideshow');
            
            // Create slide elements
            heroImages.forEach((image, index) => {
                const slide = document.createElement('div');
                slide.className = 'hero-slide';
                slide.style.backgroundImage = `url(${image.image_url})`;
                if (index === 0) slide.classList.add('active');
                slideshow.appendChild(slide);
            });

            // Start slideshow if more than one image
            if (heroImages.length > 1) {
                setInterval(nextSlide, 5000);
            }
        }
    } catch (error) {
        console.error('Error loading hero slideshow:', error);
    }
}

function nextSlide() {
    const slides = document.querySelectorAll('.hero-slide');
    if (slides.length === 0) return;

    slides[currentSlide].classList.remove('active');
    currentSlide = (currentSlide + 1) % slides.length;
    slides[currentSlide].classList.add('active');
}

// Load hero slideshow on page load
loadHeroSlideshow();
