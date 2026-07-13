## export variables
```sh
export DOMAIN_NAME="test-genie.com"
export HOSTED_ZONE_ID="Z03332821GGSUKTYD7W1U"
export API_NAME="demo-api"
```

## create a regional API Gateway API
```sh
API_ID=$(aws apigatewayv2 create-api \
  --name $API_NAME \
  --protocol-type HTTP \
  --target https://httpbin.org/get \
  --query 'ApiId' --output text)
```

## get the api endpoint
```sh
API_ENDPOINT=$(aws apigatewayv2 get-api \
  --api-id $API_ID \
  --query 'ApiEndpoint' --output text)
```

##### Step 2 #####
## Request an ACM ccertificate
```sh
CERT_ARN=$(aws acm request-certificate \
  --region us-east-1 \
  --domain-name $DOMAIN_NAME \
  --validation-method DNS \
  --query 'CertificateArn' --output text)
```

## use the certificate arn to request the dns record
```sh
aws acm describe-certificate \
  --region us-east-1 \
  --certificate-arn $CERT_ARN \
  --query 'Certificate.DomainValidationOptions[0].ResourceRecord'
```

## wait for the certificate to be issued
```sh
aws acm wait certificate-validated \
  --region us-east-1 \
  --certificate-arn $CERT_ARN
```

###### Step 3 ######
# creating the cloudfront distribution

# extract the api gateway hostname
```sh
API_DOMAIN=$(echo $API_ENDPOINT | sed 's#https://##')
echo $API_DOMAIN
```

# replace the placeholders in the cf-config.json
```sh
sed -i "s/REPLACE_API_DOMAIN/$API_DOMAIN/" cf-config.json
sed -i "s#REPLACE_CERT_ARN#$CERT_ARN#" cf-config.json
```

# create the distribution
```sh
CF_DIST_ID=$(aws cloudfront create-distribution \
  --distribution-config file://cf-config.json \
  --query 'Distribution.Id' --output text)

echo $CF_DIST_ID
```

# get the cloudfront domain name
```sh
CF_DOMAIN=$(aws cloudfront get-distribution \
  --id $CF_DIST_ID \
  --query 'Distribution.DomainName' --output text)

echo $CF_DOMAIN
```

###### Step 4 ######

# create the WAF web ACL

```sh
WEB_ACL_ARN=$(aws wafv2 create-web-acl \
  --region us-east-1 \
  --scope CLOUDFRONT \
  --name demo-web-acl \
  --default-action Allow={} \
  --visibility-config SampledRequestsEnabled=true,CloudWatchMetricsEnabled=true,MetricName=demo-web-acl \
  --rules '[{
      "Name":"AWS-AWSManagedRulesCommonRuleSet",
      "Priority":0,
      "OverrideAction":{"None":{}},
      "Statement":{"ManagedRuleGroupStatement":{
          "VendorName":"AWS",
          "Name":"AWSManagedRulesCommonRuleSet"
      }},
      "VisibilityConfig":{
          "SampledRequestsEnabled":true,
          "CloudWatchMetricsEnabled":true,
          "MetricName":"CommonRuleSet"
      }
  }]' \
  --query 'Summary.ARN' --output text)

echo $WEB_ACL_ARN
```

# associate the Web ACL with cloudfront

# first get the distribution arn using the distribution id
```sh
DIST_ARN=$(aws cloudfront get-distribution \
  --id $CF_DIST_ID \
  --query 'Distribution.ARN' --output text)
```

# associate the acl with the distribution
```sh
aws wafv2 associate-web-acl \
  --region us-east-1 \
  --web-acl-arn $WEB_ACL_ARN \
  --resource-arn $DIST_ARN
```

###### step 5 ######

# apply the DNS change (change the resource record sets)
```sh
aws route53 change-resource-record-sets \
  --hosted-zone-id $HOSTED_ZONE_ID \
  --change-batch file://route53-change.json
```

# test the deployment
```sh
aws cloudfront wait distribution-deployed --id $CF_DIST_ID
curl -I https://$DOMAIN_NAME
```
