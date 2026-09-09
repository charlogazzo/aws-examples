from flask import Flask
import socket
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return {
        "message": "Hello from ECS!",
        "hostname": socket.gethostname(),
        "environment": os.getenv("ENVIRONMENT", "unknown")
    }

@app.route("/health")
def health():
    return "OK", 200

app.run(host="0.0.0.0", port=8080)
