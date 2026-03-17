import { API_BASE } from '../config.js';

export async function getData(endpoint) {
    try {
        const response = await fetch(`${API_BASE}${endpoint}`);
        return await response.json();
    } catch (error) {
        console.error("Erreur GET:", error);
        return [];
    }
}

export async function postData(endpoint, data) {
    try {
        const response = await fetch(`${API_BASE}${endpoint}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });
        
        if (!response.ok) {
            // Si l'API renvoie une erreur (ex: 400 ou 500)
            const errorDetails = await response.json();
            console.error("Erreur renvoyée par l'API :", errorDetails);
            return null;
        }
        return await response.json();
    } catch (error) {
        console.error("Erreur de connexion (Serveur Python éteint ?) :", error);
        return null;
    }
}

export async function deleteData(endpoint) {
    try {
        // Remplace BASE_URL par API_BASE
        const response = await fetch(`${API_BASE}${endpoint}`, { 
            method: 'DELETE' 
        });
        
        // Attention : Flask-Restx renvoie souvent 204 (No Content) 
        // ou 200 (OK) après une suppression. On accepte les deux.
        return response.ok; 
    } catch (error) {
        console.error("Erreur lors de la suppression :", error);
        return false;
    }
}

export async function putData(endpoint, data) {
    const response = await fetch(`${API_BASE}${endpoint}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    return response.ok ? await response.json() : null;
}