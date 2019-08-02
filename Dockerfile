# VirtualBox in a container
# thanks to Jérémy DECOOL for the starting point
#
# USAGE :
#   docker run -d \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -e DISPLAY=unix$DISPLAY \
#     --privileged \
#     --name virtualbox \
#     ollum/virtualbox

FROM ubuntu:18.04
MAINTAINER Marc Woge <marc.woge@gmail.com>

RUN apt-get update && apt-get install -y \
 # ca-certificates \
  linux-headers-generic \
  gpg-agent \
  curl \
  software-properties-common \
  --no-install-recommends && \
 # curl -sSL https://www.virtualbox.org/download/oracle_vbox.asc | apt-key add - && \
 # echo "deb http://download.virtualbox.org/virtualbox/ubuntu bionic contrib" >> /etc/apt/sources.list.d/virtualbox.list && \
  apt-get update && \
  apt-get install -y \
  virtualbox \
  virtualbox-dkms \
  virtualbox-ext-pack \
  && rm -rf /var/lib/apt/lists/*

ENTRYPOINT	[ "/usr/bin/virtualbox" ]
