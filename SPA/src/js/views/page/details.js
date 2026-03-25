import { getData } from '../../service/api.js';

export async function renderDetailsVol(v) { 
    const aeroports = await getData('/api/Aeroports');

    const nomDep = aeroports.find(a => a.code == v.codeAeroportD)?.nom || `Code ${v.codeAeroportD}`;
    const nomArr = aeroports.find(a => a.code == v.codeAeroportA)?.nom || `Code ${v.codeAeroportA}`;

    return `
        <div class="modal-header">
            <h2 class="modal-title">Détails du Vol ${v.numero}</h2>
            <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <div class="details-grid">
            <div class="detail-item"><strong>Compagnie:</strong> ${v.compagnie}</div>
            <div class="detail-item">
                <strong>Départ:</strong> ${nomDep} <br>
                <small>${v.tempsD.replace('T', ' à ')} (Terminal ${v.terminalD})</small>
            </div>
            <hr>
            <div class="detail-item">
                <strong>Arrivée:</strong> ${nomArr} <br>
                <small>${v.tempsA.replace('T', ' à ')} (Terminal ${v.terminalA})</small>
            </div>
        </div>
        <div class="form-actions">
            <button class="btn-secondary" onclick="closeModal()">Fermer</button>
        </div>
    `;
}

export async function renderDetailsAeroport(a) {
    return `
        <div class="modal-header">
            <h2 class="modal-title">Aéroport : ${a.nom}</h2>
            <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <div class="details-grid">
            <div class="detail-item"><strong>Code:</strong> ${a.code}</div>
            <div class="detail-item"><strong>Ville:</strong> ${a.ville}</div>
            <div class="detail-item"><strong>Pays:</strong> ${a.pays}</div>
        </div>
        <div class="form-actions">
            <button class="btn-secondary" onclick="closeModal()">Fermer</button>
        </div>
    `;
}