export function formToJSON(formElement) {
    const formData = new FormData(formElement);
    const data = Object.fromEntries(formData.entries());

    // AJOUTE 'code' et 'numero' ICI
    const numericFields = ['code', 'numero', 'codeAeroportD', 'codeAeroportA'];
    
    numericFields.forEach(field => {
        if (data[field]) data[field] = parseInt(data[field]);
    });

    return data;
}

export function formatDate(dateStr) {
    if (!dateStr) return "-";
    return dateStr.replace('T', ' ').substring(0, 16);
}