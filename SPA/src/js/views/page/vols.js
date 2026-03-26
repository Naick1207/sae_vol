import { getData } from '../../service/api.js';

export async function renderVols() {
    const vols = await getData('/api/Vols');

    if (vols.length === 0) return `<p class="empty">Aucun vol trouvé.</p>`;

    return `
        <div class="search-section" style="margin-bottom: 2rem;">
            <div class="search-bar-container">
                <div class="search-input-group">
                    <span class="search-icon">🔍</span>
                    <input type="text" id="filter-vols" onkeyup="filterTableVols()" placeholder="Rechercher un vol, une ville, une compagnie...">
                </div>
                
                <div class="toggle-group">
                    <button id="btn-dep" class="btn-toggle active" onclick="setDirection('D')">Départs</button>
                    <button id="btn-arr" class="btn-toggle" onclick="setDirection('A')">Arrivées</button>
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="data-table" id="vols-table">
                <thead>
                    <tr>
                        <th>N° VOL</th>
                        <th>COMPAGNIE</th>
                        <th>DÉPART</th>
                        <th>ARRIVÉE</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    ${vols.map(v => `
                        <tr class="vol-row" 
                            data-num="${v.numero}" 
                            data-comp="${v.compagnie.toLowerCase()}" 
                            data-dep="${v.aeroportD.toLowerCase()}" 
                            data-arr="${v.aeroportA.toLowerCase()}">
                            <td>${v.numero}</td>
                            <td>${v.compagnie}</td>
                            <td>
                                <strong>${v.aeroportD}</strong><br>
                                <small>${v.tempsD.replace('T', ' ')}</small>
                            </td>
                            <td>
                                <strong>${v.aeroportA}</strong><br>
                                <small>${v.tempsA.replace('T', ' ')}</small>
                            </td>
                            <td class="actions-cell">
                                <button class="btn-icon" title="Voir" onclick="viewVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">👁️</button>
                                <button class="btn-icon" title="Modifier" onclick="editVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">✏️</button>
                                <button class="btn-icon" title="Supprimer" onclick="removeVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">🗑️</button>
                            </td>
                        </tr>
                    `).join('')}
                </tbody>
            </table>
        </div>
    `;
}