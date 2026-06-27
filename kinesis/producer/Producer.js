import { KinesisClient, PutRecordCommand } from "@aws-sdk/client-kinesis";

const client = new KinesisClient({
  region: "eu-central-1"
});

const pages = [
  "/",
  "/products",
  "/pricing",
  "/contact"
];

setInterval(async () => {
  const page = pages[Math.floor(Math.random() * pages.length)];

  const event = {
    userId: `user-${Math.floor(Math.random() * 1000)}`,
    page,
    action: "click",
    timestamp: new Date().toISOString()
  };

  await client.send(
    new PutRecordCommand({
      StreamName: "clickstream-demo",
      Data: JSON.stringify(event),
      PartitionKey: page
    })
  );

  console.log("Sent:", event);
}, 1000);
