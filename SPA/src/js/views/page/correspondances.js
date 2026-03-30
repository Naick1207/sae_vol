import { getData } from '../../service/api.js';

export async function renderCorrespondances() {
    const [vols, aeroports] = await Promise.all([
        getData('/api/Vols'),
        getData('/api/Aeroports')
    ]);

    const getCity = (code) => aeroports.find(a => a.code == code)?.ville || code;
    const getAeroNom = (code) => aeroports.find(a => a.code == code)?.nom || code;

    let html = `<div class="table-container"><table class="data-table">
        <thead><tr><th>TRAJET</th><th>ESCALE</th><th>ATTENTE</th><th>ACTIONS</th></tr></thead><tbody>`;

    let count = 0;
    vols.forEach(vA => {
        vols.forEach(vB => {
            if (vA.codeAeroportA === vB.codeAeroportD && (vA.numero !== vB.numero || vA.compagnie !== vB.compagnie)) {
                const diffMin = (new Date(vB.tempsD) - new Date(vA.tempsA)) / 60000;
                if (diffMin >= 45 && diffMin <= 1440) {
                    count++;
                    html += `<tr>
                        <td><strong>${getCity(vA.codeAeroportD)}</strong> ➔ <strong>${getCity(vB.codeAeroportA)}</strong></td>
                        <td>${getAeroNom(vA.codeAeroportA)}</td>
                        <td><span class="badge">${Math.floor(diffMin/60)}h ${Math.floor(diffMin%60)}min</span></td>
                        <td><button class="btn-icon" onclick="viewItinerary('${vA.numero}','${vA.compagnie}','${vA.tempsD}','${vB.numero}','${vB.compagnie}','${vB.tempsD}')"> Détails</button></td>
                    </tr>`;
                }
            }
        });
    });

    return count > 0 ? html + `</tbody></table></div>` : `<p class="empty">Aucune correspondance.</p>`;
}