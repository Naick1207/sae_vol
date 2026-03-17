import { renderVols } from './views/page/vols.js';
import { renderAeroports } from './views/page/aeroports.js';
import { renderFormVol } from './views/form/nouveauVol.js';
import { renderFormAeroport } from './views/form/nouvelAeroport.js'; 
import { postData, deleteData, putData, getData } from './service/api.js';
import { formToJSON } from './utils.js';

// --- ÉLÉMENTS DOM ---
const contentDiv = document.getElementById('content');
const headerTitle = document.getElementById('header-title');
const headerActions = document.getElementById('header-actions');
const modal = document.getElementById('modal-container');
const modalContent = document.getElementById('modal-content');

// --- CONFIGURATION DU HEADER ---
function setupHeader(title, actions = '') {
    headerTitle.innerHTML = title;
    headerActions.innerHTML = actions;
}

// --- NAVIGATION (ROUTER) ---
async function router() {
    const hash = window.location.hash || '#/';
    
    if (hash === '#/Vols') {
        setupHeader('Vols', '<button class="btn-primary" onclick="showAddVolForm()">+ Nouveau vol</button>');
        contentDiv.innerHTML = await renderVols();
    } 
    else if (hash === '#/Aeroports') {
        setupHeader('Aéroports', '<button class="btn-primary" onclick="showAddAeroportForm()">+ Nouvel Aéroport</button>');
        contentDiv.innerHTML = await renderAeroports();
    } 
    else {
        setupHeader('Accueil');
        contentDiv.innerHTML = '<h1>Bienvenue sur Wilson Compagnie</h1>';
    }
}

// --- GESTION DE LA MODALE (COMMUN) ---
window.closeModal = () => {
    modal.classList.add('hidden');
    modalContent.innerHTML = '';
};

modal.addEventListener('click', (e) => {
    if (e.target === modal) closeModal();
});

// --- LOGIQUE VOLS ---
window.showAddVolForm = () => {
    modalContent.innerHTML = renderFormVol();
    modal.classList.remove('hidden');
};

window.editVol = async (num, comp, date) => {
    const vol = await getData(`/api/Vol/${num}/${comp}/${date}`);
    if (vol) {
        modalContent.innerHTML = renderFormVol(vol);
        modal.classList.remove('hidden');
    }
};

window.removeVol = async (num, comp, date) => {
    if (confirm(`Supprimer le vol ${num} (${comp}) ?`)) {
        const success = await deleteData(`/api/Vol/${num}/${comp}/${date}`);
        if (success) router(); 
    }
};

// --- LOGIQUE AÉROPORTS ---
window.showAddAeroportForm = () => {
    modalContent.innerHTML = renderFormAeroport();
    modal.classList.remove('hidden');
};

window.editAeroport = async (code) => {
    const aero = await getData(`/api/Aeroport/${code}`);
    if (aero) {
        modalContent.innerHTML = renderFormAeroport(aero);
        modal.classList.remove('hidden');
    }
};

window.removeAeroport = async (code) => {
    if (confirm(`Supprimer l'aéroport ${code} ?`)) {
        const success = await deleteData(`/api/Aeroport/${code}`);
        if (success) router();
    }
};

// --- ÉCOUTEUR DE SOUMISSION UNIQUE ---
document.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formId = e.target.id;
    const payload = formToJSON(e.target);
    const isEdit = e.target.querySelector('input[name="is_edit"]'); // Détecte si c'est une modification

    let result = null;

    if (formId === 'form-vol') {
        // Mode PUT (Modif) ou POST (Ajout) pour les Vols
        result = isEdit ? await putData('/api/Vols', payload) : await postData('/api/Vols', payload);
    } 
    else if (formId === 'form-aeroport') {
        // Mode PUT (Modif) ou POST (Ajout) pour les Aéroports
        result = isEdit ? await putData('/api/Aeroports', payload) : await postData('/api/Aeroports', payload);
    }

    if (result) {
        closeModal();
        router();
    } else {
        alert("Erreur lors de l'enregistrement. Vérifiez vos données.");
    }
});

// --- INITIALISATION ---
window.addEventListener('hashchange', router);
window.addEventListener('DOMContentLoaded', router);