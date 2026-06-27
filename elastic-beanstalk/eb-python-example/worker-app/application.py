import json
import logging

from flask import Flask, request

app = Flask(__name__)

logging.basicConfig(level=logging.INFO)

@app.route('/', methods=['POST'])
def worker():
    sqs_message = request.json

    body = json.loads(sqs_message['Message'])

    logging.info(
        "Processing task: %s", body
    )

    return "OK", 200
