"""An AWS Python Pulumi program"""

import pulumi
from pulumi_aws import s3, ec2

# Create an AWS resource (S3 Bucket)
bucket = s3.Bucket('my-bucket')

ec2 = ec2.Instance('my-instance',
    instance_type='t2.micro',
    ami='ami-0bae57ee7c4478e01',  # Amazon Linux 2 AMI
)

# Export the name of the bucket
pulumi.export('bucket_name', bucket.id)
