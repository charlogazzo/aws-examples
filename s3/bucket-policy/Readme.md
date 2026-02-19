## create a bucket

aws s3 mb s3://nwofor936-bucket-policy-1


## add a bucket policy
aws s3api put-bucket-policy --bucket nwofor936-bucket-policy-1 --policy file://policy.json

## Using the account that permission was granted to in the JSON policy file (from within the console)

aws s3 ls s3://nwofor936-bucket-policy-1