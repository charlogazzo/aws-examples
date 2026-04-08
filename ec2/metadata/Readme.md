## require tokens to access instance metadata (IMDSv2)

```sh
aws ec2 modify-instance-metadata-options \
    --instance-id i-0b506eeb6b25255c0 \
    --http-tokens required \
    --http-endpoint enabled
```
 