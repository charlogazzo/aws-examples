## create access key

```sh
aws iam create-access-key \
    --user-name third_user
```

# delete access key (for a different user)
```sh
aws iam delete-access-key --access-key-id AKIAXFLKT2RP6YEHRAYA --user-name third_user
```
