#!/bin/bash

#Number of Servers
NUMBER_SERVERS=$1
NAME_NETWORK=$2
NAME_REDIS=$3
NAME_FLASK=$4

echo $@

#Stop all contanier
echo "Stopping container" 

sudo docker stop $NAME_REDIS

sudo docker stop $NAME_FLASK

#sudo docker stop $NAME_LOAD_BALANCER

declare tmp_name=$NAME_FLASK
declare -i port=0

for ((i=0; i<$NUMBER_SERVERS;i++))
do
   echo "$i)Stopping container"
   port=$((5000+$i)) 
   sudo docker stop $tmp_name
   tmp_name+="a"
done

echo "Deleting network"
sudo docker network rm $NAME_NETWORK

echo "Running container now:"
sudo docker ps -a 

echo "Running network" 
sudo docker network ls
