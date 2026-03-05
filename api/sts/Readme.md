## create a user with no permissions

```sh
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user --output table
```

## apply the new credentials

```sh
aws configure
```

### afterwards edit the credentials file to change away from the default credentials
```sh
open ~/.aws/credentials
```

## create a role (by delpoying the template)
```sh
chmod u+x bin/deploy
./bin/deploy
```

## give the user permissions to assume the role
```sh
aws iam put-user-policy \
    --user-name sts-machine-user \
    --policy-name sts-s3-policy \
    --policy-document file://policy.json
``` 

## Use the new user credentials and assume the role
```sh
aws sts assume-role \
--role-arn arn:aws:iam::492534223967:role/nwofor-936-iam-full-access-role \
--role-session-name iam-s3-access \
--profile sts
```

## verify the caller identity of the new profile
```sh
aws sts get-caller-identity --profile assumed
```

## list buckets using the new assumed profile
```sh
aws s3 ls --profile assumed
```

## delete user policy
