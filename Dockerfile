FROM cm2network/steamcmd:root

LABEL org.opencontainers.image.source="https://github.com/Ekman/valheim-docker"
LABEL org.opencontainers.image.authors="Niklas Ekman <nikl.ekman@gmail.com>"

ENV GAME_DIR="$HOMEDIR/game" \
    CONFIG_DIR="$HOMEDIR/config" \
    GAME_ID="" \
    PUID="" \
    GUID="" \
    GAME_ID="896660" \
    NAME="My server" \
    WORLD="Dedicated" \
    PORT=2456 \
    PASSWORD="secret" \
    PUBLIC=0

EXPOSE 2456-2458/udp

ADD --chown=$USER:$USER scripts/docker-entrypoint.sh /
ADD --chown=$USER:$USER scripts/start-server.sh /

# Suppress error about /tmp/dumps not being owned by correct user
RUN chown -R "$USER":"$USER" /tmp/dumps \
    # Create volume directories and make sure they are owned by
    # the steam user
    && mkdir -p "$GAME_DIR" && mkdir -p "$CONFIG_DIR"
VOLUME [ "$GAME_DIR", "$CONFIG_DIR" ]
RUN chown -R "$USER":"$USER" "$GAME_DIR" "$CONFIG_DIR"

USER "$USER"
ENTRYPOINT [ "bash", "/docker-entrypoint.sh" ]