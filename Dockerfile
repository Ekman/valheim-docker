FROM cm2network/steamcmd:root

LABEL org.opencontainers.image.source="https://github.com/Ekman/valheim-docker"
LABEL org.opencontainers.image.authors="Niklas Ekman <niklas.ekman1@proton.me>"

ENV GAME_DIR="$HOMEDIR/game" \
    CONFIG_DIR="$HOMEDIR/config" \
    GAME_ID="896660"

RUN apt-get update \
    && apt-get install --yes --no-install-recommends --no-install-suggests tini libpulse0 libatomic1 libpulse-dev \
    && apt-get autoremove --yes --purge \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p "$GAME_DIR" "$CONFIG_DIR" "$HOMEDIR/.config" \
    && chown -R "$USER":"$USER" "$GAME_DIR" "$CONFIG_DIR" "$HOMEDIR/.config"

COPY --chown="$USER":"$USER" scripts/docker-entrypoint.sh /
COPY --chown="$USER":"$USER" scripts/start-server.sh /

VOLUME [ "$GAME_DIR", "$CONFIG_DIR", "$HOMEDIR/steamcmd", "$HOMEDIR/.config", "/tmp" ]

STOPSIGNAL SIGINT

USER $USER

ENTRYPOINT [ "tini", "--", "bash", "/docker-entrypoint.sh" ]
