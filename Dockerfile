# Etherpad-Lite Dockerfile
#
# https://github.com/ether/etherpad-docker
#
# Developed from a version by Evan Hazlett at https://github.com/arcus-io/docker-etherpad 
# Developed from a version by John E. Arnold at https://github.com/ether/etherpad-docker.
#
# Version 1.0

# Use Docker's nodejs, which is based on ubuntu
FROM node:latest
MAINTAINER Simon ANDRÉ, Anybox (https://anybox.fr)

# Get Etherpad-lite's other dependencies
RUN apt-get update
RUN apt-get install -y gzip git-core curl python libssl-dev pkg-config build-essential

# Grab the latest Git version
RUN cd /opt && git clone https://github.com/ether/etherpad-lite.git etherpad

# Install node dependencies
RUN /opt/etherpad/bin/installDeps.sh

# patch PostgreSQL client lib to fix MD5 authentication,
# while waiting for it to be fixed all the way, see
# - https://github.com/Pita/ueberDB/pull/93,
# - https://github.com/ether/etherpad-lite/issues/3180
ADD pg_md5_auth.patch /root
RUN cd /opt/etherpad/node_modules/ep_etherpad-lite/node_modules/pg && patch -p1 < /root/pg_md5_auth.patch

EXPOSE 9001
CMD ["node", "/opt/etherpad/node_modules/ep_etherpad-lite/node/server.js"]
