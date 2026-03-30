import { renderAccueil } from './views/page/accueil.js';
import { renderVols } from './views/page/vols.js';
import { renderAeroports } from './views/page/aeroports.js';
import { renderCorrespondances } from './views/page/correspondances.js';
import { renderFormVol } from './views/form/nouveauVol.js';
import { renderFormAeroport } from './views/form/nouvelAeroport.js';
import { renderDetailsVol, renderDetailsAeroport, renderItinerary } from './views/page/details.js';
import { getData, postData, putData, deleteData } from './service/api.js';

const contentDiv = document.getElementById('content');
const headerTitle = document.getElementById('header-title');
const headerActions = document.getElementById('header-actions');
const modal = document.getElementById('modal-container');
const modalContent = document.getElementById('modal-content');

async function router() {
    const hash = window.location.hash || '#/';
    headerActions.innerHTML = '';

    switch(hash) {
        case '#/Vols':
            headerTitle.innerText = 'Gestion des Vols';
            headerActions.innerHTML = '<button class="btn-primary" onclick="showAddVolForm()">+ Nouveau vol</button>';
            contentDiv.innerHTML = await renderVols();
            break;
        case '#/Aeroports':
            headerTitle.innerText = 'Aéroports';
            headerActions.innerHTML = '<button class="btn-primary" onclick="showAddAeroportForm()">+ Nouvel Aéroport</button>';
            contentDiv.innerHTML = await renderAeroports();
            break;
        case '#/Correspondances':
            headerTitle.innerText = 'Correspondances';
            contentDiv.innerHTML = await renderCorrespondances();
            break;
        default:
            headerTitle.innerText = 'Tableau de bord';
            contentDiv.innerHTML = await renderAccueil();
    }
}

window.addEventListener('hashchange', router);
window.addEventListener('load', router);

// --- FONCTIONS GLOBALES (Accessibles via onclick) ---
window.closeModal = () => modal.classList.add('hidden');

window.showAddVolForm = async () => {
    const aeroports = await getData('/api/Aeroports');
    modalContent.innerHTML = renderFormVol(null, aeroports);
    modal.classList.remove('hidden');
};

window.editVol = async (num, comp, date) => {
    const [vol, aeroports] = await Promise.all([
        getData(`/api/Vol/${num}/${comp}/${encodeURIComponent(date)}`),
        getData('/api/Aeroports')
    ]);
    modalContent.innerHTML = renderFormVol(vol, aeroports);
    modal.classList.remove('hidden');
};

window.removeVol = async (num, comp, date) => {
    if(confirm("Supprimer ce vol ?")) {
        await deleteData(`/api/Vol/${num}/${comp}/${encodeURIComponent(date)}`);
        router();
    }
};

window.viewVol = async (num, comp, date) => {
    const vol = await getData(`/api/Vol/${num}/${comp}/${encodeURIComponent(date)}`);
    modalContent.innerHTML = await renderDetailsVol(vol);
    modal.classList.remove('hidden');
};

window.showAddAeroportForm = () => {
    modalContent.innerHTML = renderFormAeroport();
    modal.classList.remove('hidden');
};

window.editAeroport = async (code) => {
    const aero = await getData(`/api/Aeroports/${code}`);
    modalContent.innerHTML = renderFormAeroport(aero);
    modal.classList.remove('hidden');
};

window.viewAeroport = async (code) => {
    const aero = await getData(`/api/Aeroports/${code}`);
    modalContent.innerHTML = await renderDetailsAeroport(aero);
    modal.classList.remove('hidden');
};

window.removeAeroport = async (code) => {
    if(confirm("Supprimer l'aéroport ?")) {
        await deleteData(`/api/Aeroports/${code}`);
        router();
    }
};

window.viewItinerary = async (n1, c1, d1, n2, c2, d2) => {
    const [v1, v2] = await Promise.all([
        getData(`/api/Vol/${n1}/${c1}/${encodeURIComponent(d1)}`),
        getData(`/api/Vol/${n2}/${c2}/${encodeURIComponent(d2)}`)
    ]);
    modalContent.innerHTML = renderItinerary(v1, v2);
    modal.classList.remove('hidden');
};

window.executeQuickSearch = async () => {
    const input = document.getElementById('quick-search-input');
    const resultsDiv = document.getElementById('quick-search-results');
    if (!input || !resultsDiv) return;

    const term = input.value.trim().toLowerCase();
    if (term.length < 2) {
        resultsDiv.innerHTML = "";
        return;
    }

    // On fait la requête explicitement ici
    const vols = await getData('/api/Vols');
    
    const filtered = vols.filter(v => 
        v.numero.toString().includes(term) || 
        v.compagnie.toLowerCase().includes(term) ||
        v.aeroportD.toLowerCase().includes(term) ||
        v.aeroportA.toLowerCase().includes(term)
    );

    resultsDiv.innerHTML = filtered.length === 0 ? `<p>Aucun résultat.</p>` : `
        <div class="results-list" style="background: #1e293b; padding: 10px; border-radius: 8px;">
            ${filtered.map(v => `
                <div class="search-result-item" style="padding: 10px; border-bottom: 1px solid #334155; cursor: pointer;" 
                     onclick="viewVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">
                    <strong>Vol ${v.numero}</strong> - ${v.compagnie} <br>
                    <small>${v.aeroportD} ➔ ${v.aeroportA}</small>
                </div>
            `).join('')}
        </div>
    `;
};

document.addEventListener('submit', async (e) => {
    e.preventDefault();
    
    // 1. Récupération des données du formulaire
    const formData = new FormData(e.target);
    const payload = Object.fromEntries(formData.entries());
    const isEdit = payload.is_edit === 'true';

    // 2. Traitement selon le formulaire
    if (e.target.id === 'form-vol') {
        // On extrait les identifiants pour l'URL
        const { numero, compagnie, tempsD, is_edit, ...dataToSend } = payload;
        
        if (isEdit) {
            // MODIFIER : On envoie uniquement le reste (restX) dans le body
            // On enlève numero, compagnie et tempsD du JSON car ils sont déjà dans l'URL
            const res = await putData(`/api/Vol/${numero}/${compagnie}/${encodeURIComponent(tempsD)}`, dataToSend);
            if (res) { closeModal(); router(); }
        } else {
            // NOUVEAU : On envoie tout le payload
            const res = await postData('/api/Vols', payload);
            if (res) { closeModal(); router(); }
        }
    } 
    else if (e.target.id === 'form-aeroport') {
        const { code, is_edit, ...dataToSend } = payload;

        if (isEdit) {
            // MODIFIER : On enlève 'code' du JSON pour éviter "multiple values for argument code"
            const res = await putData(`/api/Aeroports/${code}`, dataToSend);
            if (res) { closeModal(); router(); }
        } else {
            // NOUVEAU : Ton erreur Python dit que create_aeroport ne veut pas de 'code'
            // On envoie donc uniquement nom, ville, pays si c'est ce que ton API attend
            const res = await postData('/api/Aeroports', dataToSend); 
            if (res) { closeModal(); router(); }
        }
    }
});