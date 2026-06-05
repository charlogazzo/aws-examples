require "aws-sdk-sqs"

client = Aws::SQS::Client.new(region: "eu-central-1")

resp = client.receive_message({
  queue_url: "https://sqs.eu-central-1.amazonaws.com/492534223967/sqs-standard-queue-MySQSQueue-hBw72SBaAc36", # required
  attribute_names: ["All"], # accepts All, Policy, VisibilityTimeout, MaximumMessageSize, MessageRetentionPeriod, ApproximateNumberOfMessages, ApproximateNumberOfMessagesNotVisible, CreatedTimestamp, LastModifiedTimestamp, QueueArn, ApproximateNumberOfMessagesDelayed, DelaySeconds, ReceiveMessageWaitTimeSeconds, RedrivePolicy, FifoQueue, ContentBasedDeduplication, KmsMasterKeyId, KmsDataKeyReusePeriodSeconds, DeduplicationScope, FifoThroughputLimit, RedriveAllowPolicy, SqsManagedSseEnabled
  message_system_attribute_names: ["All"], # accepts All, SenderId, SentTimestamp, ApproximateReceiveCount, ApproximateFirstReceiveTimestamp, SequenceNumber, MessageDeduplicationId, MessageGroupId, AWSTraceHeader, DeadLetterQueueSourceArn
  message_attribute_names: ["All"],
  max_number_of_messages: 1,
  visibility_timeout: 1,
  wait_time_seconds: 1,
  receive_request_attempt_id: "String",
})

puts resp.messages[0].body
