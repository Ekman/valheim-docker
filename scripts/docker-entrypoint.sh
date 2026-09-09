#!/bin/bash -e

bash "$STEAMCMDDIR/steamcmd.sh" \
    +force_install_dir "$GAME_DIR" \
    +login anonymous \
    +app_update "$GAME_ID" \
    validate \
    +quit

exec bash /start-server.sh $@
