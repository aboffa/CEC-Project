#!/bin/bash

#Name of containers
NAME_HELLO_WORLD="my-hello-world-container"
NAME_REDIS="my-redis-container"
NAME_FLASK="my-flask-app"
NAME_NETWORK="main-network"
NAME_LOAD_BALANCER="load-balancer"

#Number of Servers
NUMBER_SERVERS=$1

: '
#Number of Servers
NUMBER_SERVERS=$1
NAME_NETWORK=$2
NAME_REDIS=$3
NAME_FLASK=$4
'

echo $@

#Stop all contanier
echo "Stopping container" 

sudo docker stop $NAME_REDIS

sudo docker stop $NAME_LOAD_BALANCER

declare tmp_name=$NAME_FLASK

for ((i=0; i<$NUMBER_SERVERS;i++))
do
   echo "$i)Stopping container"
   sudo docker stop $tmp_name
   tmp_name+="a"
done

echo "Deleting network"
sudo docker network rm $NAME_NETWORK

echo "Running container now:"
sudo docker ps -a 

echo "Running network" 
sudo docker network ls
