#! Script principal qui est exécuté quand l’add-on démarre.
#! Peut :
#! Lancer des services
#! Préparer l’environnement
#! Appliquer des configurations spécifiques
#! Souvent le point d’entrée défini dans le Dockerfile.

#!/usr/bin/with-contenv bashio

echo "Starting Surikat HA Add-on..."
# Ici tu peux lancer ton service principal, ex: python3 main.py
exec "$@"