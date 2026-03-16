// js/service/api.js
import { API_BASE } from '../config.js';

export async function getData(endpoint) {
    try {
        const response = await fetch(`${API_BASE}${endpoint}`);
        if (!response.ok) throw new Error(`Erreur HTTP: ${response.status}`);
        return await response.json();
    } catch (error) {
        console.error("Problème avec l'API :", error);
        return []; // On retourne une liste vide pour éviter de faire planter l'app
    }
}