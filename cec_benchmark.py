#!/usr/bin/python3
#
# This is a python3 program that runs a benchmark test against a web service and measures latency.
#   It sends a batch of HTTP requests in several different iterations. For iteration uses one thread to send
#   requests sequentially. Second iteration uses two threads to dispatch a same amount of requests, but
#   simultaneously. Third iteration uses three threads and so on. The last iteration uses 20 threads to
#   send requests out simultaneously.
#
#   It prints out the measured latency times in stdout. Format is as follows:
#       [# threads], [mean latency], [standard deviation], [min], [max]
#
#   Example usage:
#       ./cec_benchmark.py 127.0.0.1:8080
#
#   This piece of code was written explicitly for the Cloud and Edge Computing course project. Using this
#       outside the scope of this project on external services can be considered as ill behaviour, spam,
#       ddos and whatnot. Don't do it.
#
#   - Otto
#

import sys, threading, time, random, math
import numpy as np
import requests

def query_thread(addr, n, res):

    while n > 0:
        try:
            #print(n)
            latency = requests.get("http://"+addr, headers={'Connection':'close'}).elapsed.total_seconds()
            if latency > 1:
                # Docker suffers from a problem caused by a race condition related to iptables, which causes dropped SYN packets.
                #   It leads to timeouts of more than one second. If we encounter latency that high to our localhost,
                #   we blatantly assume it's due to this issue, discard the result, wait for 100 ms and try again. 
                #
                # For the curious, you can read more here:
                #   https://tech.xing.com/a-reason-for-unexplained-connection-timeouts-on-kubernetes-docker-abd041cf7e02
                time.sleep(0.1)
                continue
            
            res.append(latency)
            
        except Exception as e:
            print(e)
            pass

        n -=1

        
def dispatcher(address, n_threads):

    requests_per_iteration = 60
    
    print("# Stats from "+str(address)) 
    print("# [n], [mean], [std.], [min], [max]")
    for n in n_threads:
        threads = []
        results = []
        rounds = math.ceil(requests_per_iteration / float(n))
        
        for i in range(0,n):
            threads.append(threading.Thread(target=query_thread, args=[address, rounds, results]))

        for t in threads:
            t.start()
    
        for t in threads:
            t.join()
        
        min_val = round(np.min(results)*1000, 3)
        max_val = round(np.max(results)*1000, 3)
        std = round(np.std(results)*1000, 3)
        mean = round(np.mean(results)*1000, 3)
        print(str(n)+", "+str(mean)+", "+str(std)+", "+str(min_val)+", "+str(max_val))


        
def main():

    if len(sys.argv) < 2:
        print("Usage: ./cec_benchmark.py [host-address]")
        return

    addresses = sys.argv[1:]
    print(addresses)
    n_threads = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    
    for addr in addresses:
        try:
            requests.get("http://"+addr, headers={'Connection':'close'})
        except Exception as e:
            print(e)
            print("Is \""+addr+"\" a valid hostname?")
            break
        
        dispatcher(addr, n_threads)
    
if __name__ == "__main__":
    main()

