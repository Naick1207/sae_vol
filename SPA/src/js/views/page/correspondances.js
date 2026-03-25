import { getData } from '../../service/api.js';

export async function renderCorrespondances() {
    const [vols, aeroports] = await Promise.all([
        getData('/api/Vols'),
        getData('/api/Aeroports')
    ]);

    const findAeroNom = (code) => aeroports.find(a => a.code == code)?.nom || `Code ${code}`;

    let html = `
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Trajet Complet</th>
                        <th>Escale</th>
                        <th>Durée Escale</th>
                        <th>Détails</th>
                    </tr>
                </thead>
                <tbody>
    `;

    let nbCorrespondances = 0;

    // Double boucle pour comparer chaque vol avec tous les autres
    vols.forEach(volA => {
        vols.forEach(volB => {
            // Règle 1: L'arrivée de A est le départ de B
            // Règle 2: Ce n'est pas le même vol (numéro ou compagnie différente)
            if (volA.codeAeroportA === volB.codeAeroportD && (volA.numero !== volB.numero || volA.compagnie !== volB.compagnie)) {
                
                const dateArriveeA = new Date(volA.tempsA);
                const dateDepartB = new Date(volB.tempsD);
                
                // Règle 3: Le vol B part après le vol A
                const diffMs = dateDepartB - dateArriveeA;
                const diffMinutes = Math.floor(diffMs / (1000 * 60));

                // On n'affiche que si l'escale dure entre 45 minutes et 24 heures
                if (diffMinutes >= 45 && diffMinutes <= 1440) {
                    nbCorrespondances++;
                    const heures = Math.floor(diffMinutes / 60);
                    const minutes = diffMinutes % 60;

                    html += `
                        <tr>
                            <td>
                                <strong>${findAeroNom(volA.codeAeroportD)}</strong> ✈️ 
                                <strong>${findAeroNom(volB.codeAeroportA)}</strong>
                            </td>
                            <td><span class="badge">${findAeroNom(volA.codeAeroportA)}</span></td>
                            <td>${heures}h ${minutes}min</td>
                            <td>
                                <small>1er vol: ${volA.compagnie} (${volA.numero})</small><br>
                                <small>2ème vol: ${volB.compagnie} (${volB.numero})</small>
                            </td>
                        </tr>
                    `;
                }
            }
        });
    });

    if (nbCorrespondances === 0) {
        return `<p class="empty">Aucune correspondance trouvée pour le moment.</p>`;
    }

    html += `</tbody></table></div>`;
    return html;
}