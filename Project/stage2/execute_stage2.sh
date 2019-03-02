#!/bin/bash

#
# This is bash script placeholder. Write here all the commands necessary to pass Stage 2 steps A and B.
#

NUMBER_SERVERS=$1
echo "Creating $1 servers"

sudo docker swarm init

sudo docker stack deploy -c docker-compose.yml stage2

sleep 10

