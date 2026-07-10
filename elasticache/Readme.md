## create serverless cache
```sh
aws elasticache create-serverless-cache \
--serverless-cache-name my-redis-cache \
--major-engine-version 7
```

## install redis cli (Ubuntu)
```sh
sudo apt-get install lsb-release curl gpg
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
sudo chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
sudo apt-get update
sudo apt-get install redis
```

## start redis-cli
```sh
redis-cli
```

## connect to elasticache instance
```sh
redis-cli -h my-redis-cache-padtrw.serverless.euc1.cache.amazonaws.com:6379
redis6-cli --tls -h my-redis-cache-padtrw.serverless.euc1.cache.amazonaws.com -p 6379
```

## create a replication group
```sh
aws elasticache create-replication-group \
    --replication-group-id "redis-1" \
    --replication-group-description "my-redis-replication-group" \
    --engine "redis" \
    --cache-node-type "cache.m5.large"
```

## create a global datastore to reduce latency for users worldwide
```sh
aws elasticache create-global-replication-group \
    --global-replication-group-id-suffix my-redis-global-replication-group \
    --primary-replication-group-id "redis-1"
```