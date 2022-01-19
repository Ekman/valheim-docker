#!/bin/bash -e

gosu "$USER" "$STEAMCMDDIR/steamcmd.sh" \
    +login anonymous \
    +force_install_dir "$GAME_DIR" \
    +app_update "$GAME_ID" \
    validate \
    +quit

gosu "$USER" bash /start-server.sh
