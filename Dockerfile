ARG         ALPINE_VERSION=3.12
FROM        alpine:${ALPINE_VERSION}

ARG         SWAGGO_SWAG_VERSION=1.7.0
ENV         SWAGGO_SWAG_VERSION="${SWAGGO_SWAG_VERSION}" \
            SWAGGO_SWAG_USER="swaggo" \
            SWAGGO_SWAG_UID="1000"

ADD         https://github.com/swaggo/swag/releases/download/v${SWAGGO_SWAG_VERSION}/swag_${SWAGGO_SWAG_VERSION}_Linux_x86_64.tar.gz /tmp/swag.tar.gz

RUN         set -xe && \
            tar -xvzf /tmp/swag.tar.gz swag -C /usr/local/bin/ && \
            chmod +x /usr/local/bin/swag && \
            addgroup -g "${SWAGGO_SWAG_UID}" -S "${SWAGGO_SWAG_USER}" && \
            adduser -u "${SWAGGO_SWAG_UID}" -S "${SWAGGO_SWAG_USER}" -G "${SWAGGO_SWAG_USER}" && \
            rm -rf /tmp/*

USER        "${SWAGGO_SWAG_USER}"