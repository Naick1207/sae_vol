// js/views/vols.js
import { getData } from '../../service/api.js';

export async function renderVols() {
    const vols = await getData('/api/Vols'); // Appelle ta route Python

    if (vols.length === 0) return `<p class="empty">Aucun vol trouvé.</p>`;

    return `
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>N° VOL</th>
                        <th>COMPAGNIE</th>
                        <th>DÉPART</th>
                        <th>ARRIVÉE</th>
                        <th>TERMINAL</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    ${vols.map(v => `
                        <tr>
                            <td>${v.numero}</td>
                            <td>${v.compagnie}</td>
                            <td>${v.tempsD.replace('T', ' ')}</td>
                            <td>${v.tempsA.replace('T', ' ')}</td>
                            <td><span class="badge">${v.terminalD}</span></td>
                            <td>
                                <button onclick="editVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">✏️</button>
                                <button onclick="removeVol('${v.numero}', '${v.compagnie}', '${v.tempsD}')">🗑️</button>
                            </td>
                        </tr>
                    `).join('')}
                </tbody>
            </table>
        </div>
    `;
}