# Register Job (take note of the task execution role).
# ECS [Fargate] cannot perform operations like writing to logs and pulling images without the role
```sh
aws batch register-job-definition \
  --job-definition-name square-job \
  --type container \
  --platform-capabilities FARGATE \
  --container-properties '{
    "image": "492534223967.dkr.ecr.eu-central-1.amazonaws.com/square-app:latest",
    "executionRoleArn": "arn:aws:iam::492534223967:role/ecsTaskExecutionRole",
    "resourceRequirements": [
      {
        "type": "VCPU",
        "value": "0.25"
      },
      {
        "type": "MEMORY",
        "value": "512"
      }
    ],
    "networkConfiguration": {
      "assignPublicIp": "ENABLED"
    }
  }'
```

# create job queue
```sh
aws batch create-job-queue --job-queue-name HighPriority --state ENABLED --priority 1 --compute-environment-order '[
{
    "order": 1,
    "computeEnvironment": "arn:aws:batch:eu-central-1:492534223967:compute-environment/compute-env"
}
]' 
```

# Submit job
```sh
aws batch submit-job --job-name my-job --job-queue HighPriority  --job-definition square-job
```


# Log in to ECR
```sh
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin 492534223967.dkr.ecr.eu-central-1.amazonaws.com
```

# build docker image (after the build, the URI is used when creating the Job Definition above)
```sh
docker build -t square-app .
```

# tag image
```sh
docker tag square-app:latest 492534223967.dkr.ecr.eu-central-1.amazonaws.com/square-app:latest
```

# push the image
```sh
docker push 492534223967.dkr.ecr.eu-central-1.amazonaws.com/square-app:latest
```