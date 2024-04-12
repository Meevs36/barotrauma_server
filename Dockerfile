# Author -- meevs
# Creation Date -- 2024-04-10
# File Name -- Dockerfile
# Notes --
#     -- This dockerfile builds a Barotrauma Dedicated Server

FROM steamcmd/steamcmd:debian

ARG INSTALL_DIR="/barotrauma_server"
ARG CONFIG_DIR="./config_files/base"

ENV INSTALL_DIR="${INSTALL_DIR}"

COPY ./init_scripts/init_container.sh /usr/bin/
COPY ./init_scripts/parse_mods.sh /usr/bin/

RUN apt-get update -y\
	&& apt-get install -y jq

# Setup Barotrauma server
#RUN mkdir --parent /root/.steam/sdk64/\
# && ln /root/.steam/steamcmd/linux64/steamclient.so /home/steam/.steam/sdk64/ --symbolic

RUN steamcmd +force_install_dir "${INSTALL_DIR}" +login anonymous +app_update 1026340 validate +quit
RUN mkdir --parent "${MOD_DIR}"\
	&& mkdir --parent "/root/.local/share/Daedalic Entertainment GmbH/Barotrauma"\
	&& mkdir --parent "/root/.steam/steamapps/common/Barotruama Dedicated Server"

WORKDIR ${INSTALL_DIR}

COPY "${CONFIG_DIR}/clientpermissions.xml" "${INSTALL_DIR}/"
COPY "${CONFIG_DIR}/config_player.xml" "${INSTALL_DIR}/Data/"
COPY "${CONFIG_DIR}/serversettings.xml" "${INSTALL_DIR}/"
COPY "${CONFIG_DIR}/mod_list.json" "${INSTALL_DIR}/"

EXPOSE 27015/udp
EXPOSE 27016/udp

CMD [ "/bin/bash", "-c" ]
ENTRYPOINT [ "init_container.sh" ]
