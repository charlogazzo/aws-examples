## create input and output s3 buckets
```sh
aws s3 mb s3://nwofor936-mc-input
aws s3 mb s3://nwofor936-mc-output
```

## find the account specific endpoint
```sh
aws mediaconvert describe-endpoints --region eu-central-1
```

## create the job
```sh
aws mediaconvert create-job \
--region eu-central-1 \
--endpoint-url https://mediaconvert.eu-central-1.amazonaws.com \
--cli-input-json file://job.json
```

## check status
```sh
aws mediaconvert get-job \
--endpoint-url https://mediaconvert.eu-central-1.amazonaws.com \
--region eu-central-1 \
--id 1779447255066-xjks7a
```