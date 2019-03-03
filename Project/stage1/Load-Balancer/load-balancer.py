from flask import Flask, redirect
import os
import socket
import threading
import time
import requests

app = Flask(__name__)

number_servers_string = os.environ['NUMBER_SERVERS']
number_servers = int(number_servers_string)
# array containing the all the port of the web servers
ports = []
tmp_name ="my-flask-app"
starting_port = 5001
index = 0
lock = threading.Lock()

#Setting up ports
port = int(starting_port)
for i in range(number_servers):
    ports.append(str(port))
    port += 1
    tmp_name = tmp_name+"a"

#Ping HTTP servers in order to undertand if they are up
def check_status_servers(arg):
        myindex = 0
        global ports
        global lock
        while True:
                #Wait 10 seconds
                time.sleep(10)

                port_to_ping = ports[myindex]
                responce = requests.get("http://0.0.0.0:"+port_to_ping+"/ping", headers={'Connection':'close'})
                if responce.status_code != "200":
                        # Server isnt working
                        ports[myindex] = None
                else:
                        lock.acquire()
                        # Now its working again
                        ports[myindex] = port_to_ping
                        lock.release()
                myindex = (myindex + 1) % number_servers


@app.route('/')
def redirect_to_servers() :
    try:
        global index
        global number_servers
        lock.acquire()
        counter = 0
        while ports[index] == None:
                if counter > number_servers:
                        return "All servers are down, please wait",500
                index = (index + 1) % number_servers
                counter += 1
        lock.release()
        port_to_redirect = ports[index]
        index = (index + 1) % number_servers
        return redirect("http://0.0.0.0:"+port_to_redirect, code=302)        
    except Exception as e:
        print("ERROR---->"+ str(e))
        return("error\n"+str(e))

if __name__ == '__main__':
    t = threading.Thread(target = check_status_servers)
    t.start()
    app.run(debug=True, host='0.0.0.0', port="80")

