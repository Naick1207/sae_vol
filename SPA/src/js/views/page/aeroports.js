import { getData } from '../../service/api.js';

export async function renderAeroports() {
    // On récupère les deux listes
    const [aeroports, vols] = await Promise.all([
        getData('/api/Aeroports'),
        getData('/api/Vols')
    ]);

    if (aeroports.length === 0) return `<p class="empty">Aucun aéroport répertorié.</p>`;

    return `
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>CODE</th><th>NOM</th><th>VILLE</th><th>PAYS</th><th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    ${aeroports.map(a => {
                        const estUtilise = vols.some(v => 
                            v.codeAeroportD === a.code || v.codeAeroportA === a.code
                        );

                        return `
                        <tr>
                            <td><strong>${a.code}</strong></td>
                            <td>${a.nom}</td>
                            <td>${a.ville}</td>
                            <td>${a.pays}</td>
                            <td>
                                <button class="btn-icon" title="Voir" onclick="viewAeroport('${a.code}')">👁️</button>
                                <button class="btn-icon" onclick="editAeroport('${a.code}')" title="Modifier">✏️</button>
                                
                                <button class="btn-icon ${estUtilise ? 'btn-disabled' : ''}" 
                                        ${estUtilise ? 'disabled title="Impossible de supprimer : des vols sont rattachés"' : 'title="Supprimer"'} 
                                        onclick="removeAeroport('${a.code}')">
                                    🗑️
                                </button>
                            </td>
                        </tr>
                        `;
                    }).join('')}
                </tbody>
            </table>
        </div>
    `;
}