# 1. Image Python
FROM python:3.12-slim

# 2. Definition du dossier de travail dans le conteneur
WORKDIR /app

# 3. Copie du fichier requirements.txt
COPY requirements.txt .

# 4. Installation des dependances
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copie des fichiers du projet dans le conteneur
COPY . .

# Vérifie toutes les 30 s que l'application répond sur /health
# (python:3.12-slim n'a pas curl, on utilise donc la bibliothèque standard de Python)
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health', timeout=2)" || exit 1

# 6. Exposer le port utilisé par Flask
EXPOSE 5000

# 7. Commande pour lancer l'application Flask
CMD ["python", "app.py"]
