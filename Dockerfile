#Dockerfile
# Décrit l’image Docker de ton add-on.
# Contient les instructions pour installer toutes les dépendances, copier les fichiers nécessaires, et lancer ton script principal.
# Home Assistant construit l’add-on à partir de ce Dockerfile.

ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:15
FROM $BUILD_FROM

# ---- Arguments et variables ----
ARG BUILD_ARCH
ENV LANG=C.UTF-8

# Install requirements for add-on
RUN \
  apk add --no-cache \
    example_alpine_package

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

EXPOSE 123

CMD [ "/run.sh" ]
