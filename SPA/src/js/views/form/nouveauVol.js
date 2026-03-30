export function renderFormVol(vol = null, aeroports = []) {
    const isEdit = !!vol;

    // Génération des options pour les menus déroulants
    const aeroOptions = aeroports.map(a => 
        `<option value="${a.code}" ${vol?.codeAeroportD == a.code || vol?.codeAeroportA == a.code ? '' : ''}>
            ${a.code} - ${a.nom} (${a.ville})
        </option>`
    ).join('');

    return `
        <h2 class="modal-title">${isEdit ? `Modifier le Vol ${vol.numero}` : 'Nouveau Vol'}</h2>
        <form id="form-vol" class="form-vols">
            ${isEdit ? `
                <input type="hidden" name="is_edit" value="true">
                <input type="hidden" name="numero" value="${vol.numero}">
                <input type="hidden" name="compagnie" value="${vol.compagnie}">
                <input type="hidden" name="tempsD" value="${vol.tempsD}">
            ` : `
                <div class="form-group">
                    <label>Numéro de vol</label>
                    <input type="number" name="numero" required>
                </div>
                <div class="form-group">
                    <label>Compagnie</label>
                    <input type="text" name="compagnie" placeholder="Ex: Air France" required>
                </div>
                <div class="form-group">
                    <label>Date et Heure de départ</label>
                    <input type="datetime-local" name="tempsD" required>
                </div>
            `}

            <div class="form-group">
                <label>Aéroport de Départ</label>
                <select name="codeAeroportD" required>
                    <option value="">-- Sélectionner l'origine --</option>
                    ${aeroports.map(a => `<option value="${a.code}" ${vol?.codeAeroportD == a.code ? 'selected' : ''}>${a.code} - ${a.nom}</option>`).join('')}
                </select>
                <input type="text" name="terminalD" placeholder="Terminal" value="${vol?.terminalD || ''}">
            </div>

            <div class="form-group">
                <label>Aéroport d'Arrivée</label>
                <select name="codeAeroportA" required>
                    <option value="">-- Sélectionner la destination --</option>
                    ${aeroports.map(a => `<option value="${a.code}" ${vol?.codeAeroportA == a.code ? 'selected' : ''}>${a.code} - ${a.nom}</option>`).join('')}
                </select>
                <input type="text" name="terminalA" placeholder="Terminal" value="${vol?.terminalA || ''}">
            </div>

            <div class="form-group">
                <label>Date et Heure d'Arrivée</label>
                <input type="datetime-local" name="tempsA" value="${vol?.tempsA || ''}" required>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn-primary">Enregistrer</button>
                <button type="button" class="btn-secondary" onclick="closeModal()">Annuler</button>
            </div>
        </form>
    `;
}