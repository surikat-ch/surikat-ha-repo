ARG BUILD_FROM=ghcr.io/hassio-addons/base:11.0.0
FROM ${BUILD_FROM}

RUN apk add --no-cache \
    bash \
    python3 \
    py3-pip

COPY run.sh /run.sh
RUN chmod +x /run.sh

COPY custom_components /config/custom_components

CMD [ "/run.sh" ]
