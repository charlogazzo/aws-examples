import {
  DynamoDBClient,
  UpdateItemCommand
} from "@aws-sdk/client-dynamodb";

const db = new DynamoDBClient({
  region: process.env.AWS_REGION
});

export const handler = async (event) => {

  for (const record of event.Records) {

    const payload = JSON.parse(
      Buffer.from(record.kinesis.data, "base64").toString()
    );

    await db.send(
      new UpdateItemCommand({
        TableName: "PageStats",
        Key: {
          page: { S: payload.page }
        },
        UpdateExpression:
          "ADD clickCount :inc",
        ExpressionAttributeValues: {
          ":inc": { N: "1" }
        }
      })
    );
  }
};
