!# /usr/bin/bash

aws cloudformation deploy \
    --template-file cloudformation.yaml \
    --stack-name postgres-demo \
    --capabilities CAPABILITY_NAMED_IAM