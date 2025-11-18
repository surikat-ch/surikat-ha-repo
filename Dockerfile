ARG BUILD_FROM=ghcr.io/hassio-addons/base:11.0.0
FROM ${BUILD_FROM}

# Installer bash, python3, pip
RUN apt-get update && apt-get install -y \
    bash \
    python3 \
    python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY custom_components /config/custom_components

CMD [ "/run.sh" ]
