// Feed de publicaciones: Me Gusta, Comentar y Ver más usando Fetch (sin recargar la página)

const feed = document.getElementById('feed');
const btnVerMas = document.getElementById('btn-ver-mas');
const finFeed = document.getElementById('fin-feed');
const tplPublicacion = document.getElementById('tpl-publicacion');
const tplComentario = document.getElementById('tpl-comentario');
const token = document.querySelector('input[name="__RequestVerificationToken"]').value;

const urls = {
    meGusta: feed.dataset.urlMegusta,
    comentar: feed.dataset.urlComentar,
    obtenerMas: feed.dataset.urlObtenerMas,
    login: feed.dataset.urlLogin,
    imagenDefault: feed.dataset.imagenDefault
};

// Cantidad de publicaciones ya mostradas = desde dónde pedir las siguientes
let desde = feed.querySelectorAll('.publicacion').length;

// ------------------------------------------------------------ Fetch helpers

/**
 * Procesa la respuesta de Fetch: si la sesión expiró redirige al login,
 * si hubo error lanza una excepción con el mensaje que mandó el servidor.
 */
async function procesarRespuesta(respuesta) {
    const datos = await respuesta.json().catch(() => ({}));

    if (respuesta.status === 401) {
        window.location.href = urls.login;
        throw new Error(datos.error || 'Sesión expirada');
    }
    if (!respuesta.ok) {
        throw new Error(datos.error || 'Ocurrió un error. Intentá de nuevo.');
    }
    return datos;
}

async function enviarPost(url, datos) {
    const respuesta = await fetch(url, {
        method: 'POST',
        headers: { 'RequestVerificationToken': token },
        body: new URLSearchParams(datos) // se envía como application/x-www-form-urlencoded
    });
    return procesarRespuesta(respuesta);
}

async function obtenerJson(url) {
    const respuesta = await fetch(url, { headers: { 'Accept': 'application/json' } });
    return procesarRespuesta(respuesta);
}

// ---------------------------------------------------------- Armado del DOM

function actualizarMeGusta(publicacion, leGusta, cantidad) {
    const boton = publicacion.querySelector('.btn-megusta');
    boton.classList.toggle('activo', leGusta);
    boton.setAttribute('aria-pressed', leGusta);
    boton.textContent = leGusta ? '♥ Ya no me gusta' : '♡ Me gusta';
    publicacion.querySelector('.megusta-cantidad').textContent = cantidad;
}

// Se usa textContent (y no innerHTML) para que el texto de los usuarios no se interprete como HTML
function crearComentario(c) {
    const nodo = tplComentario.content.firstElementChild.cloneNode(true);
    nodo.querySelector('.comentario-usuario').textContent = c.nombreUsuario;
    nodo.querySelector('.comentario-texto').textContent = c.texto;
    nodo.querySelector('.comentario-fecha').textContent = c.fechaFormateada;
    return nodo;
}

function crearPublicacion(p) {
    const nodo = tplPublicacion.content.firstElementChild.cloneNode(true);
    nodo.dataset.id = p.id;

    const imagen = nodo.querySelector('.publicacion-imagen');
    imagen.onerror = () => { imagen.onerror = null; imagen.src = urls.imagenDefault; };
    imagen.src = p.urlImagen;
    imagen.alt = p.titulo;

    nodo.querySelector('.publicacion-usuario').textContent = p.nombreUsuario;
    nodo.querySelector('.publicacion-fecha').textContent = p.fechaFormateada;
    nodo.querySelector('.publicacion-titulo').textContent = p.titulo;
    nodo.querySelector('.publicacion-descripcion').textContent = p.descripcion;
    actualizarMeGusta(nodo, p.usuarioDioMeGusta, p.cantidadMeGusta);

    const lista = nodo.querySelector('.lista-comentarios');
    p.comentarios.forEach(c => lista.appendChild(crearComentario(c)));

    return nodo;
}

// ---------------------------------------------------------------- Me Gusta

async function alternarMeGusta(publicacion) {
    const boton = publicacion.querySelector('.btn-megusta');
    boton.disabled = true; // evita dobles clics mientras espera la respuesta

    try {
        const datos = await enviarPost(urls.meGusta, { idPublicacion: publicacion.dataset.id });
        actualizarMeGusta(publicacion, datos.leGusta, datos.cantidad);
    } catch (error) {
        alert(error.message);
    } finally {
        boton.disabled = false;
    }
}

// ---------------------------------------------------------------- Comentar

async function comentar(publicacion, form) {
    const input = form.elements.texto;
    const boton = form.querySelector('button[type="submit"]');
    const divError = form.querySelector('.error-comentario');
    const texto = input.value.trim();

    divError.hidden = true;
    if (texto === '') {
        divError.textContent = 'El comentario no puede estar vacío.';
        divError.hidden = false;
        return;
    }

    boton.disabled = true;
    try {
        const comentario = await enviarPost(urls.comentar, {
            idPublicacion: publicacion.dataset.id,
            texto: texto
        });
        publicacion.querySelector('.lista-comentarios').appendChild(crearComentario(comentario));
        input.value = '';
    } catch (error) {
        divError.textContent = error.message;
        divError.hidden = false;
    } finally {
        boton.disabled = false;
        input.focus();
    }
}

// ---------------------------------------------------------------- Ver más

async function verMas() {
    btnVerMas.disabled = true;
    btnVerMas.textContent = 'Cargando...';

    try {
        const datos = await obtenerJson(`${urls.obtenerMas}?desde=${desde}`);

        datos.publicaciones.forEach(p => {
            // Si alguien publicó mientras tanto, el OFFSET se corre: evitamos mostrar duplicados
            if (!feed.querySelector(`.publicacion[data-id="${p.id}"]`)) {
                feed.appendChild(crearPublicacion(p));
            }
        });
        desde += datos.publicaciones.length;

        if (!datos.hayMas) {
            btnVerMas.hidden = true;
            finFeed.hidden = false;
        }
    } catch (error) {
        alert(error.message);
    } finally {
        btnVerMas.disabled = false;
        btnVerMas.textContent = 'Ver más';
    }
}

// ----------------------------------------------------------------- Eventos

// Delegación de eventos: un solo listener en #feed sirve también para
// las publicaciones que se agregan después con "Ver más".
feed.addEventListener('click', (e) => {
    const boton = e.target.closest('.btn-megusta');
    if (boton) {
        alternarMeGusta(boton.closest('.publicacion'));
    }
});

feed.addEventListener('submit', (e) => {
    const form = e.target.closest('.form-comentario');
    if (form) {
        e.preventDefault();
        comentar(form.closest('.publicacion'), form);
    }
});

btnVerMas.addEventListener('click', verMas);
