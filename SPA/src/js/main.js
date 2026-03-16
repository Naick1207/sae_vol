// 1. On importe tes futures fonctions de vues
import { renderVols } from './views/vols.js';
//import { renderAccueil } from './views/accueil.js';
//import { renderAeroports } from './views/aeroports.js';
//import { renderCorrespondances } from './views/correspondances.js';

// 2. Le point d'ancrage
const contentDiv = document.getElementById('content');

// 3. Le routeur : il décide quoi afficher
async function router() {
    const hash = window.location.hash || '#/';
    contentDiv.innerHTML = "Chargement...";
    
    switch (hash) {
        case '#/':
            contentDiv.innerHTML = await renderAccueil();
            break;
        case '#/Vols':
            contentDiv.innerHTML = await renderVols();
            break;
        case '#/Aeroports':
            contentDiv.innerHTML = await renderAeroports();
            break;
        case '#/Correspondances':
            contentDiv.innerHTML = await renderCorrespondances();
            break;
        default:
            contentDiv.innerHTML = "<h1>404</h1><p>Page introuvable</p>";
    }
}

// 4. Écoute les changements dans l'URL
window.addEventListener('hashchange', router);

// 5. Charge la page au démarrage
window.addEventListener('DOMContentLoaded', router);