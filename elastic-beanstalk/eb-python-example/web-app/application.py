import json
import os

from flask import Flask, jsonify, request
import boto3

app = Flask(__name__)

sqs = boto3.client('sqs', region_name=os.environ.get('AWS_DEFAULT_REGION', 'eu-central-1'))

QUEUE_URL = os.environ.get('SQS_QUEUE_URL')

@app.route('/')
def home():
    return 'Web App is running!'

@app.route('/process', methods=['POST'])
def process():
    payload = request.json

    sqs.send_message(
        QueueUrl=QUEUE_URL,
        MessageBody=json.dumps(payload)
    )

    return jsonify({
        "status": "queued"
    })
