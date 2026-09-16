document.addEventListener('DOMContentLoaded', () => {
    const navItems = document.querySelectorAll('.md-nav__item--nested');
    navItems.forEach(item => {
        const toggle = item.querySelector('.md-nav__toggle');
        if (toggle && !item.classList.contains('md-nav__item--active')) {
            toggle.checked = false;
        }
    });
});
