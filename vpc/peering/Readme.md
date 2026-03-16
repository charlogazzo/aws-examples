## create a VPC connection (from A to B)
```sh
aws ec2 create-vpc-peering-connection --vpc-id vpc-0cb8773460c4c5af2 --peer-vpc-id vpc-08c34277a85be22be
```

## accept the connection request (expires in 7 days)
```sh
aws ec2 accept-vpc-peering-connection --vpc-peering-connection-id pcx-0e313d8fa68ddc6b8
```

### add routes for the vpcs (both ways)
```sh
aws ec2 create-route --route-table rtb-0f76965cb33be34a2 --destination-cidr-block 11.0.0.0/16 --vpc-peering-connection pcx-0e313d8fa68ddc6b8
aws ec2 create-route --route-table rtb-05745a3280967265f --destination-cidr-block 10.0.0.0/16 --vpc-peering-connection pcx-0e313d8fa68ddc6b8
```