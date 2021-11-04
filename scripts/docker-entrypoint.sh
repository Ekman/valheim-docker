#!/bin/bash

set -e

"$STEAMCMDDIR/steamcmd.sh" +login anonymous +force_install_dir "$GAME_DIR" +app_update "$GAME_ID" validate +quit

/start-server.sh
