#!/bin/bash

#STAGE 2

cd Project/stage2 && sudo bash ./execute_stage2.sh

cd /home/cecuser

sudo docker ps -a 

python3 -u cec_benchmark.py 0.0.0.0:800 | tee output-stage2-5.txt

docker service  scale stage2_web=3

python3 -u cec_benchmark.py 0.0.0.0:801 | tee output-stage2-3.txt

docker service  scale stage2_web=1

python3 -u cec_benchmark.py 0.0.0.0:802 | tee output-stage2-1.txt

cd Project/stage2 && sudo bash ./cleanUp.sh 

cd /home/cecuser