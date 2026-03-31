SAE Vol# ✈️ Wilson Compagnie - Système de Gestion de Vols

Application moderne de gestion de trafic aérien (SAE Vol). Ce projet utilise une architecture **SPA** (Single Page Application) et une application mobile **Flutter**, avec un backend **Flask REST-X** et une base de données **Oracle**.

---

## 1. Configuration de la base de données Oracle
Le projet nécessite une connexion à une base de données Oracle. Vous devez configurer vos identifiants personnels :

1. Accédez au dossier : `Restx/API/app/`
2. Ouvrez le fichier `.env` (créez-le s'il n'existe pas).
3. Modifiez les lignes suivantes en remplaçant `moisan` par **votre nom d'utilisateur Oracle** :

```py
# Modifier 'moisan' par votre identifiant IUT
DATABASE_URL=oracle+oracledb://"moisan":"moisan"@ora12
```

## 2. Lancement du Backend (API)
Un script d'automatisation est fourni pour configurer l'environnement et lancer les services.

Ouvrez un terminal à la racine du projet (sae_vol).

Exécutez le script avec Python :

```Bash
python lanceur.py
```
Ce que fait le script automatiquement :

Création de l'environnement virtuel (.venv).

Installation des dépendances (requirements.txt).

Synchronisation de la base de données via la commande flask syncdb.

Lancement du serveur de développement sur http://127.0.0.1:5000.

## 3. Lancement de l'application Web

Dans le dossier /SPA/src, lancez la commande:
```Bash
php -S localhost:3000
```
Cela lance un serveur PHP contenant notre SPA,

Pour s'y rendre, il suffit de rentrer dans la barre de recherche "http://localhost:3000" ou bien "http://127.0.0.1:3000".

## 4. Lancement de l'application mobile

Dans le dossier /flutter, lancez la commande:
```Bash
flutter run
```
Cela lance l'application au format web (L'application s'affiche sur Chrome ou Chromium par exemple en ouvrant automatique une fenêtre).

Si vous souhaitez utiliser l'application sur Android, il faudra modifier une ligne dans flutter/config.dart, remplacez l'adresse comme indiqué par l'adresse du serveur de l'API.