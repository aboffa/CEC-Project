from flask import Flask, redirect
import os
import socket
from threading import Thread
import time

app = Flask(__name__)

number_servers = os.environ['NUMBER_SERVERS']
# array containing the all the port of the web servers
ports = []
tmp_name ="my-flask-app"
starting_port = 5001

port = int(starting_port)

for i in range(int(number_servers)):
    ports.append(str(port))
    port += 1
    tmp_name = tmp_name+"a"

index = 0

'''
Ping HTTP servers in order to undertand if they are up
def threaded_function(arg):
    for i in range(arg):
        print("running")
        time.sleep(1)
'''

@app.route('/')
def redirect_to_servers() :
    try:
        global index
        global number_servers
        port_to_redirect = ports[index]
        index += 1
        index = index % int(number_servers)
        return redirect("http://0.0.0.0:"+port_to_redirect, code=302)
    except Exception as e:
        print("ERROR---->"+ str(e))
        return("error\n"+str(e))

if __name__ == '__main__':
    #thread = Thread(target = threaded_function, args = (10, ))
    #thread.start()
    app.run(debug=True, host='0.0.0.0', port="80")

