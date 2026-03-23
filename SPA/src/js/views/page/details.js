export function renderDetailsVol(v) {
    return `
        <div class="modal-header">
            <h2 class="modal-title">Détails du Vol ${v.numero}</h2>
            <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <div class="details-grid">
            <div class="detail-item"><strong>Compagnie:</strong> ${v.compagnie}</div>
            <div class="detail-item"><strong>Départ:</strong> ${v.tempsD.replace('T', ' à ')} (Terminal ${v.terminalD})</div>
            <div class="detail-item"><strong>Aéroport Départ:</strong> Code ${v.codeAeroportD}</div>
            <hr>
            <div class="detail-item"><strong>Arrivée:</strong> ${v.tempsA.replace('T', ' à ')} (Terminal ${v.terminalA})</div>
            <div class="detail-item"><strong>Aéroport Arrivée:</strong> Code ${v.codeAeroportA}</div>
        </div>
    `;
}

export function renderDetailsAeroport(a) {
    return `
        <div class="modal-header">
            <h2 class="modal-title">Aéroport : ${a.nom}</h2>
            <button class="modal-close" onclick="closeModal()">×</button>
        </div>
        <div class="details-grid">
            <div class="detail-item"><strong>Code IATA:</strong> ${a.code}</div>
            <div class="detail-item"><strong>Ville:</strong> ${a.ville}</div>
            <div class="detail-item"><strong>Pays:</strong> ${a.pays}</div>
        </div>
    `;
}