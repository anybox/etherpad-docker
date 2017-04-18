etherpad-docker
===============

This is a Docker image which is nothing more than the basic test Etherpad setup as described on https://github.com/ether/etherpad-lite.
(All of these instructions are as root.) To download the image from the Docker index, run:

Warning: no settings.json file. Must add it manually or with docker Volume at /opt/etherpad/settings.json

`docker pull anybox/etherpad`

To run Etherpad on port 9001, run:

`docker run -d -p 9001:9001 anybox/etherpad`

To run Etherpad on port 80, run:

`docker run -d -p 80:9001 anybox/etherpad`
