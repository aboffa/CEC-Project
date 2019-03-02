#!/bin/bash

# 5 servers
cd Project/stage1 && sudo bash ./execute_stage1.sh 5 

cd /home/cecuser

python3 cec_benchmark.py 0.0.0.0:80  > output-stage1-5.txt

cd Project/stage1 && sudo bash ./cleanUp.sh 5 

# 3 servers
cd Project/stage1 && sudo bash ./execute_stage1.sh 3

cd /home/cecuser

python3 cec_benchmark.py 0.0.0.0:80 > output-stage1-3.txt

cd Project/stage1 && sudo bash ./cleanUp.sh 3

# 1 server
cd Project/stage1 && sudo bash ./execute_stage1.sh 1

cd /home/cecuser

python3 cec_benchmark.py 0.0.0.0:80 > output-stage1-1.txt

cd Project/stage1 && sudo bash ./cleanUp.sh 1