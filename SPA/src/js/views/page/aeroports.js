// js/views/aeroports.js
import { getData } from '../../service/api.js';

export async function renderAeroports() {
    const aeroports = await getData('/api/Aeroports'); //

    if (aeroports.length === 0) return `<p class="empty">Aucun aéroport répertorié.</p>`;

    return `
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>CODE</th>
                        <th>NOM</th>
                        <th>VILLE</th>
                        <th>PAYS</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    ${aeroports.map(a => `
                        <tr>
                            <td><strong>${a.code}</strong></td>
                            <td>${a.nom}</td>
                            <td>${a.ville}</td>
                            <td>${a.pays}</td>
                            <td>
                                <button class="btn-icon">✏️</button>
                                <button class="btn-icon">🗑️</button>
                            </td>
                        </tr>
                    `).join('')}
                </tbody>
            </table>
        </div>
    `;
}