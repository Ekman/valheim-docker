#!/bin/bash

set -e

bash "$STEAMCMDDIR/steamcmd.sh" +login anonymous +force_install_dir "$GAME_DIR" +app_update "$GAME_ID" validate +quit

bash /start_server.sh
