import { getData } from '../../service/api.js';

export async function renderVols() {
    const vols = await getData('/api/Vols');

    if (!vols || vols.length === 0) return `<p class="empty">Aucun vol trouvé dans la base de données.</p>`;

    return `
        <div class="search-section" style="margin-bottom: 2rem;">
            <div class="search-bar-container">
                <div class="search-input-group">
                    <span class="search-icon">🔍</span>
                    <input type="text" id="filter-vols" onkeyup="filterTableVols()" placeholder="Rechercher par numéro, compagnie, ville...">
                </div>
            </div>
        </div>

        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>N° VOL</th>
                        <th>COMPAGNIE</th>
                        <th>DÉPART</th>
                        <th>ARRIVÉE</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody id="vols-table-body">
                    ${vols.map(v => `
                        <tr class="vol-row">
                            <td><strong>${v.numero}</strong></td>
                            <td>${v.compagnie}</td>
                            <td>
                                <strong>${v.aeroportD}</strong><br>
                                <small>${v.tempsD ? v.tempsD.replace('T', ' ') : ''}</small>
                            </td>
                            <td>
                                <strong>${v.aeroportA}</strong><br>
                                <small>${v.tempsA ? v.tempsA.replace('T', ' ') : ''}</small>
                            </td>
                            <td class="actions-cell">
                                <button class="btn-icon" onclick="viewVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">👁️</button>
                                <button class="btn-icon" onclick="editVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">✏️</button>
                                <button class="btn-icon" onclick="removeVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">🗑️</button>
                            </td>
                        </tr>
                    `).join('')}
                </tbody>
            </table>
        </div>
    `;
}