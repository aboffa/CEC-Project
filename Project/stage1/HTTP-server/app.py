from flask import Flask
import redis
import os
import socket
import sys
 
# 'REDIS_PORT_6379_TCP_ADDR': '172.17.0.2', 'REDIS_PORT_6379_TCP_PORT': '6379',
#r = redis.StrictRedis(host=os.environ["REDIS_PORT_6379_TCP_ADDR"], port=os.environ["REDIS_PO$

#def setup(arg):
    #print("ARGUMENTS------------------------->" + arg[0]) 
r = redis.StrictRedis(host="my-redis-container", db=0)

app = Flask(__name__)

def factorial (n):
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result

@app.route('/')
def hello_world() :
    try:
        key = r.randomkey()
        n = r.get(key)
        toreturn = str(factorial(int(n)))
        html = "<p><b>The result is :%s! = %s</b></p>" %(n, toreturn)
        return html,200
    except Exception as e:
      print("type error: " + str(e))
      return "error"+str(e)+"\n",500


if __name__ == '__main__':
#    setup(sys.argv[1:])
    app.run(debug=True, host='0.0.0.0', port="80")



