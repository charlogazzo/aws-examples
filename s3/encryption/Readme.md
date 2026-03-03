## create s3 bucket

aws s3 mb s3://nwofor936-encryption

# create a file

echo "Hello" > hello.txt

# put object with encryption of KMS (using customer encryption)
# the difference was made when using openssl md5 to perform the md5 calculation

export BASE64_ENCODED_KEY=$(openssl rand 32 | base64)
echo $BASE64_ENCODED_KEY

export MD5_VALUE=$(echo -n $BASE64_ENCODED_KEY | base64 --decode | openssl md5 -binary | base64)
echo $MD5_VALUE

aws s3api put-object \
--bucket nwofor936-encryption \
--key hello.txt \
--body hello.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE

# download the file
aws s3api get-object \
--bucket nwofor936-encryption \
--key hello.txt \
./downloaded.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE
