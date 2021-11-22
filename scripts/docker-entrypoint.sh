#!/bin/bash

set -e

if [[ -n "$PUID" ]]; then
    usermod -u "$PUID" "$USER"
fi

if [[ -n "$PGID" ]]; then
    groupmod -g "$PGID" "$USER"
fi

gosu "$USER" "$STEAMCMDDIR/steamcmd.sh" +login anonymous +force_install_dir "$GAME_DIR" +app_update "$GAME_ID" validate +quit

gosu "$USER" bash /start-server.sh
