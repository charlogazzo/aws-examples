## create subnet group

```sh
aws memorydb create-subnet-group \
    --subnet-group-name mysubnetgroup-2azs \
    --description "my subnet group" \
    --subnet-ids subnet-0e128e44ad69292f9, subnet-06f450140eb1baf89
```

## create user
```sh
aws memorydb create-user \
    --user-name memory-db-user \
    --access-string "~objects:* ~items:* ~public:*" \
     --authentication-mode \
         Passwords="Marvelous.Marvin13",Type=password
```

## create an ACL
```sh
aws memorydb create-acl \
    --acl-name "mem-db-acl-1" \
    --user-names "memory-db-user"
```

## create a cluster
```sh
aws memorydb create-cluster \
    --cluster-name memory-db-cluster \
    --node-type db.r7g.large \
    --acl-name mem-db-acl-1 \
    --subnet-group mysubnetgroup-2azs
```