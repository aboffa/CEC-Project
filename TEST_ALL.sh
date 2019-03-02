#!/bin/bash

#STAGE 1

# 5 servers
cd Project/stage1 && sudo bash ./execute_stage1.sh 5 

cd /home/cecuser

python3 -u cec_benchmark.py 0.0.0.0:80  | tee output-stage1-5.txt

cd Project/stage1 && sudo bash ./cleanUp.sh 5 

cd /home/cecuser
: 
# 3 servers
cd Project/stage1 && sudo bash ./execute_stage1.sh 3

cd /home/cecuser

python3 -u cec_benchmark.py 0.0.0.0:80 | tee output-stage1-3.txt

cd Project/stage1 && sudo bash ./cleanUp.sh 3

cd /home/cecuser

# 1 server
cd Project/stage1 && sudo bash ./execute_stage1.sh 1

cd /home/cecuser

python3 -u  cec_benchmark.py 0.0.0.0:80 | tee output-stage1-1.txt

cd Project/stage1 && sudo bash ./cleanUp.sh 1

cd /home/cecuser

#STAGE 2

cd Project/stage2 && sudo bash ./execute_stage2.sh

cd /home/cecuser

sudo docker ps -a 

python3 -u cec_benchmark.py 0.0.0.0:80 | tee output-stage2-5.txt

python3 -u cec_benchmark.py 0.0.0.0:81 | tee output-stage2-3.txt

python3 -u cec_benchmark.py 0.0.0.0:82 | tee output-stage2-1.txt

cd Project/stage2 && sudo bash ./cleanUp.sh 

cd /home/cecuser