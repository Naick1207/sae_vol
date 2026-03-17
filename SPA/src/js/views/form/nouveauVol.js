export function renderFormVol(vol = null) {
    // Si on est en modification, on verrouille les clés primaires
    const isLocked = vol ? 'readonly class="locked-input"' : '';

    return `
        <h2 class="modal-title">${vol ? 'Modifier le vol' : 'Nouveau Vol'}</h2>
        <form id="form-vol" class="form-vols">
            ${vol ? '<input type="hidden" name="is_edit" value="true">' : ''}

            <div class="form-group">
                <label>Numéro de vol ${vol ? '🔒' : ''}</label>
                <input type="number" name="numero" placeholder="N°" value="${vol?.numero || ''}" ${isLocked} required>
            </div>
            <div class="form-group">
                <label>Compagnie ${vol ? '🔒' : ''}</label>
                <input type="text" name="compagnie" placeholder="Compagnie" value="${vol?.compagnie || ''}" ${isLocked} required>
            </div>
            
            <div class="form-group">
                <label>Départ ${vol ? '(Date 🔒)' : ''}</label>
                <input type="datetime-local" name="tempsD" value="${vol?.tempsD || ''}" ${isLocked} required>
                
                <input type="text" name="terminalD" placeholder="Terminal" value="${vol?.terminalD || ''}">
                <input type="number" name="codeAeroportD" placeholder="Code Aéro Départ" value="${vol?.codeAeroportD || ''}">
            </div>
            
            <div class="form-group">
                <label>Arrivée</label>
                <input type="datetime-local" name="tempsA" value="${vol?.tempsA || ''}" required>
                <input type="text" name="terminalA" placeholder="Terminal" value="${vol?.terminalA || ''}">
                <input type="number" name="codeAeroportA" placeholder="Code Aéro Arrivée" value="${vol?.codeAeroportA || ''}">
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn-primary">Enregistrer</button>
                <button type="button" class="btn-secondary" onclick="closeModal()">Annuler</button>
            </div>
        </form>
    `;
}