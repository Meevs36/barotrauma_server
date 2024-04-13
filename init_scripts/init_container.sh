#!/bin/bash
# Author -- meevs
# Creation Date -- 2023-07-09
# File Name -- entrypoint.sh
# Notes --

export STEAM_LOGIN="anonymous"
export SERVER_ID="1026340"
export APP_ID="602960"
#export MOD_DIR="${HOME}/.local/share/Daedalic Entertainment GmbH/Barotrauma/WorkshopMods/Installed"
export MOD_DIR="${INSTALL_DIR}/LocalMods"
source parse_mods.sh 

echo ""
echo "Attempting to install/update mods..."
parse_mod "${INSTALL_DIR}/mod_list.json"
echo ""

echo ""
echo "Checking for updates..."
echo ""
steamcmd +force_install_dir "${INSTALL_DIR}" +login anonymous +app_update "${SERVER_ID}" validate +quit
echo ""
echo "Server is up to date!"
echo ""

echo ""
echo "Starting server..."
echo ""
echo ""

"${INSTALL_DIR}/DedicatedServer"

echo "${MOD_DIR}"
echo ""
ls "${MOD_DIR}"



echo ""
echo "Server has quit"
echo ""
echo ""
