Import-Module AWS.Tools.S3

$region = "eu-central-1"

## get name of intended bucket from user
$bucketName = Read-Host "Enter the name of the S3 bucket"

function Check-BucketExists {
    param (
        [string]$bucketName
    )
    try {
        Get-S3Bucket -BucketName $bucketName
        return $true
    } catch {
        return $false
    }
}

function Create-Bucket {
    param (
        [string]$bucketName,
        [string]$region
    )
    if (Check-BucketExists -bucketName $bucketName) {
        Write-Host "Bucket '$bucketName' already exists."
        return
    }
    try {
        New-S3Bucket -BucketName $bucketName -Region $region -ErrorAction Stop
        Write-Host "Bucket '$bucketName' created successfully in region '$region'."
    } catch {
        Write-Host "Error creating bucket: $_"
    }
}

Create-Bucket -bucketName $bucketName -region $region