## elb target health check
```sh
aws elbv2 describe-target-health \
    --target-group-arn $(aws cloudformation describe-stack-resource \
        --stack-name load-balancer-demo \
        --logical-resource-id TargetGroup \
        --query 'StackResourceDetail.PhysicalResourceId' \
        --output text)
```

## retrive the alb dns
```sh
aws cloudformation describe-stacks \
    --stack-name load-balancer-demo \
    --query "Stacks[0].Outputs[?OutputKey=='LoadBalancerDNS'].OutputValue" \
    --output text
```

## delete stack
```sh
aws cloudformation delete-stack \
    --stack-name load-balancer-demo
```

## wait for deletion
```sh
aws cloudformation wait stack-delete-complete \
    --stack-name load-balancer-demo
```