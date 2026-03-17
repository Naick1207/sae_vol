export function renderFormVol(vol = null) {
    const title = vol ? `Modifier le Vol ${vol.numero}` : "Nouveau Vol";
    
    return `
        <h2 class="modal-title">${title}</h2>
        <form id="form-vol" class="form-vols">
            ${vol ? `<input type="hidden" name="old_numero" value="${vol.numero}">` : ''}
            
            <div class="form-group">
                <input type="number" name="numero" placeholder="Numéro" value="${vol?.numero || ''}" required>
            </div>
            <div class="form-group">
                <input type="text" name="compagnie" placeholder="Compagnie" value="${vol?.compagnie || ''}" required>
            </div>
            <div class="form-group">
                <label>Départ</label>
                <input type="datetime-local" name="tempsD" value="${vol?.tempsD || ''}" required>
                <input type="text" name="terminalD" placeholder="Terminal" value="${vol?.terminalD || ''}">
                <input type="number" name="codeAeroportD" placeholder="Code Aéro" value="${vol?.codeAeroportD || ''}">
            </div>
            <div class="form-group">
                <label>Arrivée</label>
                <input type="datetime-local" name="tempsA" value="${vol?.tempsA || ''}" required>
                <input type="text" name="terminalA" placeholder="Terminal" value="${vol?.terminalA || ''}">
                <input type="number" name="codeAeroportA" placeholder="Code Aéro" value="${vol?.codeAeroportA || ''}">
            </div>
            
            <div class="form-actions">
                <button type="submit" class="btn-primary">${vol ? 'Mettre à jour' : 'Enregistrer'}</button>
                <button type="button" class="btn-secondary" onclick="closeModal()">Annuler</button>
            </div>
        </form>
    `;
}