import { getData } from '../service/api.js';

export async function renderVols() {
    // On appelle ta route réelle vue sur l'image
    const vols = await getData('/api/Vols'); 
    
    return `
        <h1>Liste des vols</h1>
        <ul>
            ${vols.map(v => `<li>Vol ${v.numero} - ${v.compagnie}</li>`).join('')}
        </ul>
    `;
}