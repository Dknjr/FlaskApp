<h1>FlaskApp — pipeline CI/CD avec GitHub Actions et Docker</h1>

<p>
  <img alt="CI" src="https://github.com/Dknjr/FlaskApp/actions/workflows/ci.yml/badge.svg">
  <img alt="Python" src="https://img.shields.io/badge/Python-3.12-3776AB?logo=python&logoColor=white">
  <img alt="Flask" src="https://img.shields.io/badge/Flask-3.0-000000?logo=flask&logoColor=white">
  <img alt="Docker" src="https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white">
  <img alt="GitHub Actions" src="https://img.shields.io/badge/GitHub%20Actions-2088FF?logo=githubactions&logoColor=white">
</p>

Une application Flask volontairement minimale, qui sert de support à un **pipeline d'intégration et de livraison continues** complet : tests automatiques, puis construction et publication d'une image Docker.

*A deliberately minimal Flask app used to set up a full CI/CD pipeline: automated tests, then building and pushing a Docker image.*

---

## Le pipeline

```
push / pull request sur master
        │
        ▼
┌───────────────┐   échec → arrêt   ┌──────────────────────────┐
│  1. Tests     │ ────────────────▶ │  2. Docker               │
│  pytest       │      succès       │  build + push Docker Hub │
└───────────────┘                   └──────────────────────────┘
```

1. **Tests** : installation de Python 3.12 et des dépendances, puis `pytest`.
2. **Docker** : ne s'exécute que si les tests passent. Connexion à Docker Hub, construction de l'image `flaskapp:latest`, puis publication.

Les identifiants Docker Hub sont stockés dans les **secrets du dépôt** (`DOCKER_USERNAME`, `DOCKER_PASSWORD`), jamais dans le code.

## Fichiers

| Fichier | Rôle |
|---|---|
| `app.py` | Application Flask, une route `/` |
| `test_app.py` | Test unitaire de la route |
| `requirements.txt` | Dépendances (Flask, pytest) |
| `Dockerfile` | Image basée sur `python:3.12-slim`, port 5000 |
| `.github/workflows/ci.yml` | Le pipeline CI/CD |

## Lancer en local

```bash
pip install -r requirements.txt
pytest -q
python app.py                   # http://localhost:5000
```

Avec Docker :

```bash
docker build -t flaskapp .
docker run -p 5000:5000 flaskapp
```

## Auteur

**Erminio Dorkenoo**, étudiant en MSc Intelligence Artificielle à l'ECE Paris.
[LinkedIn](https://www.linkedin.com/in/erminio-dorkenoo-21458a232) · [erminiodorkenoo@gmail.com](mailto:erminiodorkenoo@gmail.com)
