
  window.addEventListener('scroll', function() {
    const logo = document.getElementById('logo');
    const imageSection = document.getElementById('image-section');
    
    if (window.scrollY > 50) {
        document.body.classList.add('scrolled');
    } else {
        document.body.classList.remove('scrolled');
    }

    if (window.scrollY > 100) {
        imageSection.classList.add('scrolled');
    } else {
        imageSection.classList.remove('scrolled');
    }
});

gsap.from("h1", { opacity: 0, y: -50, duration: 1.5 });
gsap.from("button", { opacity: 0, scale: 0.8, duration: 1, delay: 0.5 });

