// Script para etiquetas dinámicas en formularios de blog y edición
// Corrige: elimina espacios y normaliza etiquetas, separa por espacios, antepone #
document.addEventListener('turbo:load', function () {
    const input = document.getElementById('etiquetas-input');
    const container = document.getElementById('etiquetas-container');
    const hidden = document.getElementById('etiquetas-hidden');
    if (!input || !container || !hidden) return;
    const form = input.closest('form');
    let etiquetas = [];

    // Si hay etiquetas precargadas (para editar)
    if (hidden.value.trim() !== "") {
        etiquetas = hidden.value.trim().split(/\s+/).map(e => e.replace(/^#/, ''));
        renderEtiquetas();
    }

    input.addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            if (input.value.trim() !== "") {
                agregarEtiquetasDesdeInput(input.value.trim());
                input.value = "";
            }
        }
    });

    form.addEventListener('submit', function (e) {
        if (document.activeElement === input && input.value.trim() !== "") {
            e.preventDefault();
            agregarEtiquetasDesdeInput(input.value.trim());
            input.value = "";
        }
    });

    function agregarEtiquetasDesdeInput(texto) {
        // Divide el texto en palabras separadas por espacios
        texto.split(/\s+/).forEach(function (palabra) {
            if (palabra && !etiquetas.includes(palabra)) {
                etiquetas.push(palabra);
            }
        });
        renderEtiquetas();
    }

    function eliminarEtiqueta(etiqueta) {
        etiquetas = etiquetas.filter(e => e !== etiqueta);
        renderEtiquetas();
    }

    function renderEtiquetas() {
        container.innerHTML = '';
        etiquetas.forEach(etiqueta => {
            const tag = document.createElement('span');
            tag.className = 'tag is-info is-medium mr-1 mb-1';
            tag.textContent = '#' + etiqueta;
            // Botón para eliminar etiqueta
            const close = document.createElement('button');
            close.type = 'button';
            close.className = 'delete is-small ml-1';
            close.onclick = () => eliminarEtiqueta(etiqueta);
            tag.appendChild(close);
            container.appendChild(tag);
        });
        // Actualiza el campo oculto
        hidden.value = etiquetas.map(e => '#' + e).join(' ');
    }
});
