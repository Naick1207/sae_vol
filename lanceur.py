import os
import subprocess
import venv
from pathlib import Path

def setup_and_run():
    # 1. Configuration des chemins
    root_dir = Path(__file__).parent.absolute()
    venv_dir = root_dir / ".venv"
    req_file = root_dir / "requirements.txt"
    
    # Chemin vers le dossier de l'API pour le terminal
    api_dir = root_dir / "Restx" / "API"
    
    # Exécutables selon l'OS
    if os.name == "nt":
        python_exe = venv_dir / "Scripts" / "python.exe"
        pip_exe = venv_dir / "Scripts" / "pip.exe"
        flask_exe = venv_dir / "Scripts" / "flask.exe"
    else:
        python_exe = venv_dir / "bin" / "python"
        pip_exe = venv_dir / "bin" / "pip"
        flask_exe = venv_dir / "bin" / "flask"

    print("=== [1/3] Préparation Environnement ===")
    if not venv_dir.exists():
        venv.create(venv_dir, with_pip=True)
    
    # Installation des dépendances
    subprocess.check_call([str(pip_exe), "install", "-r", str(req_file)])

    print("\n=== [2/3] Initialisation Base de Données (syncdb) ===")
    # On définit FLASK_APP pour que la commande flask fonctionne
    env = os.environ.copy()
    env["FLASK_APP"] = "app.py"
    
    try:
        # On lance syncdb dans le dossier API
        subprocess.run([str(flask_exe), "syncdb"], cwd=str(api_dir), env=env)
        print("Synchronisation terminée.")
    except Exception as e:
        print(f"Note: Erreur ou commande syncdb déjà faite : {e}")

    print("\n=== [3/3] Lancement Flask Run ===")
    print("--------------------------------------------------")
    print(" API : http://127.0.0.1:5000")
    print("--------------------------------------------------")
    
    try:
        # Lancement du serveur
        subprocess.run([str(flask_exe), "run"], cwd=str(api_dir), env=env)
    except KeyboardInterrupt:
        print("\nArrêt du serveur.")

if __name__ == "__main__":
    setup_and_run()