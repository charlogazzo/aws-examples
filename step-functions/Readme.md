## create bucket

```sh
aws s3 mb s3://nwofor-936-step-functions
```

## Enable eventbride communication

```sh
aws s3api put-bucket-notification-configuration \
--bucket nwofor-936-step-functions \
--notification-configuration '
{
  "EventBridgeConfiguration": {

  }
}'
```

## uplkad file to s3 (to trigger eventbridge)
```sh
aws s3 cp test_image.png s3://nwofor-936-step-functions/test_image.png
```
