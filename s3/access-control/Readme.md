## create a new bucket
```sh
aws s3 mb s3://nwofor936-access-control
```

## Turn off Block public access for ACLs

```sh
aws s3api put-public-access-block \
--bucket nwofor936-access-control \
--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=true,RestricPublicBuckets=true"
```


## check public access status
```sh
aws s3api put-public-access-block --bucket nwofor936-access-control
```


## change bucket ownership
```sh
aws s3api put-bucket-ownership-controls \
--bucket nwofor936-access-control \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPreferred}]"
```
