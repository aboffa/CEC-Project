#!/bin/bash

#
# This is bash script placeholder. Write here all the commands necessary to pass Stage 2 steps A and B.
#
NUMBER_SERVERS=$1
echo "Creating $1 servers"
#sudo docker-compose up --scale web=$NUMBER_SERVERS
sudo docker swarm init --scale web=$NUMBER_SERVERS --advertise-addr 127.0.0.2


