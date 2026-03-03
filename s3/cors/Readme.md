## create a bucket

```sh
aws s3 mb s3://nwofor936-cors-2
```

## change block public access

```sh
aws s3api put-public-access-block \
--bucket nwofor936-cors-2 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```
 
## create a bucket policy

```sh
aws s3api put-bucket-policy --bucket nwofor936-cors-2 --policy file://policy.json
```

## turn on static website hosting

```sh
aws s3api put-bucket-website --bucket nwofor936-cors-2 --website-configuration file://website.json
```

## upload an index.html file and include a resource that would be cross-origin

```sh
aws s3 cp hello.js s3://nwofor936-cors-2
```

## access website

http://nwofor936-cors-2.s3-website.eu-central-1.amazonaws.com

## Apply a CORS policy 

## create API gateway with mock response and then test the endpoint

curl -X POST "https://zgxzvf6zt9.execute-api.eu-central-1.amazonaws.com/PROD" \
  -H "Content-Type: application/json"
