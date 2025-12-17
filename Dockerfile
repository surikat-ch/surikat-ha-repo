ARG BUILD_FROM=ghcr.io/hassio-addons/base:11.0.0
FROM ${BUILD_FROM}

# Utiliser bash pour des scripts plus sûrs
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Installer les dépendances système
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        bash \
        python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copier le script de validation des options (facultatif)
COPY options.py /app/options.py

# Copier le script principal et rendre exécutable
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Copier les custom_components dans /config/custom_components
COPY custom_components /config/custom_components

# Point d'entrée de l'addon
CMD [ "/run.sh" ]