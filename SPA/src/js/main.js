import { renderVols } from './views/page/vols.js';
import { renderAeroports } from './views/page/aeroports.js';
import { renderFormVol } from './views/form/nouveauVol.js';
import { postData, deleteData, putData, getData } from './service/api.js';
import { formToJSON } from './utils.js';

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
        setupHeader('Vols', '<button class="btn-primary" onclick="showAddForm()">+ Nouveau vol</button>');
        contentDiv.innerHTML = await renderVols();
    } else if (hash === '#/Aeroports') {
        setupHeader('Aéroports', '<button class="btn-primary">+ Ajouter</button>');
        contentDiv.innerHTML = await renderAeroports();
    } else {
        setupHeader('Accueil');
        contentDiv.innerHTML = '<h1>Bienvenue sur Wilson Compagnie</h1>';
    }
}

// --- GESTION DE LA MODALE ---

// Ouvrir pour un NOUVEAU vol
window.showAddForm = () => {
    modalContent.innerHTML = renderFormVol(); // Appelle le form vide
    modal.classList.remove('hidden');
};

// Ouvrir pour MODIFIER un vol existant
window.editVol = async (num, comp, date) => {
    // 1. On récupère les données actuelles du vol via l'API
    const vol = await getData(`/api/Vol/${num}/${comp}/${date}`);
    if (vol) {
        // 2. On affiche le form en lui passant les données du vol
        modalContent.innerHTML = renderFormVol(vol);
        modal.classList.remove('hidden');
    }
};

window.closeModal = () => {
    modal.classList.add('hidden');
    modalContent.innerHTML = '';
};

// Fermer au clic sur le flou autour de la modale
modal.addEventListener('click', (e) => {
    if (e.target === modal) closeModal();
});

// --- ACTIONS CRUD ---

// Suppression
window.removeVol = async (num, comp, date) => {
    if (confirm(`Supprimer le vol ${num} (${comp}) ?`)) {
        const success = await deleteData(`/api/Vol/${num}/${comp}/${date}`);
        if (success) router(); 
    }
};

// Enregistrement (Ajout OU Modification)
document.addEventListener('submit', async (e) => {
    if (e.target.id === 'form-vol') {
        e.preventDefault();
        
        const payload = formToJSON(e.target);
        
        // On vérifie si on est en train de modifier (présence de l'ID caché)
        const isEdit = e.target.querySelector('input[name="is_edit"]');
        
        let result;
        if (isEdit) {
            // Appel PUT pour la modification
            result = await putData('/api/Vols', payload);
        } else {
            // Appel POST pour l'ajout
            result = await postData('/api/Vols', payload);
        }

        if (result) {
            closeModal();
            router();
        } else {
            alert("Erreur lors de l'enregistrement. Vérifiez vos données.");
        }
    }
});

// --- INITIALISATION ---
window.addEventListener('hashchange', router);
window.addEventListener('DOMContentLoaded', router);