## Create a new S3 Bucket

``` 
aws s3 mb s3://nwofor936-checksums
```

## Create file that we will do a checksum on
```
echo "Hello" > checkfile.txt
```

## Get Checksum of the file
```
md5sum checkfile.txt
```
-> 09f7e02f1290be211da707a266f153b3  checkfile.txt

## upload the file to s3
```
aws s3api put-object --bucket s3://nwofor936-checksums --key checkfile.txt --body checkfile.txt
```

## uploading the same file with a different type of checksum (AWS will calculate the checksum itself)
```
aws s3api put-object --bucket nwofor936-checksums --key checkfilecrc32.txt --body checkfile.txt --checksum-algorithm CRC32
```
