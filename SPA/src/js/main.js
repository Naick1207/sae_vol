import { formToJSON } from './utils.js';
import { renderVols } from './views/page/vols.js';
import { renderAeroports } from './views/page/aeroports.js';
import { renderFormVol } from './views/form/nouveauVol.js';
import { renderFormAeroport } from './views/form/nouvelAeroport.js'; 
import { renderCorrespondances } from './views/page/correspondances.js';
import { postData, deleteData, putData, getData } from './service/api.js';
import { renderDetailsVol, renderDetailsAeroport } from './views/page/details.js';

const contentDiv = document.getElementById('content');
const headerTitle = document.getElementById('header-title');
const headerActions = document.getElementById('header-actions');
const modal = document.getElementById('modal-container');
const modalContent = document.getElementById('modal-content');

function setupHeader(title, actions = '') {
    headerTitle.innerHTML = title;
    headerActions.innerHTML = actions;
}

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
    else if (hash === '#/Correspondances') {
        setupHeader('Correspondances');
        contentDiv.innerHTML = await renderCorrespondances();
    }
    else {
        setupHeader('Tableau de bord');
        contentDiv.innerHTML = '<h2>Bienvenue sur Wilson Compagnie</h2>';
    }
}

window.addEventListener('hashchange', router);
window.addEventListener('load', router);

window.closeModal = () => {
    modal.classList.add('hidden');
    modalContent.innerHTML = '';
};

window.showAddVolForm = () => {
    modalContent.innerHTML = renderFormVol();
    modal.classList.remove('hidden');
};

window.showAddAeroportForm = () => {
    modalContent.innerHTML = renderFormAeroport();
    modal.classList.remove('hidden');
};

window.editVol = async (num, comp, date) => {
    const encodedDate = encodeURIComponent(date);
    const vol = await getData(`/api/Vol/${num}/${comp}/${encodedDate}`);
    if (vol) {
        modalContent.innerHTML = renderFormVol(vol);
        modal.classList.remove('hidden');
    }
};

window.editAeroport = async (code) => {
    const aero = await getData(`/api/Aeroports/${code}`);
    if (aero) {
        modalContent.innerHTML = renderFormAeroport(aero);
        modal.classList.remove('hidden');
    } else {
        alert("Impossible de charger les données de l'aéroport.");
    }
};

window.removeVol = async (num, comp, date) => {
    if (confirm(`Supprimer le vol ${num} ?`)) {
        const encodedDate = encodeURIComponent(date);
        await deleteData(`/api/Vol/${num}/${comp}/${encodedDate}`);
        router();
    }
};

window.removeAeroport = async (code) => {
    if (confirm(`Supprimer l'aéroport ${code} ?`)) {
        const success = await deleteData(`/api/Aeroport/${code}`);
        if (success) router();
        else alert("Erreur : Aéroport utilisé par des vols.");
    }
};

document.addEventListener('submit', async (e) => {
    e.preventDefault();
    const payload = formToJSON(e.target);
    const isEdit = e.target.querySelector('input[name="is_edit"]');
    let result = null;

    if (e.target.id === 'form-vol') {
        if (isEdit) {
            const { numero, compagnie, tempsD, ...updateBody } = payload;
            result = await putData(`/api/Vol/${numero}/${compagnie}/${encodeURIComponent(tempsD)}`, updateBody);
        } else {
            result = await postData('/api/Vols', payload);
        }
    } else if (e.target.id === 'form-aeroport') {
        if (isEdit) {
            const { code, ...updateBody } = payload;
            result = await putData(`/api/Aeroport/${code}`, updateBody);
        } else {
            result = await postData('/api/Aeroports', payload);
        }
    }

    if (result) { closeModal(); router(); }
});

window.viewVol = async (num, comp, date) => {
    const v = await getData(`/api/Vol/${num}/${comp}/${encodeURIComponent(date)}`);
    if (v) {
        modalContent.innerHTML = await renderDetailsVol(v); 
        modal.classList.remove('hidden');
    }
};

window.viewAeroport = async (code) => {
    const aero = await getData(`/api/Aeroports/${code}`);
    if (aero) {
        modalContent.innerHTML = await renderDetailsAeroport(aero);
        modal.classList.remove('hidden');
    }
};