from flask import Flask, redirect
import os
import socket
import sys
from threading import Thread
import time

app = Flask(__name__)

number_servers = os.environ['NUMBER_SERVERS']
#separat addresses
servers = []
ports = []
tmp_name ="my-flask-app"
for i in range(int(number_servers)):
    port = int(5001 + i)
    #servers.append(tmp_name+":"+ str(port))
    servers.append(str(port))
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
        address_to_redirect = servers[index]
        index += 1
        index = index % int(number_servers) 
        return redirect("http://127.0.0.1:"+address_to_redirect, code=302)
    except Exception as e:
        print("ERROR---->"+ str(e))
        return("error\n"+str(e))

if __name__ == '__main__':
#    setup(sys.argv[1:])
    #thread = Thread(target = threaded_function, args = (10, ))
    #thread.start()
    app.run(debug=True, host='0.0.0.0', port="80")

