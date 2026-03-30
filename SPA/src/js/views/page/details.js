export function renderItinerary(v1, v2) {
    const escaleMin = (new Date(v2.tempsD) - new Date(v1.tempsA)) / 60000;
    return `
        <h2 class="modal-title">Détails du voyage</h2>
        <div class="itinerary-details">
            <div class="step">
                <strong>Départ : ${v1.codeAeroportD}</strong><br>
                <small>${v1.tempsD.replace('T', ' ')} (Vol ${v1.numero})</small>
            </div>
            <div class="step-connector">
                Escale à ${v1.codeAeroportA} (${Math.floor(escaleMin/60)}h ${Math.floor(escaleMin%60)}min)
            </div>
            <div class="step">
                <strong>Arrivée : ${v2.codeAeroportA}</strong><br>
                <small>${v2.tempsA.replace('T', ' ')} (Vol ${v2.numero})</small>
            </div>
        </div>
        <div class="form-actions"><button class="btn-secondary" onclick="closeModal()">Fermer</button></div>
    `;
}

export async function renderDetailsVol(v) {
    return `
        <h2 class="modal-title">Vol ${v.numero}</h2>
        <p>Compagnie: ${v.compagnie}</p>
        <p>Départ: ${v.codeAeroportD} à ${v.tempsD}</p>
        <p>Arrivée: ${v.codeAeroportA} à ${v.tempsA}</p>
        <button class="btn-secondary" onclick="closeModal()">Fermer</button>
    `;
}

export async function renderDetailsAeroport(a) {
    return `
        <h2 class="modal-title">${a.nom}</h2>
        <p>Ville: ${a.ville} (${a.pays})</p>
        <p>Code: ${a.code}</p>
        <button class="btn-secondary" onclick="closeModal()">Fermer</button>
    `;
}