## create a bucket

aws s3 mb s3://nwofor936-metadata

## create a new file

echo "Hello" > hello.txt

## upload file with metadata

aws s3api put-object --bucket nwofor936-metadata --key hello.txt --body hello.txt --metadata ide=vscode

## retrieve metadata through head object

aws s3api head-object --bucket nwofor936-metadata --key hello.txt

