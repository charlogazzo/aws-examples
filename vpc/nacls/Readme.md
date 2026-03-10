## get vpc ID

```sh
VPC_ID=$(aws ec2 describe-vpcs \
    --filters "Name=tag:Name,Values=nacl-vpc" \
    --query 'Vpcs.VpcId' \
    --output text)
```

# create the nacl

```sh
aws ec2 create-network-acl --vpc-id vpc-05f8f617f1ea262c0
```

# get the image ID of an aws image
```sh
aws ec2 describe-images \
    --owners amazon \
    --filters "Name=name,Values=*al2023-ami-2023*" "Name=name,Values=*kernel-6.1*" "Name=state,Values=available" \
    --query 'sort_by(Images, &CreationDate)[-1].[ImageId]' \
    --output text
```

# add acl entry
```sh
aws ec2 create-network-acl-entry \
--network-acl-id acl-09cb3aefe1f95d510 \
--ingress \
--rule-number 90 \
--protocol -1 \
--port-range From=0,To=65535 \
--cidr-block 93.219.126.92/32 \
--rule-action deny
```
