#!/bin/bash

set -e

su "$USER" -c "$STEAMCMDDIR/steamcmd.sh +login anonymous +force_install_dir $GAME_DIR +app_update $GAME_ID validate +quit"

su "$USER" /start-server.sh
