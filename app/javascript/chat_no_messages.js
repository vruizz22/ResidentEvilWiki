// Oculta el mensaje "No hay mensajes aún" cuando se recibe el primer mensaje en el chat
// Funciona en la vista chat_rooms/show.html.erb

document.addEventListener("turbo:load", function () {
    const messagesContainer = document.querySelector(".messages");
    const noMsg = document.getElementById("no-messages-msg");
    if (!messagesContainer || !noMsg) return;
    const observer = new MutationObserver(function () {
        if (messagesContainer.children.length > 1) {
            noMsg.style.display = "none";
        }
    });
    observer.observe(messagesContainer, { childList: true });
});
