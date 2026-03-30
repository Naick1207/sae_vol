import { getData } from '../../service/api.js';

export async function renderAccueil() {
    const [vols, aeroports] = await Promise.all([
        getData('/api/Vols'),
        getData('/api/Aeroports')
    ]);

    // Calcul des correspondances
    let nbCorr = 0;
    vols.forEach(vA => {
        vols.forEach(vB => {
            if (vA.codeAeroportA === vB.codeAeroportD && (vA.numero !== vB.numero || vA.compagnie !== vB.compagnie)) {
                const diff = (new Date(vB.tempsD) - new Date(vA.tempsA)) / (1000 * 60);
                if (diff >= 45 && diff <= 1440) nbCorr++;
            }
        });
    });

    return `
        <div class="dashboard-grid">
            <div class="stat-card">
                <div class="stat-icon">✈️</div>
                <div class="stat-content">
                    <span class="stat-label">Vols totaux</span>
                    <span class="stat-value">${vols.length}</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🔄</div>
                <div class="stat-content">
                    <span class="stat-label">Correspondances</span>
                    <span class="stat-value">${nbCorr}</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🏢</div>
                <div class="stat-content">
                    <span class="stat-label">Aéroports</span>
                    <span class="stat-value">${aeroports.length}</span>
                </div>
            </div>
        </div>

        <div class="search-section">
            <h3 class="search-title">Recherche rapide</h3>
            <div class="search-bar-container">
                <div class="search-input-group">
                    <span class="search-icon">🔍</span>
                    <input type="text" id="quick-search-input" placeholder="N° de vol ou Compagnie...">
                </div>
                <button class="btn-primary" onclick="executeQuickSearch()">Rechercher</button>
            </div>
            <div id="quick-search-results" style="margin-top: 20px;"></div>
        </div>
    `;
}