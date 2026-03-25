export function renderFormAeroport(aero = null) {
    return `
        <h2 class="modal-title">${aero ? 'Modifier l\'aéroport' : 'Nouvel Aéroport'}</h2>
        <form id="form-aeroport" class="form-vols">
            ${aero ? '<input type="hidden" name="is_edit" value="true">' : ''}
            
            <div class="form-group">
                <label>Code de l'aéroport</label>
                <input type="number" name="code" value="${aero ? aero.code : ''}" ${aero ? 'readonly class="locked-input"' : 'required'}>
            </div>
            
            <div class="form-group">
                <label>Nom de l'aéroport</label>
                <input type="text" name="nom" placeholder="Nom" value="${aero ? (aero.nom || '') : ''}" required>
            </div>
            <div class="form-group">
                <label>Ville</label>
                <input type="text" name="ville" placeholder="Ville" value="${aero ? (aero.ville || '') : ''}" required>
            </div>
            <div class="form-group">
                <label>Pays</label>
                <input type="text" name="pays" placeholder="Pays" value="${aero ? (aero.pays || '') : ''}" required>
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn-primary">Enregistrer</button>
                <button type="button" class="btn-secondary" onclick="closeModal()">Annuler</button>
            </div>
        </form>
    `;
}