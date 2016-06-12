FROM ubuntu:14.04.2
MAINTAINER Kai Mallea <kmallea@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV STEAMCMD_DEPENDS lib32gcc1 curl
ENV STEAMCMD_URL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
ENV REFRESHED_AT 2015-07-19

# install dependencies
RUN apt-get update && \
    apt-get install -y $STEAMCMD_DEPENDS

# install steam
RUN mkdir /opt/steam &&\
    cd /opt/steam &&\
    curl -s https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -vxz 

WORKDIR /opt/steam

# install csgo
RUN mkdir /opt/csgo && \
    ./steamcmd.sh \
        +login anonymous \
        +force_install_dir /opt/csgo \
        +app_update 740 validate \
        +quit

CMD ["/bin/bash"]
