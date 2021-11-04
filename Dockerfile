FROM cm2network/steamcmd:root

LABEL org.opencontainers.image.source="https://github.com/Ekman/valheim-docker"
LABEL org.opencontainers.image.authors="Niklas Ekman <nikl.ekman@gmail.com>"

ENV GAME_DIR="$HOMEDIR/game" \
    CONFIG_DIR="$HOMEDIR/config" \
    GAME_ID="896660" \
    NAME="My server" \
    WORLD="Dedicated" \
    PORT=2456 \
    PASSWORD="secret" \
    PUBLIC=0 \
    DEBIAN_FRONTEND="noninteractive"

EXPOSE 2456-2458/udp

ADD --chown=$USER:$USER scripts/docker-entrypoint.sh /
ADD --chown=$USER:$USER scripts/start-server.sh /

ARG APT_FLAGS="--yes --no-install-recommends --no-install-suggests"
RUN apt-get update \
    && apt-get upgrade $APT_FLAGS \
    && apt-get install $APT_FLAGS tini \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && apt-get autoclean

USER "$USER"
RUN mkdir -p "$GAME_DIR" && mkdir -p "$CONFIG_DIR"
VOLUME [ "$GAME_DIR", "$CONFIG_DIR" ]

# See: https://github.com/docker-library/official-images#init
ENTRYPOINT [ "tini", "--", "bash", "/docker-entrypoint.sh" ]
