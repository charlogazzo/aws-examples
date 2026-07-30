import boto3

client = boto3.client('comprehend')
text = "This is the first sentence in Charles' boto3 usage of Amazon Comprehend."

response = client.detect_sentiment(
    Text=text,
    LanguageCode='en'
)

print(response)
