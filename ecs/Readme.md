############ GENERATED FROM AI CODING ###############

## create an app (python-flask)

## dockerize the app
```sh
docker build -t ecs-demo .
```

## run the app
```sh
docker run -p 8080:8080 ecs-demo
```

## create the ecr repository using yaml
```sh
aws cloudformation deploy \
  --template-file ecr.yaml \
  --stack-name ecs-ecr-lab-ecr \
  --region $AWS_REGION
```

## get and store the ecr uri
```sh
ECR_URI=$(aws ecr describe-repositories \
  --repository-names ecs-demo \
  --region $AWS_REGION \
  --query 'repositories[0].repositoryUri' \
  --output text)

echo $ECR_URI
```

## Authenticate docker with ecr
```sh
aws ecr get-login-password --region $AWS_REGION |
docker login \
  --username AWS \
  --password-stdin $ECR_URI
```

## tag and push the image
```sh
docker tag ecs-demo:latest $ECR_URI:latest
```

## deploy ecs fargate
```sh
aws cloudformation deploy \
  --template-file fargate.yaml \
  --stack-name ecs-fargate-lab \
  --capabilities CAPABILITY_NAMED_IAM \
  --region $AWS_REGION
```

## scale fargate
```sh
aws ecs update-service \
  --cluster ecs-fargate-demo \
  --service ecs-fargate-demo \
  --desired-count 4 \
  --region $AWS_REGION
```

## deploy ec2 ecs
```sh
aws cloudformation deploy \
  --template-file ec2.yaml \
  --stack-name ecs-ec2-lab \
  --capabilities CAPABILITY_NAMED_IAM \
  --region $AWS_REGION
```

