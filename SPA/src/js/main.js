import { formToJSON } from './utils.js';
import { renderVols } from './views/page/vols.js';
import { renderAeroports } from './views/page/aeroports.js';
import { renderFormVol } from './views/form/nouveauVol.js';
import { renderFormAeroport } from './views/form/nouvelAeroport.js'; 
import { postData, deleteData, putData, getData } from './service/api.js';
import { renderDetailsVol, renderDetailsAeroport } from './views/page/details.js';


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
        setupHeader('Aéroports', '<button class="btn-primary" onclick="showAddAeroportForm()">+ Ajouter Aéroport</button>');
        contentDiv.innerHTML = await renderAeroports();
    } 
    else {
        setupHeader('Accueil');
        contentDiv.innerHTML = '<h1>Bienvenue sur Wilson Compagnie</h1>';
    }
}

// --- GESTION DES MODALES ---
window.showAddVolForm = () => {
    modalContent.innerHTML = renderFormVol();
    modal.classList.remove('hidden');
};

window.showAddAeroportForm = () => {
    modalContent.innerHTML = renderFormAeroport();
    modal.classList.remove('hidden');
};

window.closeModal = () => {
    modal.classList.add('hidden');
    modalContent.innerHTML = '';
};

modal.addEventListener('click', (e) => {
    if (e.target === modal) closeModal();
});

// --- ACTIONS CRUD : MODIFICATION (Pré-remplissage) ---

window.editAeroport = async (code) => {
    // Route singulière /api/Aeroport/ sans 's' pour la modif/get unique
    const aero = await getData(`/api/Aeroport/${code}`);
    if (aero) {
        modalContent.innerHTML = renderFormAeroport(aero);
        modal.classList.remove('hidden');
    }
};

window.editVol = async (num, comp, date) => {
    const encodedDate = encodeURIComponent(date);
    const vol = await getData(`/api/Vol/${num}/${comp}/${encodedDate}`);
    if (vol) {
        modalContent.innerHTML = renderFormVol(vol);
        modal.classList.remove('hidden');
    }
};

// --- ACTIONS CRUD : SUPPRESSION ---

window.removeAeroport = async (code) => {
    if (confirm(`Supprimer l'aéroport ${code} ?`)) {
        const success = await deleteData(`/api/Aeroport/${code}`);
        if (success) router();
    }
};

window.removeVol = async (num, comp, date) => {
    if (confirm(`Supprimer le vol ${num} (${comp}) ?`)) {
        const encodedDate = encodeURIComponent(date);
        const success = await deleteData(`/api/Vol/${num}/${comp}/${encodedDate}`);
        if (success) router(); 
    }
};

// --- ACTIONS CRUD : ENREGISTREMENT (SOUMISSION) ---

document.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const formId = e.target.id;
    const payload = formToJSON(e.target);
    const isEdit = e.target.querySelector('input[name="is_edit"]');

    let result = null;

    if (formId === 'form-vol') {
        if (isEdit) {
            // On sépare les clés de l'URL du reste des données pour éviter l'erreur 500 (modif PK interdite)
            const { numero, compagnie, tempsD, is_edit, ...updateBody } = payload;
            const encodedDate = encodeURIComponent(tempsD);
            const url = `/api/Vol/${numero}/${compagnie}/${encodedDate}`;
            result = await putData(url, updateBody);
        } else {
            result = await postData('/api/Vols', payload);
        }
    } 
    else if (formId === 'form-aeroport') {
        if (isEdit) {
            // On sépare le code (PK) pour ne pas l'envoyer dans le body du PUT
            const { code, is_edit, ...updateBody } = payload;
            const url = `/api/Aeroport/${code}`;
            result = await putData(url, updateBody);
        } else {
            result = await postData('/api/Aeroports', payload);
        }
    }

    if (result) {
        closeModal();
        router();
    } else {
        alert("Erreur lors de l'enregistrement. Vérifiez la console serveur (500) ou réseau (404/405).");
    }
});

// --- ACTIONS CRUD : Consultation (SOUMISSION) ---
window.viewVol = async (num, comp, date) => {
    const encodedDate = encodeURIComponent(date);
    const vol = await getData(`/api/Vol/${num}/${comp}/${encodedDate}`);
    if (vol) {
        modalContent.innerHTML = renderDetailsVol(vol);
        modal.classList.remove('hidden');
    }
};

window.viewAeroport = async (code) => {
    const aero = await getData(`/api/Aeroport/${code}`);
    if (aero) {
        modalContent.innerHTML = renderDetailsAeroport(aero);
        modal.classList.remove('hidden');
    }
};

// Initialisation
window.addEventListener('hashchange', router);
window.addEventListener('load', router);