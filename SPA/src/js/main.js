import { formToJSON } from './utils.js';
import { renderVols } from './views/page/vols.js';
import { renderAccueil } from './views/page/accueil.js';
import { renderFormVol } from './views/form/nouveauVol.js';
import { renderAeroports } from './views/page/aeroports.js';
import { renderFormAeroport } from './views/form/nouvelAeroport.js'; 
import { renderCorrespondances } from './views/page/correspondances.js';
import { postData, deleteData, putData, getData } from './service/api.js';
import { renderDetailsVol, renderDetailsAeroport } from './views/page/details.js';

const contentDiv = document.getElementById('content');
const headerTitle = document.getElementById('header-title');
const headerActions = document.getElementById('header-actions');
const modal = document.getElementById('modal-container');
const modalContent = document.getElementById('modal-content');

// --- LOGIQUE FILTRAGE VOLS ---
let currentDirection = 'D'; // 'D' pour Départ, 'A' pour Arrivée

window.setDirection = (dir) => {
    currentDirection = dir;
    document.getElementById('btn-dep').classList.toggle('active', dir === 'D');
    document.getElementById('btn-arr').classList.toggle('active', dir === 'A');
    filterTableVols(); 
};

window.filterTableVols = () => {
    const term = document.getElementById('filter-vols').value.toLowerCase();
    const rows = document.querySelectorAll('.vol-row');

    rows.forEach(row => {
        const num = row.getAttribute('data-num').toLowerCase();
        const comp = row.getAttribute('data-comp').toLowerCase();
        const aeroDep = row.getAttribute('data-dep').toLowerCase();
        const aeroArr = row.getAttribute('data-arr').toLowerCase();

        let matchesSearch = false;
        
        if (currentDirection === 'D') {
            // En mode départ, on ignore la colonne arrivée
            matchesSearch = num.includes(term) || comp.includes(term) || aeroDep.includes(term);
        } else {
            // En mode arrivée, on ignore la colonne départ
            matchesSearch = num.includes(term) || comp.includes(term) || aeroArr.includes(term);
        }

        row.style.display = matchesSearch ? "" : "none";
    });
};

// --- NAVIGATION ---
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
        contentDiv.innerHTML = await renderAccueil();
    }
}

window.addEventListener('hashchange', router);
window.addEventListener('load', router);

// --- MODALE ---
window.closeModal = () => modal.classList.add('hidden');

// --- ACTIONS CRUD ---
window.showAddVolForm = () => {
    modalContent.innerHTML = renderFormVol();
    modal.classList.remove('hidden');
};

window.showAddAeroportForm = () => {
    modalContent.innerHTML = renderFormAeroport();
    modal.classList.remove('hidden');
};

window.editVol = async (num, comp, date) => {
    const v = await getData(`/api/Vol/${num}/${comp}/${encodeURIComponent(date)}`);
    if (v) {
        modalContent.innerHTML = renderFormVol(v);
        modal.classList.remove('hidden');
    }
};

window.removeVol = async (num, comp, date) => {
    if (confirm(`Supprimer le vol ${num} ?`)) {
        await deleteData(`/api/Vol/${num}/${comp}/${encodeURIComponent(date)}`);
        router();
    }
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
        else alert("Erreur : Aéroport utilisé par des vols.");
    }
};

// --- FORM SUBMIT ---
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

window.executeQuickSearch = async () => {
    const term = document.getElementById('quick-search-input').value.toLowerCase();
    const resultsDiv = document.getElementById('quick-search-results');
    if (!term) { resultsDiv.innerHTML = ""; return; }

    const vols = await getData('/api/Vols');
    const filtered = vols.filter(v => 
        v.numero.toString().includes(term) || v.compagnie.toLowerCase().includes(term)
    );

    resultsDiv.innerHTML = filtered.length === 0 ? `<p>Aucun vol trouvé.</p>` : `
        <div class="results-list">
            ${filtered.map(v => `
                <div class="search-result-item" onclick="viewVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">
                    <span><strong>Vol ${v.numero}</strong> - ${v.compagnie}</span>
                    <span class="result-link">Voir détails →</span>
                </div>
            `).join('')}
        </div>`;
};