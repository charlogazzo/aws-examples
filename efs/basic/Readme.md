## setting up
```sh
sudo yum install -y amazon-efs-utils
sudo mkdir /mnt/efs
```

## Mount the file system (using efs file helper)

```sh
sudo mount -t efs -o tls fs-0284e10f6ad46eb24:/ efs
```

## mount (using nfs client)
```sh
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport fs-0284e10f6ad46eb24.efs.eu-central-1.amazonaws.com:/ efs
```