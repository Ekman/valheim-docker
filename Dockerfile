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
    DEBIAN_FRONTEND="noninteractive" \
    STEAM_CONFIG_DIR="$HOMEDIR/.config"

EXPOSE 2456-2458/udp

RUN apt-get update \
    && apt-get install --yes --no-install-recommends --no-install-suggests tini gosu \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && apt-get autoclean \
    && mkdir -p "$GAME_DIR" "$CONFIG_DIR" "$STEAM_CONFIG_DIR" "$HOMEDIR/Steam" \
    && chown -R "$USER":"$USER" "$GAME_DIR" "$CONFIG_DIR" "$STEAM_CONFIG_DIR" "$HOMEDIR/Steam"

ADD --chown="$USER":"$USER" scripts/docker-entrypoint.sh /
ADD --chown="$USER":"$USER" scripts/start-server.sh /

VOLUME [ "$GAME_DIR", "$CONFIG_DIR", "$STEAM_CONFIG_DIR", "$HOMEDIR/Steam" ]

# See: https://github.com/docker-library/official-images#init
ENTRYPOINT [ "tini", "-v", "-e", "143", "--", "bash", "/docker-entrypoint.sh" ]
