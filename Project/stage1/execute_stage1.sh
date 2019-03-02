#!/bin/bash

#
# This is bash placeholder. Write here all the commands necessary to pass Stage 1 steps A through D.
#

#Name of containers
NAME_HELLO_WORLD="my-hello-world-container"
NAME_REDIS="my-redis-container"
NAME_FLASK="my-flask-app"
NAME_NETWORK="main-network"
NAME_LOAD_BALANCER="load-balancer"

#Number of Servers
NUMBER_SERVERS=$1

#Ports 
PORT_SINGLE_HTTP=5000
START_PORT=5000

echo "Running container now:"
sudo docker ps -a 

sudo docker run --rm --name $NAME_HELLO_WORLD -d hello-world

#Creating network 
sudo docker network create $NAME_NETWORK

sudo docker run --rm --network $NAME_NETWORK --name $NAME_REDIS -v /var/cec/redis.rdb:/data/dump.rdb -d redis 

sleep 7

#Http servers istances
cd HTTP-server &&  sudo docker build -t http-server:latest .

declare tmp_name=$NAME_FLASK
declare -i port=5001

for ((i = 0; i < $NUMBER_SERVERS;i ++))
do
   echo "$i) Running HTTP server on $tmp_name $port"
   sudo docker run --cpus=".5" --rm --network $NAME_NETWORK --name $tmp_name -p $port:80 -d  http-server:latest
   port+=1
   tmp_name+="a"
   sleep 1
done
: '
sleep 5

port = 5000
for ((i=0; i<$NUMBER_SERVERS;i++))
do
   port += 1
   curl 0.0.0.0:$port
done
'
#LoadBalancer 

cd .. && cd Load-Balancer && sudo docker build -t load-balancer .

#docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $NAME_FLASK 

sudo docker run --rm -e NUMBER_SERVERS=1 --network $NAME_NETWORK --name $NAME_LOAD_BALANCER -p 80:80 -d load-balancer

sleep 1

sudo docker ps -a 
: '
for ((i=0; i<$NUMBER_SERVERS;i++))
do
    curl -L 0.0.0.0:80
done
'

#cd .. && sudo bash cleanUp.sh $NUMBER_SERVERS $NAME_NETWORK $NAME_REDIS $NAME_FLASK