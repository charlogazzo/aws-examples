import pprint
import time
import boto3
from botocore.exceptions import ClientError

index_name = "my-kendra-index"  # Replace with your Kendra index name
kendra_role_arn = "arn:aws:iam::492534223967:role/CustomKendraRole"
description = "Kendra index created using boto3"


kendra = boto3.client("kendra")

try:
    response = kendra.create_index(
        Name=index_name,
        RoleArn=kendra_role_arn,
        Description=description,
        Edition="DEVELOPER_EDITION"
    )
    
    pprint.pprint(response)

    index_id = response["Id"]
    print(f"Index creation initiated with index ID: {index_id}")

    while True:
        index_response = kendra.describe_index(index_id)
        creation_status = index_response['Status']
        print("Creation Status", creation_status)

        if creation_status != "CREATING":
            break
        time.sleep(10)

    if creation_status == "ACTIVE":
        print("Index is now active")
    else:
        print(f"Index creation failed with status {creation_status}")


except ClientError as e:
    print("Error creating Kendra index:", str(e))
except Exception as e:
    print("Unexpected error:", str(e))

# datasource
s3_bucket = "nwofor936-kendra"
data_source_name = "my-s3-data-source"

try:
    data_source_response = kendra.create_data_source(
        Name="kendra-datasource",
        IndexId="6d424bb8-e84e-40b0-995a-37ad5b7cf5eb",
        Type="S3",
        RoleArn=kendra_role_arn,
        Configuration={
            "S3Configuration": {
                "BucketName": s3_bucket
            }
        }
    )
    pprint.pprint(data_source_response)
    print(f"Data source created with ID {data_source_response["id"]}")
except ClientError as e:
    print(f"An error occurred {e}")
