// Script para el menú hamburguesa de la navbar (Bulma)
document.addEventListener("turbo:load", navbarBurger);
function navbarBurger() {
    const burger = document.querySelector(".navbar-burger");
    if (!burger) return;
    const menu = document.getElementById(burger.dataset.target);
    // Elimina listeners previos para evitar duplicados
    burger.replaceWith(burger.cloneNode(true));
    const newBurger = document.querySelector(".navbar-burger");
    newBurger.addEventListener("click", () => {
        newBurger.classList.toggle("is-active");
        menu.classList.toggle("is-active");
    });
}
