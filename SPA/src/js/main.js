// 1. On importe tes futures fonctions de vues
import { renderVols } from './views/vols.js';
//import { renderAccueil } from './views/accueil.js';
import { renderAeroports } from './views/aeroports.js';
//import { renderCorrespondances } from './views/correspondances.js';

// 2. Le point d'ancrage
const contentDiv = document.getElementById('content');
const headerTitle = document.getElementById('header-title');
const headerActions = document.getElementById('header-actions');

// Fonction pour configurer le header selon la page courante
function setupHeader(title, actions = '') {
    headerTitle.innerHTML = title;
    headerActions.innerHTML = actions;
}

// 3. Le routeur : il décide quoi afficher
async function router() {
    const hash = window.location.hash || '#/';
    contentDiv.innerHTML = "Chargement...";
    headerTitle.innerHTML = "Attente d'une réponse...";
    headerActions.innerHTML = "";
    
    switch (hash) {
        case '#/Vols':
            // 1. On prépare le header comme sur ton image
            setupHeader('Vols', '<button class="btn-primary">+ Nouveau vol</button>');
            // 2. On charge les données
            content.innerHTML = await renderVols();
            break;
            
        case '#/Aeroports':
            setupHeader('Aéroports', '<button class="btn-primary">+ Ajouter Aéroport</button>');
            // 2. On charge les données
            content.innerHTML = await renderAeroports();
            break;

        default:
            setupHeader('Tableau de bord');
            content.innerHTML = "<h1>Bienvenue sur Wilson Compagnie</h1>";
    }
}

// 4. Écoute les changements dans l'URL
window.addEventListener('hashchange', router);

// 5. Charge la page au démarrage
window.addEventListener('DOMContentLoaded', router);