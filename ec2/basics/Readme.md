## create a key pair

```sh
aws ec2 create-key-pair \
  --key-name my-cli-key \
  --query 'KeyMaterial' \
  --output text > my-key.pem
```

## create a security group

```sh
aws ec2 create-security-group \
  --group-name my-cli-sg \
  --description "My security group"
```

## allow port 22 in the sg
```sh
aws ec2 allow-security-group-ingress \
    --group-name my-cli-sg
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0
```
