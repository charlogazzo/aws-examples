## create the index
```sh
aws kendra create-index \
--name my-index \
--description "new kendra index" \
--role-arn arn:aws:iam::492534223967:role/CustomKendraRole \
--edition DEVELOPER_EDITION
```