## convert policy to JSON

yq -0 json policy.yaml > policy.json


# create the policy

```sh
aws iam create-policy     --policy-name my-cli-policy     --policy-document file://policy.json
```

## attach user policy
```sh
aws iam attach-user-policy \
    --policy-arn arn:aws:iam::492534223967:policy/my-cli-policy \
    --user-name third_user
```


## create policy version
```sh
aws iam create-policy-version \
    --policy-arn arn:aws:iam::492534223967:policy/my-cli-policy \
    --policy-document "(yq -o json policy.yaml)" \
    --set-as-default
```
