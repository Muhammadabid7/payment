
// Global Variables
const ANIMATION_DURATION = 1000;
const TOAST_DURATION = 3000;

// DOM Elements
const loading = document.getElementById('loading');
const toast = document.getElementById('toast');
const paymentMethods = document.querySelectorAll('.payment-method');

// Loading Screen Handler
window.addEventListener('load', () => {
    setTimeout(() => {
        loading.classList.add('hide');
        initializePaymentMethods();
    }, ANIMATION_DURATION);
});

// Initialize Payment Methods with Staggered Animation
function initializePaymentMethods() {
    paymentMethods.forEach((method, index) => {
        setTimeout(() => {
            method.style.opacity = '1';
            method.style.transform = 'translateY(0)';
        }, 200 * index);
    });
}

// Enhanced Copy to Clipboard Function
async function copyToClipboard(text) {
    try {
        if (!navigator.clipboard) {
            fallbackCopyToClipboard(text);
            return;
        }
        
        await navigator.clipboard.writeText(text);
        showToast('Successfully copied to clipboard!', 'success');
        
        // Animate the copy button
        const button = event.currentTarget;
        button.classList.add('copying');
        setTimeout(() => button.classList.remove('copying'), 1000);
        
    } catch (err) {
        console.error('Failed to copy:', err);
        showToast('Failed to copy. Please try again.', 'error');
    }
}

// Fallback Copy Method
function fallbackCopyToClipboard(text) {
    const textArea = document.createElement('textarea');
    textArea.value = text;
    textArea.style.position = 'fixed';
    textArea.style.left = '-9999px';
    document.body.appendChild(textArea);
    
    try {
        textArea.select();
        document.execCommand('copy');
        showToast('Successfully copied to clipboard!', 'success');
    } catch (err) {
        console.error('Fallback copy failed:', err);
        showToast('Failed to copy. Please try again.', 'error');
    }
    
    document.body.removeChild(textArea);
}

// Enhanced Toast Notification System
function showToast(message, type = 'success') {
    const toast = document.getElementById('toast');
    const icon = toast.querySelector('i');
    const messageSpan = toast.querySelector('span');
    
    // Update toast content
    messageSpan.textContent = message;
    
    // Update toast style based on type
    toast.className = `toast ${type}`;
    icon.className = type === 'success' ? 'fas fa-check-circle' : 'fas fa-times-circle';
    
    // Show toast with animation
    toast.classList.add('show');
    
    // Hide toast after duration
    setTimeout(() => {
        toast.classList.remove('show');
    }, TOAST_DURATION);
}

// Payment Method Hover Effects
paymentMethods.forEach(method => {
    method.addEventListener('mouseenter', () => {
        method.style.transform = 'translateY(-10px) scale(1.02)';
        method.style.boxShadow = '0 20px 40px rgba(0, 0, 0, 0.4), 0 0 30px rgba(0, 255, 242, 0.3)';
    });
    
    method.addEventListener('mouseleave', () => {
        method.style.transform = 'translateY(0) scale(1)';
        method.style.boxShadow = 'var(--neon-blue)';
    });
});

// Intersection Observer for Scroll Animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '20px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            observer.unobserve(entry.target);
        }
    });
}, observerOptions);

// Observe all animated elements
document.querySelectorAll('.payment-method, .contact-section').forEach(el => {
    observer.observe(el);
});

// Particle Effect System
class ParticleEffect {
    constructor() {
        this.particles = [];
        this.mouseX = 0;
        this.mouseY = 0;
        
        this.initializeParticles();
        this.attachEventListeners();
        this.animate();
    }
    
    initializeParticles() {
        // Initialize particle system
        for (let i = 0; i < 50; i++) {
            this.particles.push({
                x: Math.random() * window.innerWidth,
                y: Math.random() * window.innerHeight,
                size: Math.random() * 3,
                speedX: Math.random() * 2 - 1,
                speedY: Math.random() * 2 - 1
            });
        }
    }
    
    attachEventListeners() {
        document.addEventListener('mousemove', (e) => {
            this.mouseX = e.clientX;
            this.mouseY = e.clientY;
        });
    }
    
    animate() {
        requestAnimationFrame(() => this.animate());
        this.updateParticles();
    }
    
    updateParticles() {
        this.particles.forEach(particle => {
            particle.x += particle.speedX;
            particle.y += particle.speedY;
            
            // Wrap particles around screen
            if (particle.x > window.innerWidth) particle.x = 0;
            if (particle.x < 0) particle.x = window.innerWidth;
            if (particle.y > window.innerHeight) particle.y = 0;
            if (particle.y < 0) particle.y = window.innerHeight;
        });
    }
}

// Initialize particle effect
const particleEffect = new ParticleEffect();

// Error Handler
window.onerror = function(msg, url, lineNo, columnNo, error) {
    console.error('Error: ' + msg + '\nURL: ' + url + '\nLine: ' + lineNo + '\nColumn: ' + columnNo + '\nError object: ' + JSON.stringify(error));
    return false;
};

// Performance Optimization
document.addEventListener('DOMContentLoaded', () => {
    // Preload images
    const images = document.querySelectorAll('img[data-src]');
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    img.src = img.dataset.src;
                    img.removeAttribute('data-src');
                    imageObserver.unobserve(img);
                }
            });
        });
        
        images.forEach(img => imageObserver.observe(img));
    }
});

// Add smooth scrolling
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function(e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});