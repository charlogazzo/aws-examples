require "aws-sdk-sqs"

client = Aws::SQS::Client.new(region: "eu-central-1")

resp = client.send_message({
  queue_url: "https://sqs.eu-central-1.amazonaws.com/492534223967/sqs-standard-queue-MySQSQueue-hBw72SBaAc36", # required
  message_body: "Hello from Ruby!", # required
  delay_seconds: 1,
  message_attributes: {
    "Fruit" => {
      string_value: "Apple",
      data_type: "String", # required
    },
  },
})