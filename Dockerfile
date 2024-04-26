# Author -- meevs
# Creation Date -- 2024-04-10
# File Name -- Dockerfile
# Notes --
#     -- This dockerfile builds a Barotrauma Dedicated Server

FROM steamcmd/steamcmd:debian

ARG INSTALL_DIR="/bt_server"

ENV SERVER_NAME="base"
ENV SERVER_ID="1026340"
ENV INSTALL_DIR="${INSTALL_DIR}"

COPY ./init_scripts/init_container.sh /usr/bin/
COPY ./init_scripts/parse_mods.sh /usr/bin/

RUN apt-get update -y\
	&& apt-get install -y jq

# Setup Barotrauma server
#RUN mkdir --parent /root/.steam/sdk64/\
# && ln /root/.steam/steamcmd/linux64/steamclient.so /home/steam/.steam/sdk64/ --symbolic

RUN steamcmd +force_install_dir "${INSTALL_DIR}" +login anonymous +app_update "${SERVER_ID}" validate +quit
RUN	mkdir --parent "/${HOME}/.local/share/Daedalic Entertainment GmbH/Barotrauma"\
	&& mkdir --parent "/${HOME}/.steam/steamapps/common/Barotruama Dedicated Server"

WORKDIR ${INSTALL_DIR}

ADD "./config_files/${SERVER_NAME}.tar.bz" "${INSTALL_DIR}/"

EXPOSE 27015/udp
EXPOSE 27016/udp

CMD [ "/bin/bash", "-c" ]
ENTRYPOINT [ "init_container.sh" ]
