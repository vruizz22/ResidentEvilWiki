// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./channels" 
import "./channels/chat_room_channel"

// Habilita lazy loading para todas las imágenes
document.addEventListener('DOMContentLoaded', function () {
    const images = document.querySelectorAll('img[loading="lazy"]');
    images.forEach(img => {
        img.setAttribute('loading', 'lazy');
    });
});
