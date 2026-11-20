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

# 6. Exposer le port utilisé par Flask
EXPOSE 5000

# 7. Lancement avec Gunicorn, un serveur WSGI fait pour la production
#    (le serveur intégré de Flask, « python app.py », ne sert qu'au développement)
#    2 workers suffisent pour une petite app ; à ajuster selon le nombre de CPU
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--access-logfile", "-", "app:app"]
