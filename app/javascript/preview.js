// Script para previsualización de imágenes en formularios (drag & drop y file input)
document.addEventListener('turbo:load', function () {
    const dropArea = document.getElementById('drop-area');
    const fileInput = document.getElementById('blog_attachment') || document.getElementById('solicitud_edicion_attachment');
    const preview = document.getElementById('preview');
    const dropText = document.getElementById('drop-text');

    if (!dropArea || !fileInput || !preview) return;

    dropArea.addEventListener('click', function () {
        fileInput.click();
    });

    dropArea.addEventListener('dragover', function (e) {
        e.preventDefault();
        dropArea.style.background = '#f0f0f0';
    });

    dropArea.addEventListener('dragleave', function (e) {
        e.preventDefault();
        dropArea.style.background = '';
    });

    dropArea.addEventListener('drop', function (e) {
        e.preventDefault();
        dropArea.style.background = '';
        const file = e.dataTransfer.files[0];
        if (file) {
            fileInput.files = e.dataTransfer.files;
            showPreview(file);
        }
    });

    fileInput.addEventListener('change', function (e) {
        const file = e.target.files[0];
        showPreview(file);
    });

    function showPreview(file) {
        if (file && file.type.startsWith('image/')) {
            preview.style.display = 'block';
            preview.src = URL.createObjectURL(file);
        } else {
            preview.style.display = 'none';
        }
    }
});
