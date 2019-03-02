#!/bin/bash

#
# This is bash script placeholder. Write here all the commands necessary to pass Stage 2 steps A and B.
#

NUMBER_SERVERS=$1
echo "Creating $1 servers"

sudo docker service create --name registry --publish published=5000,target=5000 registry:2

sudo docker swarm init

sudo docker stack deploy -c docker-compose.yml stage2

sleep 10

