## cretae a vpc with an ipv6 cidr block
```sh
aws ec2 create-vpc --cidr-block 192.168.1.0/24 --amayon-provided-ipv6-cidr-block
```

## create a subnet using the ipv6 address range provided by aws
```sh
aws ec2 create-subnet --vpc-id vpc-0920242840042af01 --cidr-block 192.168.1.0/28 --ipv6-cidr-block 2a05:d014:b84:1b00::/64
```

## enable dns for ipv6
```sh
aws ec2 modify-subnet-attribute --subnet-id subnet-0ded8243acf709745 --enable-dns64
```

## create an egress-only internet gateway
```sh
aws ec2 create-egress-only-internet-gateway --vpc-id vpc-0920242840042af01
```

## create an internet gateway
```sh
aws ec2 create-internet-gateway --vpc-id vpc-0920242840042af01
```

## attach internet gateway
```sh
aws ec2 attach-internet-gateway --internet-gateway-id igw-0123456789abcdef0 --vpc-id vpc-0920242840042af01
```

## create route table
```sh
aws ec2 create-route-table --vpc-id vpc-0920242840042af01
```

## create nat gateway
```sh
aws ec2 create-nat-gateway --vpc-id vpc-0920242840042af01 --subnet-id subnet-0ded8243acf709745
```

## add routes to the gateway
```sh
aws ec2 create-route --route-table-id rtb-045457452df13911 --destination-prefix 64:ff9b::/96 --nat-gateway-id nat-0a1b2c3d4e5f6g7h8

aws ec2 create-route --route-table-id rtb-045457452df13911 --destination-prefix ::/0 --egress-only-internet-gateway-id eigw-0ded8243acf709745

aws ec2 create-route --route-table-id rtb-045457452df13911 --destination-prefix 0.0.0.0/0 --gateway-id 0123456789abcdef0
```
